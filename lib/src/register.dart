import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
    // Mensajes de Registro
    if (password != confirmPassword) {
      // Error en el registro, muestra un mensaje de error

      Fluttertoast.showToast(
        msg: 'Error en el registro, revisa las contraseñas',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (response.statusCode == 200) {
      // Registro exitoso, muestra un mensaje al usuario

      Fluttertoast.showToast(
        msg: 'Registro exitoso',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Autosmart_LoginForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Nombre
            SizedBox(height: 10.0),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),

            //Campo Apellido Paterno
            SizedBox(height: 10.0),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Apellido Paterno'),
            ),

            //Campo Apellido Materno
            SizedBox(height: 10.0),
            TextField(
              controller: _middleNameController,
              decoration: InputDecoration(labelText: 'Apellido Materno'),
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
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
              ),
            ),

            //Campo Correo Electronico
            SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),

            //Campo Contraseña
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),

            //Campo Confirmar Contraseña
            SizedBox(height: 10.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Confirmar Contraseña'),
            ),

            //Boton Registrarse
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
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
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
