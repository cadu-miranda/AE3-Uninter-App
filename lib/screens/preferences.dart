import 'package:ae3_uninter_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Preferences extends StatelessWidget {
  const Preferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(113, 51, 191, 1),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Preferências'),
        centerTitle: true,
      ),
    );
  }
}
