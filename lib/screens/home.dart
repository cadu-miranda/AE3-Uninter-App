import 'dart:async';
import 'dart:convert';
import 'package:ae3_uninter_app/models/sensor_data.dart';
import 'package:ae3_uninter_app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<SensorData> fetchSensorData() async {
  final response = await http.get(Uri.parse('http://192.168.0.202:3490/data'));

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
  late Future<SensorData> sensorData;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    sensorData = fetchSensorData();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        sensorData = fetchSensorData();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(113, 51, 191, 1),
      drawer: const CustomDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () {
          setState(() {
            sensorData = fetchSensorData();
          });

          return sensorData;
        },
        backgroundColor: Colors.white,
        color: Colors.green,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: FutureBuilder<SensorData>(
              future: sensorData,
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
                            color: Colors.white),
                      ),
                      Text(
                        '${snapshot.data!.mcuData.humidity} %',
                        style: GoogleFonts.roboto(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.white,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
