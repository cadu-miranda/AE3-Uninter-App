import 'dart:async';
import 'dart:convert';
import '../classes/settings_manager.dart';
import '../models/sensor_data.dart';
import '../screens/settings.dart';
import '../widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<SensorData> fetchSensorData() async {
  String? ip = await SettingsManager.getEsp32IP();

  if (ip == null) {
    throw Exception('IP não configurado.');
  }

  const int port = 3490;

  String url = 'http://$ip:$port';

  final response = await http.get(Uri.parse("$url/data")).timeout(
    const Duration(seconds: 10),
    onTimeout: () {
      throw Exception('Falha ao carregar dados do sensor.');
    },
  );

  if (response.statusCode == 200) {
    final dynamic data = jsonDecode(response.body);

    return SensorData.fromJson(data);
  } else {
    throw Exception('Falha ao carregar dados do sensor.');
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<SensorData> _sensorData = Future.value(SensorData.empty());

  late String _esp32Ip = "";

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _loadEsp32IP();
  }

  void _loadEsp32IP() async {
    String? esp32Ip = await SettingsManager.getEsp32IP();

    if (esp32Ip != null) {
      setState(() {
        _esp32Ip = esp32Ip;
      });

      _sensorData = fetchSensorData();

      _loadUpdateInterval();
    }
  }

  void _loadUpdateInterval() async {
    int? savedInterval = await SettingsManager.getRefreshTime();

    if (savedInterval != null) {
      _timer?.cancel();

      _timer = Timer.periodic(Duration(seconds: savedInterval), (timer) {
        setState(() {
          _sensorData = fetchSensorData();
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: const CustomDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      body: _esp32Ip.isNotEmpty ? buildBody() : buildEmptyBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(113, 51, 191, 1),
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
        'Home',
        style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
    );
  }

  RefreshIndicator buildBody() {
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () {
        setState(() {
          _sensorData = fetchSensorData();
        });

        return _sensorData;
      },
      backgroundColor: Colors.white,
      color: Colors.green,
      child: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: FutureBuilder<SensorData>(
            future: _sensorData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${snapshot.data!.mcuData.temperature} °C',
                      style: GoogleFonts.roboto(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(113, 51, 191, 1),
                      ),
                    ),
                    Text(
                      '${snapshot.data!.mcuData.humidity} %',
                      style: GoogleFonts.roboto(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromRGBO(113, 51, 191, 1)),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(
                  '${snapshot.error}',
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: const Color.fromRGBO(113, 51, 191, 1)),
                );
              }

              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(113, 51, 191, 1)),
              );
            },
          ),
        ),
      ),
    );
  }

  Center buildEmptyBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 100,
            color: Color.fromRGBO(113, 51, 191, 1),
          ),
          const SizedBox(height: 24),
          const Text(
            'IP não configurado',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(113, 51, 191, 1),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: const Text('Configurar'),
          ),
        ],
      ),
    );
  }
}
