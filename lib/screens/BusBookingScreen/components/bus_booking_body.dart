import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/repository/bus_booking_repository.dart';
import 'package:listar_flutter_pro/models/model_bus_booking.dart';
import 'package:hugeicons/hugeicons.dart';

class BusBookingBody extends StatefulWidget {
  @override
  _BusBookingBodyState createState() => _BusBookingBodyState();
}

class _BusBookingBodyState extends State<BusBookingBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();

  final List<String> _locations = [
    "Sarajevo",
    "Banja Luka",
    "Mostar",
    "Tuzla",
    "Zenica"
  ];

  String? _selectedFromLocation;
  String? _selectedToLocation;
  String? _selectedDay;
  List<BusBookingModel> _filteredBusLines = [];
  List<BusBookingModel> _allBusLines = [];

  final BusRouteRepository _busBookingRepository = BusRouteRepository();

  @override
  void initState() {
    super.initState();
    _fetchBusLines();
  }

  void _fetchBusLines() async {
    try {
      List<BusBookingModel>? busLines =
          await BusRouteRepository.loadBusRoutes();
      setState(() {
        _allBusLines = busLines!;
      });
    } catch (error) {
      // Handle error
      print('Failed to load bus lines: $error');
    }
  }

  void _filterBusLines() {
    setState(() {
      // Provjera da li su odabrane iste lokacije
      if (_selectedFromLocation == _selectedToLocation) {
        _filteredBusLines = [];
        return;
      }

      _filteredBusLines = _allBusLines.where((line) {
        // Provjerava direktnu liniju
        bool isDirectLine = line.from == _selectedFromLocation &&
            line.to == _selectedToLocation &&
            line.operatingDays.contains(_selectedDay ?? '');

        // Provjerava podstanicu
        bool hasIntermediateStopFrom = line.stops.any((stop) {
          return stop.location == _selectedFromLocation &&
              line.to == _selectedToLocation &&
              stop.operatingDays.contains(_selectedDay ?? '');
        });

        bool hasIntermediateStopTo = line.from == _selectedFromLocation &&
            line.stops.any((stop) {
              return stop.location == _selectedToLocation &&
                  line.operatingDays.contains(_selectedDay ?? '');
            });

        // Provjerava da li se linija može koristiti za putovanje
        bool isStopToMainLine = line.to == _selectedToLocation &&
            line.operatingDays.contains(_selectedDay ?? '');

        return isDirectLine ||
            hasIntermediateStopFrom ||
            hasIntermediateStopTo ||
            isStopToMainLine; // Uključuje podstanicu kao glavni cilj
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDay = _getDayOfWeek(picked.weekday);
        _dateController.text = "${picked.day}-${picked.month}-${picked.year}";
      });
    }
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Autobuske linije',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 4.0), // Malo razmaka između naslova i kontejnera
              child: Text(
                'Pretražite dostupne autobuske linije',
                style: TextStyle(
                  color: Colors.white70, // Svjetlija boja za tekst
                  fontSize: 14, // Veličina fonta
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(16, 165, 73, 5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(16, 165, 73, 5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _selectedFromLocation,
                      decoration: const InputDecoration(
                        hintText: "Lokacija Od",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        prefixIcon: const Icon(
                          HugeIcons.strokeRoundedLocationUser03,
                          color: Color.fromRGBO(16, 165, 73, 33),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFromLocation = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo odaberite početnu lokaciju';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedToLocation,
                      decoration: const InputDecoration(
                        hintText: "Lokacija Do",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        prefixIcon: const Icon(
                          HugeIcons.strokeRoundedLocation04,
                          color: Color.fromRGBO(16, 165, 73, 33),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: _locations.map((location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedToLocation = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Molimo odaberite odredišnu lokaciju';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: "Datum Polaska",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        prefixIcon: const Icon(
                          HugeIcons.strokeRoundedCalendar01,
                          color: Color.fromRGBO(16, 165, 73, 33),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      onTap: () => _selectDate(context),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Molimo odaberite datum polaska';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _filterBusLines();
                        }
                      },
                      child: const Text('Pretraži'),
                    ),
                  ],
                ),
              ),
            ),
            // Prikaz filtriranih linija
            _filteredBusLines.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Niste jos uvijek unijeli u pretragu ili za trazenu pretragu nema rezultata.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredBusLines.length,
                    itemBuilder: (context, index) {
                      final busLine = _filteredBusLines[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.green[600],
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${busLine.from} - ${busLine.to}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),

                            // Body - Podstanice
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Podstanice:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ...busLine.stops.map((stop) => Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          '• ${stop.location}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      )),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Vrijeme polaska: ${busLine.departureTime}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Cijena: ${busLine.price} ${busLine.currency}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'Dostupna mjesta: ${busLine.availableSeats}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),

                            // Footer
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Prijevoznik: ${busLine.busCompany}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Akcija rezervacije
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.green[600], // Boja dugmeta
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Rezerviši',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
