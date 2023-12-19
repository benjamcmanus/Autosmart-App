import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Autosmart/src/misvehiculos.dart';

void main() {
  runApp(const VehiculosApp());
}

class VehiculosApp extends StatelessWidget {
  const VehiculosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VehiculosPage(),
    );
  }
}

class VehiculosPage extends StatefulWidget {
  const VehiculosPage({super.key});

  @override
  _VehiculosPageState createState() => _VehiculosPageState();
}

class _VehiculosPageState extends State<VehiculosPage> {
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _patenteController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1920),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != selectedDate) {
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
        title: const Text('Registro de Vehículo',style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 3, 18, 52),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 32, 53),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Marca
            const SizedBox(height: 10.0),
            TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                labelText: 'Marca del Vehículo',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Modelo
            const SizedBox(height: 10.0),
            TextField(
              controller: _modeloController,
              decoration: const InputDecoration(
                labelText: 'Modelo del Vehículo',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Año
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextField(
                  controller: _yearController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Nacimiento',
                    labelStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                    ),
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
                  ),
                  style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
                ),
              ),
            ),

            //Campo Placa
            const SizedBox(height: 10.0),
            TextField(
              controller: _patenteController,
              decoration: const InputDecoration(
                labelText: 'Número de Placa',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Botón Registrar
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerVehicle();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 33, 146, 7)), // Cambia el color del botón
              ),
              child: const Text('Registrar Vehículo',
                  style: TextStyle(color: Colors.white)),
            ),

            //Botón Volver
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MisVehiculosApp(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 168, 5, 5)), // Cambia el color del botón
              ),
              child: const Text('Volver', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
