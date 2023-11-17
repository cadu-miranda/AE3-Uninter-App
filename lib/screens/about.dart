import 'package:ae3_uninter_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const CustomDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Sobre',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: const Column(
          children: [
            SizedBox(height: 24),
            Text(
              "O aplicativo foi desenvolvido por Carlos E. Miranda, aluno de Engenharia da Computação da Uninter.",
              style: TextStyle(
                color: Color.fromRGBO(113, 51, 191, 1),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Sistema desenvolvido para a Atividade Extensionista III e tem como objetivo a criação de um sistema de monitoramento de temperatura e umidade utilizando um microcontrolador ESP32 e um sensor DHT11.",
              style: TextStyle(
                color: Color.fromRGBO(113, 51, 191, 1),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "O aplicativo foi desenvolvido utilizando a linguagem Dart e o framework Flutter, que permite a criação de aplicativos para Android, iOS, Windows, Linux e MacOS, utilizando uma única base de código.",
              style: TextStyle(
                color: Color.fromRGBO(113, 51, 191, 1),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
