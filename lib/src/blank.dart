import 'package:Autosmart/src/perfil.dart';
import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:Autosmart/src/misvehiculos.dart';

void main() {
  runApp(const BlankApp());
}

class BlankApp extends StatelessWidget {
  const BlankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoSmart',
        style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 3, 18, 52),
      ),
      backgroundColor: const Color.fromARGB(255, 7, 32, 53),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 14, 50, 79),
              ),
              child: Text(
                'Menú Lateral',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PerfilApp()),
                );
              },
            ),
            ListTile(
              title: const Text('Mis Vehiculos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MisVehiculosApp()),
                );
              },
            ),
            ListTile(
              title: const Text('Ajustes'),
              onTap: () {
                // Acción a realizar cuando se selecciona la opción 2
              },
            ),
            // Este es el botón de "Volver"
            ListTile(
              title: const Text('Cerrar Sesion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Autosmart_LoginForm()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: const Text("He'd have you all unravel at the"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[200],
                    child: Column(
                      children: [
                        const Text('Heed not the rabble'),
                        Image.asset(
                            'assets/images/logo.jpg'), // Reemplaza 'tu_imagen.png' con la ubicación de tu imagen en el proyecto
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[300],
                    child: const Text('Sound of screams but the'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[500],
                    child: const Text('Revolution is coming...'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[600],
                    child: const Text('Revolution, they...'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
