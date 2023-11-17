import 'package:ae3_uninter_app/screens/about.dart';
import 'package:ae3_uninter_app/screens/home.dart';
import 'package:ae3_uninter_app/screens/preferences.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildHeader(context),
          buildItems(context),
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
                  "1.1.0",
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
