class Usuarios {
  int? idUsuario;
  String nombre;
  String apellido1;
  String apellido2;
  String fechaNacimiento;
  String email;
  String password;

  Usuarios(
      {required this.idUsuario,
      required this.nombre,
      required this.apellido1,
      required this.apellido2,
      required this.fechaNacimiento,
      required this.email,
      required this.password});

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': idUsuario,
      'nombre': nombre,
      'apellido1': apellido1,
      'apellido2': apellido2,
      'fechaNacimiento': fechaNacimiento,
      'email': email,
      'password': password
    };
  }
}

class Vehiculos {
  int idVehiculo;
  String marca;
  String modelo;
  String ano;
  String patente;
  String idUsuario;

  Vehiculos(
      {required this.idVehiculo,
      required this.marca,
      required this.modelo,
      required this.ano,
      required this.patente,
      required this.idUsuario});

  Map<String, dynamic> toMap() {
    return {
      'idVehiculo': idVehiculo,
      'marca': marca,
      'modelo': modelo,
      'ano': ano,
      'patente': patente,
      'idUsuario': idUsuario
    };
  }
}
