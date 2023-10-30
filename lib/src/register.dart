import 'package:flutter/material.dart';
import 'package:Autosmart/sqlite/tablas.dart';
import 'package:Autosmart/sqlite/db_accionesCRUD.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Autosmart/src/login.dart';

void main() {
  runApp(RegisterApp());
}

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dobController.text = "${picked.year}/${picked.month}/${picked.day}";
      });
    }
  }

  Future<void> registerUser() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final middleName = _middleNameController.text;
    final dobController = _dobController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Verifica si las contraseñas coinciden
    if (password != confirmPassword) {
      // Error en el registro
      Fluttertoast.showToast(
        msg: 'Error en registro, revisa',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else {
      // Contraseñas coinciden, procede al registro
      Usuarios newUser = Usuarios(
        idUsuario: null,
        nombre: firstName,
        apellido1: lastName,
        apellido2: middleName,
        fechaNacimiento: dobController,
        email: email,
        password: password,
      );

      // Insertar a BD Sqlite
      Future<int> resultSQLite = await DB_Usuarios.insert(newUser);

      // Insertar a BD MySQL
      final response = await http.post(
        Uri.parse('http://10.0.2.2/autosmart/register.php'),
        body: {
          'firstName': firstName,
          'lastName': lastName,
          'middleName': middleName,
          'dobController': dobController,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (resultSQLite != -1 && response.statusCode == 200) {
        // Registration successful in both databases
        Fluttertoast.showToast(
          msg: 'Registration successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        // Handle registration failure (e.g., database errors)
        Fluttertoast.showToast(
          msg: 'Registration failed. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Color.fromARGB(255, 3, 18, 52),
      ),
      backgroundColor: Color.fromARGB(255, 7, 32, 53),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Nombre
            SizedBox(height: 10.0),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Apellido Paterno
            SizedBox(height: 10.0),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Apellido Paterno',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Apellido Materno
            SizedBox(height: 10.0),
            TextField(
              controller: _middleNameController,
              decoration: InputDecoration(
                labelText: 'Apellido Materno',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Fecha de Nacimiento
            SizedBox(height: 10.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextField(
                  controller: _dobController,
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

            //Campo Correo Electronico
            SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'E-Mail',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Contraseña
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Confirmar Contraseña
            SizedBox(height: 10.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Boton Registrarse
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                    255, 33, 146, 7)), // Cambia el color del botón
              ),
              child: Text('Registrar'),
            ),

            //Boton Volver
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Autosmart_LoginForm()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(
                    255, 134, 2, 24)), // Cambia el color del botón
              ),
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
