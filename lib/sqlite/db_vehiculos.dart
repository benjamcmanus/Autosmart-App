import "package:Autosmart/sqlite/vehiculos.dart";
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'vehiculos.db'),
        onCreate: (db, version) {
      return db.execute(
        """CREATE TABLE vehiculos
          (idVehiculo INTEGER PRIMARY KEY, nombre TEXT, apellido1 TEXT, apellido2 TEXT, fechaNacimiento TEXT, email TEXT, password TEXT)""",
      );
    }, version: 1);
  }

  //Funcion para INSERT
  static Future<Future<int>> insert(Vehiculos vehiculos) async {
    Database database = await _openDB();

    return database.insert("vehiculos", vehiculos.toMap());
  }

  //Funcion para DELETE
  static Future<Future<int>> delete(Vehiculos vehiculos) async {
    Database database = await _openDB();

    return database.delete("vehiculos",
        where: "idVehiculo = ?", whereArgs: [vehiculos.idUsuario]);
  }

  //Funcion para UPDATE
  static Future<Future<int>> update(Vehiculos vehiculos) async {
    Database database = await _openDB();

    return database.update("vehiculos", vehiculos.toMap(),
        where: "idVehiculo = ?", whereArgs: [vehiculos.idUsuario]);
  }

  //Funcion para Listar Tabla vehiculos
  static Future<List<Vehiculos>> vehiculos() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> vehiuculosMap =
        await database.query("vehiculos");

    return List.generate(
        vehiuculosMap.length,
        (i) => Vehiculos(
            idVehiculo: vehiuculosMap[i]["idVehiculo"],
            marca: vehiuculosMap[i]["marca"],
            modelo: vehiuculosMap[i]["modelo"],
            ano: vehiuculosMap[i]["ano"],
            patente: vehiuculosMap[i]["patente"],
            idUsuario: vehiuculosMap[i]["idUsuarios"]));
  }
}
