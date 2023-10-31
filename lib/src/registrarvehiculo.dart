import 'package:flutter/material.dart';
import 'package:Autosmart/src/blank.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Autosmart/src/misvehiculos.dart';

void main() {
  runApp(VehiculosApp());
}

class VehiculosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VehiculosPage(),
    );
  }
}

class VehiculosPage extends StatefulWidget {
  @override
  _VehiculosPageState createState() => _VehiculosPageState();
}

class _VehiculosPageState extends State<VehiculosPage> {
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _patenteController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _yearController.text = "${picked.year}";
      });
    }
  }

  Future<void> registerVehicle() async {
    final marca = _marcaController.text;
    final modelo = _modeloController.text;
    final year = _yearController.text;
    final patente = _patenteController.text.toUpperCase();

    final response = await http.post(
      Uri.parse('http://10.0.2.2/autosmart/registrarvehiculo.php'),
      body: {
        'marca': marca,
        'modelo': modelo,
        'year': year,
        'patente': patente,
      },
    );
    if ((marca == '' && modelo == '' && year == '' && patente == '') ||
        (marca == '' || modelo == '' || year == '' && patente == '')) {
      Fluttertoast.showToast(
        msg: 'Complete los campos de registro',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 255, 3, 3),
        textColor: Colors.white,
      );
    } else if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'Registro exitoso del vehículo',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Vehículo'),
        backgroundColor: Color.fromARGB(255, 3, 18, 52),
      ),
      backgroundColor: Color.fromARGB(255, 7, 32, 53),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Marca
            SizedBox(height: 10.0),
            TextField(
              controller: _marcaController,
              decoration: InputDecoration(
                labelText: 'Marca del Vehículo',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Modelo
            SizedBox(height: 10.0),
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(
                labelText: 'Modelo del Vehículo',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Año
            SizedBox(height: 10.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: 'Fecha de Nacimiento',
                    labelStyle: TextStyle(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                    ),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
                  ),
                  style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
                ),
              ),
            ),

            //Campo Placa
            SizedBox(height: 10.0),
            TextField(
              controller: _patenteController,
              decoration: InputDecoration(
                labelText: 'Número de Placa',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Botón Registrar
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerVehicle();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                    255, 33, 146, 7)), // Cambia el color del botón
              ),
              child: Text('Registrar Vehículo',
                  style: TextStyle(color: Colors.white)),
            ),

            //Botón Volver
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MisVehiculosApp(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                    255, 168, 5, 5)), // Cambia el color del botón
              ),
              child: Text('Volver', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
