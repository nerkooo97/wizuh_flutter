import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/event_repository.dart';
import 'package:listar_flutter_pro/repository/cityV2_repository.dart';
import 'widgets/events_first_page.dart';
import 'package:url_launcher/url_launcher.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final EventRepository _eventRepository = EventRepository();
  final CityV2Repository _cityV2Repository = CityV2Repository();
  String? _selectedCity;
  String? _selectedCategory;
  Future<EventModel>? _futureEvents;
  Future<EventCategoryResponse>? _futureEventCategories;
  Future<CityV2Model>? _futureCities;

  @override
  void initState() {
    super.initState();
    _futureEvents = _eventRepository.fetchEvents();
    _futureEventCategories = _eventRepository.fetchEventCategory();
    _futureCities = _cityV2Repository.fetchCities();
  }

  void _filterEvents() {
    setState(() {
      _futureEvents = _eventRepository.fetchEvents(
        city: _selectedCity,
        category: _selectedCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Događaji",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.green, // Background color for the padding
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<CityV2Model>(
                          future: _futureCities,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Greška: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data!.data == null ||
                                snapshot.data!.data!.isEmpty) {
                              return Text("Nema dostupnih gradova");
                            }

                            final cities = snapshot.data!.data!;
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                labelText: "Grad",
                                border:
                                    InputBorder.none, // Remove the underline
                              ),
                              value: _selectedCity,
                              items: cities.map((city) {
                                return DropdownMenuItem<String>(
                                  value: city.name,
                                  child: Text(city.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCity = value;
                                });
                              },
                              isExpanded: true,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: FutureBuilder<EventCategoryResponse>(
                          future: _futureEventCategories,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Greška: ${snapshot.error}");
                            } else if (!snapshot.hasData ||
                                snapshot.data!.data == null ||
                                snapshot.data!.data!.isEmpty) {
                              return Text("Nema dostupnih kategorija");
                            }

                            final categories = snapshot.data!.data!;
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: "Kategorija",
                                border:
                                    InputBorder.none, // Remove the underline
                              ),
                              value: _selectedCategory,
                              items: categories.map((category) {
                                return DropdownMenuItem<String>(
                                  value: category.name,
                                  child: Text(category.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCategory = value;
                                });
                              },
                              isExpanded: true,
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: _filterEvents,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<EventModel>(
              future: _futureEvents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Greška: ${snapshot.error}"));
                } else if (!snapshot.hasData ||
                    snapshot.data!.data == null ||
                    snapshot.data!.data!.isEmpty) {
                  return Center(child: Text("Nema dostupnih događaja"));
                }

                final events = snapshot.data!.data!;

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return Card(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          event.image != null
                              ? Image.network(event.image!,
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover)
                              : Icon(Icons.event, size: 200),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(event.title ?? "Bez naziva",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 8.0),
                                      Text(event.city?.name ?? "Bez opisa"),
                                      SizedBox(height: 8.0),
                                      Text(event.date ?? "Nema datuma"),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (event.link != null) {
                                      launch(event.link!);
                                    }
                                  },
                                  child: Text("Rezerviši"),
                                ),
                              ],
                            ),
                          ),
                        ],
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
