import '../classes/settings_manager.dart';
import '../widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _ipController = TextEditingController();

  final TextEditingController _refreshTimeController = TextEditingController();

  final _ipFormKey = GlobalKey<FormState>();

  final _refreshIntervalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  void _loadSavedData() async {
    String? savedIP = await SettingsManager.getEsp32IP();

    int? savedRefreshTime = await SettingsManager.getRefreshTime();

    if (savedIP != null) {
      _ipController.text = savedIP;
    }

    if (savedRefreshTime != null) {
      _refreshTimeController.text = savedRefreshTime.toString();
    }
  }

  void _saveData() async {
    if (_ipFormKey.currentState!.validate() &&
        _refreshIntervalFormKey.currentState!.validate()) {
      SettingsManager.saveEsp32IP(_ipController.text);

      SettingsManager.saveRefreshTime(
        _refreshTimeController.text.isEmpty
            ? 0
            : int.parse(_refreshTimeController.text),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configurações salvas com sucesso.'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(10),
        ),
      );
    }
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
        'Configurações',
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
            Form(
              key: _ipFormKey,
              child: TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(
                  labelText: 'Endereço IP',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um endereço IP.';
                  }

                  if (!isValidIP(value)) {
                    return 'Digite um endereço IP válido.';
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(height: 24.0),
            Form(
              key: _refreshIntervalFormKey,
              child: TextFormField(
                controller: _refreshTimeController,
                decoration: const InputDecoration(
                  labelText: 'Intervalo de atualização (segundos)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite um valor para o intervalo de atualização.';
                  }

                  int updateInterval = int.tryParse(value) ?? 0;

                  if (updateInterval < 10 || updateInterval > 60) {
                    return 'O intervalo de atualização deve estar entre 10 e 60 segundos.';
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidIP(String value) {
    RegExp ipRegExp = RegExp(
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}',
      caseSensitive: false,
      multiLine: false,
    );

    return ipRegExp.hasMatch(value);
  }
}
