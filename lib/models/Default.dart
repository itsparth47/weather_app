class Weather {
  final String city;
  final String icon;
  final double temperatureC;
  final double temperatureF;
  final String condition;
  final double windSpeed;
  final int windDegree;
  final double pressure;
  final double precipitation;
  final double maxtemp;
  final double mintemp;
  final double latitude;
  final double longitude;

  Weather({
    this.city = 'ABC',
    this.icon = '',
    this.temperatureC = 0,
    this.temperatureF = 0,
    this.condition = "Sunny",
    this.windSpeed = 0,
    this.windDegree = 0,
    this.pressure = 0,
    this.precipitation = 0,
    this.maxtemp = 0,
    this.mintemp = 0,
    this.latitude = 0,
    this.longitude = 0
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      icon: json['current']['condition']['icon'],
      city: json['location']['name'],
      temperatureC: json['current']['temp_c'],
      temperatureF: json['current']['temp_f'],
      condition: json['current']['condition']['text'],
      windSpeed: json['current']['wind_mph'],
      windDegree: json['current']['wind_degree'],
      pressure: json['current']['pressure_mb'],
      precipitation: json['current']['precip_mm'],
      maxtemp: json['forecast']['forecastday'][0]['day']['maxtemp_c'],
      mintemp: json['forecast']['forecastday'][0]['day']['mintemp_c'],
      latitude: json['location']['lat'],
      longitude: json['location']['lat'],
    );
  }
}