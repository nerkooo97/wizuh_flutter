import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:listar_flutter_pro/screens/submit/submit.dart';
import 'package:search_choices/search_choices.dart';

class SearchForm extends StatelessWidget {
  // Dummy data for locations
  List<DropdownMenuItem<String>> locations = [
    DropdownMenuItem(child: Text("New York"), value: "New York"),
    DropdownMenuItem(child: Text("Los Angeles"), value: "Los Angeles"),
    DropdownMenuItem(child: Text("Chicago"), value: "Chicago"),
    DropdownMenuItem(child: Text("Houston"), value: "Houston"),
    DropdownMenuItem(child: Text("Phoenix"), value: "Phoenix"),
  ];

  // Variable to hold the selected value
  String? selectedValueSingleDialog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Polaznu stanicu:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              SearchChoices.single(
                items: locations,
                value: selectedValueSingleDialog,
                hint: "Odaberite polaznu stanicu",
                searchHint: "Pretrazite",
                onChanged: (value) {
                  setState(() {
                    selectedValueSingleDialog = value as String?;
                  });
                },
                isExpanded: true,
              ),
              SizedBox(height: 20),
              Text(
                "Krajnja stanica:",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              SearchChoices.single(
                items: locations,
                value: selectedValueSingleDialog,
                hint: "Odaberite krajnju stanicu",
                searchHint: "Pretrazite",
                onChanged: (value) {
                  setState(() {
                    selectedValueSingleDialog = value as String?;
                  });
                },
                isExpanded: true,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Akcija rezervacije
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Rezerviši',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
