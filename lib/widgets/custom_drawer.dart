import 'package:ae3_uninter_app/screens/about.dart';
import 'package:ae3_uninter_app/screens/home.dart';
import 'package:ae3_uninter_app/screens/preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildHeader(context),
          buildMenuItems(context),
          buildFooter(context)
        ],
      ),
    );
  }
}

Container buildHeader(BuildContext context) {
  return Container(
    color: const Color.fromRGBO(113, 51, 191, 1),
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: const Column(
      children: [
        CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1699954074200-b4c4bd64bd79?q=80&w=1927&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
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

Container buildMenuItems(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Preferências"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Preferences()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text("Sobre"),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const About()),
            );
          },
        ),
      ],
    ),
  );
}

Container buildFooter(BuildContext context) {
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
