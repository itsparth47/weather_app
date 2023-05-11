import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled/services/weather_service.dart';
import 'package:untitled/view/home_page.dart';

class LocationSelection extends StatefulWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  State<LocationSelection> createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {

  TextEditingController searchController = TextEditingController();

  String searchingCity = '';

  @override
  Widget build(BuildContext context) {

    WeatherService weatherService = WeatherService();

    return Stack(
      fit: StackFit.expand,
      children: [
        const Image(image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover,),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text('Select Location'),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value){
                    setState(() {
                      searchingCity = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    labelText: 'Search Cities',
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: weatherService.citiesListApi(searchingCity),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                        if(!snapshot.hasData){
                          return ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context,index){
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade100,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Container(height: 10, width: 89, color: Colors.white,),
                                          subtitle: Container(height: 10, width: 89, color: Colors.white,),
                                        )
                                      ],
                                    )
                                );
                              });
                        }
                        else{
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                              itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.25),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.white.withOpacity(.50)),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      searchingCity = snapshot.data![index]['lat'].toString()+' '+snapshot.data![index]['lon'].toString();
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(place: searchingCity)));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['name'], style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data![index]['region'], style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                          ),),
                                          Text(snapshot.data![index]['country'], style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                          ),),
                                        ],
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Latitude '+snapshot.data![index]['lat'].toString(), style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                          )),
                                          Text('Longitude '+snapshot.data![index]['lon'].toString(), style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              });
                        }
                      }
                  ))
            ],
          )
        )],
    );
  }
}
