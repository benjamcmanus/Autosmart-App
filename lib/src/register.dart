import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        )) ??
        DateTime.now();

    if (picked != selectedDate) {
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
        MaterialPageRoute(builder: (context) => const Autosmart_LoginForm()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: const Color.fromARGB(255, 3, 18, 52),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 32, 53),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Nombre
            const SizedBox(height: 10.0),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Apellido Paterno
            const SizedBox(height: 10.0),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido Paterno',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),
            //Campo Apellido Materno
            const SizedBox(height: 10.0),
            TextField(
              controller: _middleNameController,
              decoration: const InputDecoration(
                labelText: 'Apellido Materno',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Fecha de Nacimiento
            const SizedBox(height: 10.0),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: TextField(
                  controller: _dobController,
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

            //Campo Correo Electronico
            const SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'E-Mail',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Contraseña
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Campo Confirmar Contraseña
            const SizedBox(height: 10.0),
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar Contraseña',
                labelStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255,
                        255)), // Cambia el color del texto del label
                hintStyle: TextStyle(color: Color.fromARGB(255, 243, 243, 243)),
              ),
              style: const TextStyle(color: Color.fromARGB(255, 210, 228, 15)),
            ),

            //Boton Registrarse
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                registerUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 33, 146, 7)), // Cambia el color del botón
              ),
              child: const Text('Registrar', style: TextStyle(color: Colors.white)),
            ),

            //Boton Volver
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Autosmart_LoginForm()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
                    255, 134, 2, 24)), // Cambia el color del botón
              ),
              child: const Text('Volver',style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
