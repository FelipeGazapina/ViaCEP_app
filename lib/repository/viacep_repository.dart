import 'package:sqflite/sqflite.dart';
import 'package:via_cep_app/connections/viacep_connection.dart';
import 'package:via_cep_app/database/database.dart';
import 'package:via_cep_app/models/viacep_model.dart';

class ViaCEPRepository {
  var viaConnection = ViaCEPConnection();
  late Database _db;

  Database get database => _db;

  settingDatabase() async {
    _db = await SqliteDatabase.getDatabase();
  }

  Future<ViaCEPModel> buscaInfoCEP(String cep) async {
    var response = await viaConnection.dio.get('/$cep');
    ViaCEPModel viaCEPModel = ViaCEPModel.fromJson(response.data);
    return viaCEPModel;
  }

  Future<void> adicionarInfoCEP(ViaCEPModel viaCEPModel) async {
    String query =
        "INSERT INTO pesquisas (cep, logradouro, bairro, localidade, uf) VALUES (?, ?, ?, ?, ?)";
    await _db.rawInsert(query, [
      viaCEPModel.cep,
      viaCEPModel.logradouro,
      viaCEPModel.bairro,
      viaCEPModel.localidade,
      viaCEPModel.uf
    ]);
  }

  // Future<void> altTarefa(int id, bool conc) async {
  //   var result = await _db.rawUpdate(
  //       "UPDATE pesquisas SET cep = ?, logradouro = ?, WHERE id = ?", [id, conc ? 1 : 0]);
  // }

  Future<void> removeInfo(int id) async {
    var result =
        await _db.rawDelete("DELETE FROM pesquisas WHERE id = ?", [id]);
  }

  Future<List<ViaCEPModel>> listagemInfoCEP() async {
    var result = await _db.rawQuery('SELECT * FROM pesquisas');
    List<ViaCEPModel> listaVia = [];

    for (var element in result) {
      var help = ViaCEPModel();
      help.id = int.parse(element['id'].toString());
      help.cep = element['cep'].toString();
      help.logradouro = element['logradouro'].toString();
      help.bairro = element['bairro'].toString();
      help.localidade = element['localidade'].toString();
      help.uf = element['uf'].toString();
      listaVia.add(help);
    }

    return listaVia;
  }
}
