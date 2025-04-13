import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/repository/buslines_repository.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'dart:convert';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

class BusLinesResults extends StatefulWidget {
  final String? cityFrom;
  final String? cityTo;
  final DateTime? date;

  BusLinesResults({
    Key? key,
    required this.cityFrom,
    required this.cityTo,
    required this.date,
  }) : super(key: key);

  @override
  _BusLinesResultsState createState() => _BusLinesResultsState();
}

class _BusLinesResultsState extends State<BusLinesResults> {
  final BuslinesRepository _buslinesRepository = BuslinesRepository();
  Future<BuslinesModel>? _futureBuslines;
  DateTime? _selectedDate;
  late final String? _selectedCityFrom;
  late final String? _selectedCityTo;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
    _selectedCityFrom = widget.cityFrom;
    _selectedCityTo = widget.cityTo;
    _fetchBuslines();
  }

  void _fetchBuslines() {
    setState(() {
      _futureBuslines = _buslinesRepository
          .fetch(
            startCity: _selectedCityFrom,
            endCity: _selectedCityTo,
            date: _selectedDate?.toIso8601String(),
          )
          .then((response) => BuslinesModel.fromJson(response));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relacija $_selectedCityFrom - $_selectedCityTo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            color: Colors.green,
            child: CalendarTimeline(
              initialDate: _selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2033, 12, 31),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date;
                  _fetchBuslines();
                });
              },
              leftMargin: 20,
              monthColor: const Color.fromARGB(136, 0, 0, 0),
              dayColor: Colors.white,
              activeDayColor: Colors.green,
              activeBackgroundDayColor: Colors.white,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'bs',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
          ),
          Expanded(
            child: FutureBuilder<BuslinesModel>(
              future: _futureBuslines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data!.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return const Center(child: Text("Nema dostupnih linija"));
                }

                final _buslines = snapshot.data!.data!;

                return ListView.builder(
                  itemCount: _buslines.length,
                  itemBuilder: (context, index) {
                    final busline = _buslines[index];
                    final company = busline.company;
                    final cityStart = busline.cityStart;
                    final cityEnd = busline.cityEnd;
                    final stations = busline.stations;

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  company!.imgLogo!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      company.name ?? 'No Company Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Relacija: ${cityStart!.name} - ${cityEnd!.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ...stations.map((station) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        station.city!.name as String,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        station.time!,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                ],
                              );
                            }).toList(),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                children: [
                                  if (busline.amenities!.wifi! == true)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                    BootstrapIcons.wifi,
                                    color: Colors.white,
                                    ),
                                  ),
                                  if (busline.amenities!.powerSockerts! == true)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                    BootstrapIcons.plug,
                                    color: Colors.white,
                                    ),
                                  ),
                                  if (busline.amenities!.airConditioning! == true)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                    BootstrapIcons.thermometer_snow,
                                    color: Colors.white,
                                    ),
                                  ),
                                  if (busline.amenities!.toilet! == true)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                    BootstrapIcons.badge_wc,
                                    color: Colors.white,
                                    ),
                                  ),
                                  if (busline.amenities!.entertrainment! == true)
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                                    decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    ),
                                    padding: EdgeInsets.all(6),
                                    child: Icon(
                                    BootstrapIcons.tv,
                                    color: Colors.white,
                                    ),
                                  ),
                                ],
                                ),
                              ElevatedButton(
                                onPressed: () {
                                // Add your onTap functionality here
                                },
                                style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                ),
                                child: Text('Rezervacija'),
                              ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
