import 'package:flutter/material.dart';
import 'package:Autosmart/src/blank.dart';
import 'package:Autosmart/src/registrarvehiculo.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

void main() {
  runApp(MisVehiculosApp());
}

class MisVehiculosApp extends StatelessWidget {
  const MisVehiculosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PopupMenuApp(),
    );
  }
}

class PopupMenuApp extends StatelessWidget {
  const PopupMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xff6750a4),
        scaffoldBackgroundColor: const Color.fromARGB(255, 231, 231, 232),
      ),
      home: const PopupMenuExample(),
    );
  }
}

class PopupMenuExample extends StatefulWidget {
  const PopupMenuExample({super.key});

  @override
  State<PopupMenuExample> createState() => _PopupMenuExampleState();
}

class _PopupMenuExampleState extends State<PopupMenuExample> {
  SampleItem? selectedMenu;
  late GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
  }

  void _openMenu() {
    final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double top = offset.dy + renderBox.size.height;
    final double left = offset.dx;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, left + 100, top + 50),
      items: <PopupMenuEntry<SampleItem>>[
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemOne,
          child: Text('Registrar Vehiculo'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VehiculosApp(),
              ),
            );
          },
        ),
        const PopupMenuItem<SampleItem>(
          value: SampleItem.itemTwo,
          child: Text('Editar'),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.itemThree,
          child: Text('Volver'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlankApp(),
              ),
            );
          },
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedMenu = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Vehiculos'),
        backgroundColor: Color.fromARGB(255, 13, 125, 176),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlankApp(),
              ),
            ); // Navegar de regreso a la página anterior
          },
        ),
      ),
      body: Center(
        child: Text('Contenido principal'),
      ),
      floatingActionButton: FloatingActionButton(
        key: _key,
        onPressed: _openMenu,
        backgroundColor: Color.fromARGB(255, 51, 189, 120),
        child: Icon(Icons.add),
      ),
    );
  }
}
