import '../screens/home.dart';
import '../screens/settings.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          buildHeader(context),
          buildItems(context),
        ],
      ),
    );
  }
}

Container buildHeader(BuildContext context) {
  return Container(
    color: const Color.fromRGBO(113, 51, 191, 1),
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: const Column(
      children: [
        CircleAvatar(
          radius: 48,
          child: Icon(Icons.person, size: 56),
        ),
        SizedBox(height: 12),
        Text(
          "Carlos E. Miranda",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "polomiranda@outlook.com",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    ),
  );
}

Container buildItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Home"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text("Configurações"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
          },
        ),
        const AboutListTile(
          icon: Icon(Icons.info_outlined),
          applicationName: 'ESP32 Wi-Fi Monitor',
          applicationVersion: 'v1.2.1 build 1',
          applicationLegalese:
              'Aplicativo desenvolvido por Carlos E. Miranda, aluno de Engenharia da Computação da Uninter',
          child: Text("Sobre"),
        )
      ],
    ),
  );
}
