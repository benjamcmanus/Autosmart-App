import 'package:Autosmart/src/blank.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:Autosmart/src/register.dart';
import 'package:Autosmart/src/recuperarContraseña.dart';

void main() {
  runApp(Autosmart_LoginForm());
}

class Autosmart_LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://10.0.2.2/autosmart/login.php'),
      body: {
        'email': email,
        'password': password,
      },
    );

    // Verificar si el correo está en la base de datos
    if ((email == '' && password == '') || (email == '' || password == '')) {
      Fluttertoast.showToast(
        msg: 'Complete los campos de inicio de sesion',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 255, 3, 3),
        textColor: Colors.white,
      );

      ;
    } else if (response.statusCode == 200) {
        List<String> responseParts = response.body.split(',');

        if (responseParts.length == 3) {
          String successMessage = responseParts[0];
          String userName = responseParts[1];
          String userId = responseParts[2];

          // Muestra el toast con el nombre y el ID del usuario
          Fluttertoast.showToast(
            msg: '$successMessage\nNombre: $userName (ID: $userId)',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          
          // Redirecciona a la página en blanco
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlankApp()),
          );
        }
      // Correo no encontrado en la base de datos, mostrar un mensaje de error
    } else if (response.statusCode == 404) {
      Fluttertoast.showToast(
        msg:
            'Email no encontrado. Por favor, regístrate si eres un nuevo usuario.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
        msg: 'Contraseña incorrecta, Por favor, intente nuevamente',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            // Campo Correo Electrónico
            SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),

            // Campo Contraseña
            SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),

            // Botón Iniciar Sesión
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: Text('Iniciar Sesión'),
            ),

            // Botón Registrarse
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterApp()),
                );
              },
              child: Text('Registrarse'),
            ),

            // Botón Login como invitado
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlankApp()),
                );
              },
              child: Text('Iniciar Sesión Como Invitado'),
            ),

            // Botón Recuperar Contraseña
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecoverUserApp()),
                );
              },
              child: Text('Recuperar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
