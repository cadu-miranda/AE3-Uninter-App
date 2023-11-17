class McuData {
  double temperature;
  int humidity;

  McuData({required this.temperature, required this.humidity});

  McuData.fromJson(Map<String, dynamic> json)
      : temperature = json['temperature'],
        humidity = json['humidity'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['temperature'] = temperature;
    data['humidity'] = humidity;

    return data;
  }
}

class SensorData {
  McuData mcuData;

  SensorData({required this.mcuData});

  factory SensorData.empty() {
    return SensorData(mcuData: McuData(temperature: 0, humidity: 0));
  }

  SensorData.fromJson(Map<String, dynamic> json)
      : mcuData = McuData.fromJson(json['mcu_data']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['mcu_data'] = mcuData.toJson();

    return data;
  }
}
