class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      // cityName: json["main"]
      // Essa linha indica o caminho no arquivo json onde o dado em si vai ser encontrado. No caso, o nome da cidade não está em "main", e sim em "name"
      cityName: json["name"],
      temperature: json["main"]["temp"].toDouble(),
      mainCondition: json["weather"][0]["main"],
    );
  }
}
