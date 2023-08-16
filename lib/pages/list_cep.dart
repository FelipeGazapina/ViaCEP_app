import 'package:flutter/material.dart';
import 'package:via_cep_app/models/viacep_model.dart';
import 'package:via_cep_app/repository/viacep_repository.dart';

class ListCEPPage extends StatefulWidget {
  const ListCEPPage({super.key});

  @override
  State<ListCEPPage> createState() => _ListCEPPageState();
}

class _ListCEPPageState extends State<ListCEPPage> {
  ViaCEPRepository repository = ViaCEPRepository();
  List<ViaCEPModel> listaVia = [];

  fetchData() async {
    if (repository.database == null) await settingDatabase();
    listaVia = await repository.listagemInfoCEP();
    setState(() {});
  }

  settingDatabase() async {
    await repository.settingDatabase();
    fetchData();
  }

  @override
  void initState() {
    settingDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Histórico de pesquisa"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Text(
                'Puxe para a esquerda para deletar',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: ListView.builder(
                    itemCount: listaVia.length,
                    itemBuilder: (_, idx) {
                      var viaCEP = listaVia[idx];
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_) async {
                          await repository.removeInfo(viaCEP.id!);
                          setState(() {
                            listaVia.removeAt(idx);
                          });
                        },
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.red.shade400,
                              borderRadius: BorderRadius.circular(8)),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          padding: const EdgeInsets.only(right: 6),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text(viaCEP.cep!),
                            subtitle: Text(
                              viaCEP.logradouro!,
                              style: const TextStyle(fontSize: 12),
                            ),
                            trailing: Text(
                              "${viaCEP.localidade}/${viaCEP.uf}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
