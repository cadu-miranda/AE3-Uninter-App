import '../screens/home.dart';
import '../screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          "Software Developer",
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
          leading: const Icon(Icons.home_outlined, size: 28),
          title: Text(
            "Home",
            style: GoogleFonts.roboto(fontSize: 18),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings_outlined, size: 28),
          title: Text(
            "Configurações",
            style: GoogleFonts.roboto(fontSize: 18),
          ),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Settings()),
            );
          },
        ),
        AboutListTile(
          icon: const Icon(Icons.info_outlined, size: 28),
          applicationName: 'ESP32 Wi-Fi Monitor',
          applicationVersion: 'v1.2.2 build 1',
          applicationLegalese:
              'Aplicativo desenvolvido por Carlos E. Miranda, aluno de Engenharia da Computação da Uninter.',
          child: Text(
            "Sobre",
            style: GoogleFonts.roboto(fontSize: 18),
          ),
        )
      ],
    ),
  );
}
