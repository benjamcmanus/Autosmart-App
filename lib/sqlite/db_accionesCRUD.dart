import 'package:Autosmart/sqlite/tablas.dart';
import "package:sqflite/sqflite.dart";
import "package:path/path.dart";

class DB_Usuarios {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'usuarios.db'),
        onCreate: (db, version) {
      return db.execute(
        """CREATE TABLE usuarios
          (idUsuario INTEGER PRIMARY KEY, nombre TEXT, apellido1 TEXT, apellido2 TEXT, fechaNacimiento TEXT, email TEXT, password TEXT)""",
      );
    }, version: 1);
  }

  //Funcion para INSERT
  static Future<Future<int>> insert(Usuarios usuarios) async {
    Database database = await _openDB();

    return database.insert("usuarios", usuarios.toMap());
  }

  //Funcion para DELETE
  static Future<Future<int>> delete(Usuarios usuarios) async {
    Database database = await _openDB();

    return database.delete("usuarios",
        where: "idUsuarios = ?", whereArgs: [usuarios.idUsuario]);
  }

  //Funcion para UPDATE
  static Future<Future<int>> update(Usuarios usuarios) async {
    Database database = await _openDB();

    return database.update("usuarios", usuarios.toMap(),
        where: "idUsuarios = ?", whereArgs: [usuarios.idUsuario]);
  }

  //Funcion para Listar Tabla usuarios
  static Future<List<Usuarios>> usuarios() async {
    Database database = await _openDB();

    final List<Map<String, dynamic>> usuariosMap =
        await database.query("usuarios");

    return List.generate(
        usuariosMap.length,
        (i) => Usuarios(
            idUsuario: usuariosMap[i]["idUsuario"],
            nombre: usuariosMap[i]["nombre"],
            apellido1: usuariosMap[i]["apellido1"],
            apellido2: usuariosMap[i]["apellido2"],
            fechaNacimiento: usuariosMap[i]["fechaNacimiento"],
            email: usuariosMap[i]["email"],
            password: usuariosMap[i]["password"]));
  }
}

class DB_Vehiculos {
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
