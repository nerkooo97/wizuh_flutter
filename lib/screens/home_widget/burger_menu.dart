import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Naslov aplikacije'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Otvara bočni meni
              Scaffold.of(context).openDrawer();
            },
          ),
        ],
      ),
      drawer: SideMenu(), // Ovdje pozivate SideMenu
      body: Center(
        child: Text('Sadržaj aplikacije'),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green, // Boja zaglavlja menija
            ),
            child: Text(
              'Meni', 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Početna'),
            onTap: () {
              Navigator.pop(context); // Zatvori meni
              print('Početna odabrana');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Postavke'),
            onTap: () {
              Navigator.pop(context); // Zatvori meni
              print('Postavke odabrane');
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('O aplikaciji'),
            onTap: () {
              Navigator.pop(context); // Zatvori meni
              print('O aplikaciji odabrano');
            },
          ),
        ],
      ),
    );
  }
}
