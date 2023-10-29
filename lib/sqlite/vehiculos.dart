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
