import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(RecoverUserApp());
}

class RecoverUserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RecoverUserPage(),
    );
  }
}

class RecoverUserPage extends StatefulWidget {
  @override
  _RecoverUserState createState() => _RecoverUserState();
}

class _RecoverUserState extends State<RecoverUserPage> {
  TextEditingController _emailController = TextEditingController();

  Future<void> recoverUser() async {
    final email = _emailController.text;

    final response = await http.post(
      Uri.parse('http://10.0.2.2/autosmart/recoverUser.php'),
      body: {
        'email': email,
      },
    );

    if (email == '') {
      // Si campo email esta vacio muestra mensaje "ingrese email"
      Fluttertoast.showToast(
        msg: 'Ingrese el email',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (response.statusCode == 404) {
      // El Email ingresado no esta registrado, muestra mensaje al usuario
      Fluttertoast.showToast(
        msg: 'El Email ingresado no esta registrado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } else if (response.statusCode == 200) {
      // Contraseña aleatoria generada, muestra un mensaje al usuario
      String password =
          "ContraseñaGenerada"; // Reemplaza esto con la contraseña generada
      Fluttertoast.showToast(
        msg: 'Ingreso exitoso, Contraseña aleatoria generada',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Muestra el AlertDialog con la contraseña generada
      showPasswordDialog(password = response.body);
    }
  }

  // Función para mostrar el AlertDialog con la contraseña generada
  void showPasswordDialog(String password) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contraseña Generada"),
          content: Text("La contraseña generada es: $password"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Autosmart_LoginForm()),
                );
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Correo Electronico
            SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),

            //Boton Enviar codigo de recuperacion
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                recoverUser();
              },
              child: Text('Generar contraseña temporal'),
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
