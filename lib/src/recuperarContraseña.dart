import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const RecoverUserApp());
}

class RecoverUserApp extends StatelessWidget {
  const RecoverUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RecoverUserPage(),
    );
  }
}

class RecoverUserPage extends StatefulWidget {
  const RecoverUserPage({super.key});

  @override
  _RecoverUserState createState() => _RecoverUserState();
}

class _RecoverUserState extends State<RecoverUserPage> {
  final TextEditingController _emailController = TextEditingController();

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
          title: const Text("Contraseña Generada"),
          content: Text("La contraseña generada es: $password"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Autosmart_LoginForm()),
                );
              },
              child: const Text("Cerrar"),
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
        title: const Text('Recuperar Contraseña'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            //Campo Correo Electronico
            const SizedBox(height: 10.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail'),
            ),

            //Boton Enviar codigo de recuperacion
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                recoverUser();
              },
              child: const Text('Generar contraseña temporal'),
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
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
