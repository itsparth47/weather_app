import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled/models/Default.dart';

class WeatherService {
  Future<Weather> getWeatherData(String place) async {
    try {
      final queryParameters = {
        'key': '580543128fac482d9b241428232804',
        'q': place,
      };
      final uri = Uri.http('api.weatherapi.com', '/v1/forecast.json', queryParameters);
      final response = await http.get(uri);
      if(response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Cannot get data");
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<List<dynamic>> citiesListApi (String city) async{
    final queryParameters = {
      'key': '580543128fac482d9b241428232804',
      'q': city,
    };
    var data;
    final uri = Uri.http('api.weatherapi.com', '/v1/search.json', queryParameters);
    final response = await http.get(uri);
    if(response.statusCode==200){
      data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> forecastApi (String city) async{
    final queryParameters = {
      'key': '580543128fac482d9b241428232804',
      'q': city,
    };
    var data;
    final uri = Uri.http('api.weatherapi.com', '/v1/forecast.json', queryParameters);
    final response = await http.get(uri);
    if(response.statusCode==200){
      data = jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');
    }
  }
}