import 'package:Autosmart/src/blank.dart';
import 'package:flutter/material.dart';
import 'package:Autosmart/src/login.dart';
import 'package:Autosmart/src/misvehiculos.dart';

void main() {
  runApp(PerfilApp());
}

class PerfilApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoSmart'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
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
              title: Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BlankApp()),
                );
              },
            ),
            ListTile(
              title: Text('Mis Vehiculos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MisVehiculosApp()),
                );
              },
            ),
            ListTile(
              title: Text('Ajustes'),
              onTap: () {
                // Acción a realizar cuando se selecciona la opción 2
              },
            ),
            // Este es el botón de "Volver"
            ListTile(
              title: Text('Cerrar Sesion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Autosmart_LoginForm()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Contenido principal de la aplicación'),
      ),
    );
  }
}
