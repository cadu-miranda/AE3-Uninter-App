import 'package:ae3_uninter_app/classes/preferences_manager.dart';
import 'package:ae3_uninter_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  final TextEditingController _ipController = TextEditingController();

  final TextEditingController _refreshTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  void _loadSavedData() async {
    String? savedIP = await PreferencesManager.getEsp32IP();

    int? savedRefreshTime = await PreferencesManager.getRefreshTime();

    if (savedIP != null) {
      _ipController.text = savedIP;
    }

    if (savedRefreshTime != null) {
      _refreshTimeController.text = savedRefreshTime.toString();
    }
  }

  void _saveData() async {
    PreferencesManager.saveEsp32IP(_ipController.text);

    PreferencesManager.saveRefreshTime(
      _refreshTimeController.text.isEmpty
          ? 0
          : int.parse(_refreshTimeController.text),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Preferências salvas com sucesso.'),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const CustomDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveData,
        label: const Text('Salvar'),
        icon: const Icon(Icons.save),
      ),
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
        'Preferências',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  SingleChildScrollView buildBody() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            TextField(
              controller: _ipController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Endereço IP',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _refreshTimeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tempo de atualização (segundos)',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
