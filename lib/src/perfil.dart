import 'package:Autosmart/src/blank.dart';
import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:Autosmart/src/misvehiculos.dart';


void main() {
  runApp(const PerfilApp());
}

class PerfilApp extends StatelessWidget {
  const PerfilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoSmart'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú Lateral',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BlankApp()),
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
      body: const Center(
        child: Text('Contenido principal de la aplicación'),
      ),
    );
  }
}
