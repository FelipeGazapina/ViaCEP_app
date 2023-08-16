import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({super.key, required this.chave, this.valor});
  String? valor;
  final String chave;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$chave: ",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Text(valor ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
