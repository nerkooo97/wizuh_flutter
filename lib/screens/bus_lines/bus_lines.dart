import 'package:flutter/material.dart';
import '../bus_lines/widgets/bus_banner.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/repository/cityV2_repository.dart';
import 'package:listar_flutter_pro/screens/screen.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';


class BusLinesScreen extends StatefulWidget {
  @override
  _BusLinesScreenState createState() => _BusLinesScreenState();
}

class _BusLinesScreenState extends State<BusLinesScreen> {
  final CityV2Repository _cityV2Repository = CityV2Repository();

  Future<CityV2Model>? _futureCities;

  String? _selectedStartCity;
  String? _selectedEndCity;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    _futureCities = _cityV2Repository.fetchCities();
  }

  void _filterEvents() {
    setState(() {});
  }

  void _onSearch() {
    if(_selectedStartCity == null || _selectedEndCity == null) {
      AppBloc.messageBloc.add(MessageEvent(message: 'Morate odabrati polaznu i dolaznu stanicu'));
      return null;
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BusLinesResults(
          cityFrom: _selectedStartCity,
          cityTo: _selectedEndCity,
          date: selectedDate,
        ),
      ),
    );
  }

  String? selectedDepartureCity;
  String? selectedArrivalCity;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autobuske linije'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            BusBanner(),
            Card(
              elevation: 4.0,
              child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                FutureBuilder<CityV2Model>(
                  future: _futureCities,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Greška: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                    return Text("Nema dostupnih gradova");
                  }

                  final cities = snapshot.data!.data!;
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: "Polazna stanica"),
                    value: _selectedStartCity,
                    items: cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.name,
                      child: Text(city.name),
                    );
                    }).toList(),
                    onChanged: (value) {
                    setState(() {
                      _selectedStartCity = value;
                    });
                    },
                    isExpanded: true,
                  );
                  },
                ),
                SizedBox(height: 16.0),
                FutureBuilder<CityV2Model>(
                  future: _futureCities,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Greška: ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                    return Text("Nema dostupnih gradova");
                  }

                  final cities = snapshot.data!.data!;
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: "Dolazna stanica"),
                    value: _selectedEndCity,
                    items: cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.name,
                      child: Text(city.name),
                    );
                    }).toList(),
                    onChanged: (value) {
                    setState(() {
                      _selectedEndCity = value;
                    });
                    },
                    isExpanded: true,
                  );
                  },
                ),
                SizedBox(height: 26.0),
                Text('Odaberite datum:'),
                GestureDetector(
                  onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                    selectedDate = picked;
                    });
                  }
                  },
                  child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Text(
                    '${selectedDate.day}.${selectedDate.month}.${selectedDate.year}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 36), // Full width button
                  ),
                  onPressed: _onSearch,
                  child: Text('Pretraži'),
                )
                ],
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
