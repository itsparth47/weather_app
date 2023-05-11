import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/view/home_page.dart';
import 'package:untitled/view/location.dart';

class PopularCities extends StatefulWidget {
  const PopularCities({Key? key}) : super(key: key);

  @override
  State<PopularCities> createState() => _PopularCitiesState();
}

class _PopularCitiesState extends State<PopularCities> {
  final List cities = [
    'New Delhi',
    'Washington',
    'London',
    'Paris',
    'Rome',
    'Melbourne'
  ];

  final List countries = [
    'India',
    'United States of America',
    'United Kingdom',
    'France',
    'Italy',
    'Australia'
  ];

  final List regions = [
    'Delhi',
    'District of Columbia',
    'City of London, Greater London',
    'Ile-de-France',
    'Lazio',
    'Victoria'
  ];

  final List lat = ['28.6', '38.9', '51.52', '48.87', '41.9', '-37.82'];

  final List long = ['77.2', '-77.04', '-0.11', '2.33', '12.48', '144.97'];

  String passingPlace = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Cities',
                      style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationSelection()));
                      },
                      child: Text(
                        'Or Search a City',
                        style: GoogleFonts.quicksand(
                            color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.25),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.white.withOpacity(.50)),
                            ),
                            child: InkWell(
                              onTap: () {
                                passingPlace = lat[index]+ ' ' +long[index];
                                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(
                                  place : passingPlace
                                )));
                              },
                              child: ListTile(
                                title: Text(
                                  cities[index],
                                  style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      regions[index],
                                      style: GoogleFonts.quicksand(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      countries[index],
                                      style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Latitude ' + lat[index],
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                        )),
                                    Text('Longitude ' + long[index],
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
