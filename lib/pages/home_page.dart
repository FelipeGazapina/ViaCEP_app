import 'package:flutter/material.dart';
import 'package:via_cep_app/pages/list_cep.dart';
import 'package:via_cep_app/pages/search_cep.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          width: 250,
          height: 180,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)]),
          child: Column(children: [
            const SizedBox(height: 15),
            const Text(
              "ViaCEP",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    elevation:
                        MaterialStateProperty.resolveWith((states) => 2)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SearchCEPPage()));
                },
                child: const Text(
                  "Pesquisar CEP",
                  style: TextStyle(color: Colors.black87),
                )),
            const SizedBox(height: 10),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    elevation:
                        MaterialStateProperty.resolveWith((states) => 2)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ListCEPPage()));
                },
                child: const Text(
                  "Listagem de CEP",
                  style: TextStyle(color: Colors.black87),
                )),
          ]),
        ),
      ),
    );
  }
}
