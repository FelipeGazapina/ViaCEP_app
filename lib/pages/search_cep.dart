import 'package:flutter/material.dart';
import 'package:via_cep_app/components/Info_component.dart';
import 'package:via_cep_app/models/viacep_model.dart';
import 'package:via_cep_app/repository/viacep_repository.dart';

class SearchCEPPage extends StatefulWidget {
  const SearchCEPPage({super.key});

  @override
  State<SearchCEPPage> createState() => _SearchCEPPageState();
}

class _SearchCEPPageState extends State<SearchCEPPage> {
  ViaCEPRepository repository = ViaCEPRepository();

  TextEditingController cepControler = TextEditingController(text: "");
  ViaCEPModel viaCEPModel = ViaCEPModel();
  String message = "";
  bool error = false;
  bool loading = false;

  saveViaCEP() async {
    await repository.adicionarInfoCEP(viaCEPModel);
  }

  handleClick() async {
    try {
      if (repository.database == null) await settingDatabase();
      var cep = cepControler.text.replaceAll(RegExp(r'[^\w\s]'), '');
      viaCEPModel = await repository.buscaInfoCEP(cep);
      cepControler.text = "";
      error = false;

      if (viaCEPModel.logradouro != "" && viaCEPModel.logradouro != null) {
        await saveViaCEP();
      }
    } catch (e) {
      message = "Verifique se o CEP esta correto.";
      error = true;
    }

    loading = false;
    setState(() {});
  }

  settingDatabase() async {
    await repository.settingDatabase();
  }

  @override
  void initState() {
    settingDatabase();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(children: [
          const Text(
            "Verifique seu endereço pelo CEP:",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          TextField(
            controller: cepControler,
            decoration: const InputDecoration(hintText: "88010-000"),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(color: (error) ? Colors.red : Colors.green),
              ),
              const SizedBox(width: 10),
              (loading)
                  ? CircularProgressIndicator(
                      color: MaterialStateColor.resolveWith(
                          (states) => Colors.blue),
                    )
                  : TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Colors.blueGrey.shade400)),
                      onPressed: () async {
                        viaCEPModel = ViaCEPModel();
                        loading = true;
                        message = "";
                        setState(() {});
                        handleClick();
                      },
                      child: const Text(
                        "Pesquisar",
                        style: TextStyle(color: Colors.white),
                      )),
            ],
          ),
          const SizedBox(height: 25),
          Column(children: [
            Info(chave: 'Rua', valor: viaCEPModel.logradouro),
            Info(chave: 'Bairro', valor: viaCEPModel.bairro),
            Info(chave: 'Cidade', valor: viaCEPModel.localidade),
            Info(chave: 'Estado', valor: viaCEPModel.uf),
          ])
        ]),
      ),
    );
  }
}
