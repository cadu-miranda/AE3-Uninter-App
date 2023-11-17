import 'package:ae3_uninter_app/screens/about.dart';
import 'package:ae3_uninter_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(113, 51, 191, 1),
            ),
            child: Icon(
              Icons.person,
              size: 100,
              color: Colors.white,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              "Home",
              style: GoogleFonts.roboto(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(
              'Sobre',
              style: GoogleFonts.roboto(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const About(),
                ),
              );
            },
          ),
          footer(context)
        ],
      ),
    );
  }
}

Container footer(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    child: const Column(
      children: [
        Divider(),
        SizedBox(height: 8),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Versão"),
                Text(
                  "1.0.1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Build"),
                Text(
                  "1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
