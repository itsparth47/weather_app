import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/models/Default.dart';
import 'package:untitled/services/weather_service.dart';

class HomePage extends StatefulWidget {

  String place;
  HomePage({super.key,
    required this.place
});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Weather weather = Weather();
  WeatherService weatherService = WeatherService();

  int count = 24;
  double tempC = 0;
  String condition = '';
  double press = 0;
  double preci = 0;
  double tempH = 0;
  double tempL = 0;
  double ws = 0;
  int wd = 0;
  String name = '';
  String wicon = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async {
    weather = await weatherService.getWeatherData(widget.place);
    setState(() {
      name = weather.city;
      tempC = weather.temperatureC;
      condition = weather.condition;
      press = weather.pressure;
      preci = weather.precipitation;
      tempH = weather.maxtemp;
      tempL = weather.mintemp;
      ws = weather.windSpeed;
      wd = weather.windDegree;
      wicon = weather.icon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
              fit: StackFit.expand,
              children: [
                const Image(image: AssetImage('assets/bg.jpg',),fit: BoxFit.cover,),
                      SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 100,),
                            Text(name, style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),),
                            Text('$tempC°C', style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 70,
                            ),),
                            Text(condition, style: GoogleFonts.quicksand(
                                color: Colors.white70,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                            Image(image: NetworkImage('https:$wicon'),
                                  width: 100,
                                  height: 100,),
                            Text('H $tempH°C       L $tempL°C', style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),
                      ),
                DraggableScrollableSheet(
                      initialChildSize: 0.3,
                      minChildSize: 0.3,
                      maxChildSize: 0.5,
                      builder: (context, controller) => Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50)
                              ),
                              color: Colors.white.withOpacity(.25)
                          ),
                          child: ListView(
                            controller: controller,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 6),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            if(count == 7){
                                              setState(() {
                                                count = 24;
                                              });
                                            }
                                          },
                                          child: Text('Hourly Forecast', style: GoogleFonts.quicksand(
                                              color: Colors.white.withOpacity(.45),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                          ),),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            if(count == 24){
                                              setState(() {
                                                count = 7;
                                              });
                                            }
                                          },
                                          child: Text('Weekly Forecast', style: GoogleFonts.quicksand(
                                              color: Colors.white.withOpacity(.45),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                          ),),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 4,
                                    color: Colors.white.withOpacity(.25),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 160,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: count,
                                              itemBuilder: (context,index){
                                                return Padding(
                                                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 3, right: 3),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.white.withOpacity(.50)),
                                                      borderRadius: BorderRadius.circular(70),
                                                      color: Colors.white.withOpacity(.20),
                                                    ),
                                                    width: 60,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('$index:00', style: GoogleFonts.quicksand(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text('12', style: GoogleFonts.quicksand(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                          )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            border: Border.all(color: Colors.white.withOpacity(.5)),
                                            color: Colors.white.withOpacity(.25)
                                          ),
                                          height: MediaQuery.of(context).size.height*0.16,
                                          width: MediaQuery.of(context).size.width*0.45,
                                          child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text('Wind Speed', style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text('$ws mph', style: GoogleFonts.quicksand(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text('Wind Degree', style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                  ),),
                                                  Text('$wd°', style: GoogleFonts.quicksand(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(color: Colors.white.withOpacity(.5)),
                                              color: Colors.white.withOpacity(.25)
                                          ),
                                          height: MediaQuery.of(context).size.height*0.16,
                                          width: MediaQuery.of(context).size.width*0.45,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text('Pressure', style: GoogleFonts.quicksand(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                    Text('$press mb', style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Precipitation', style: GoogleFonts.quicksand(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                    Text('$preci mm', style: GoogleFonts.quicksand(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
              ]
          )
    );
  }
}
