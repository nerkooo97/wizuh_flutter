import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/search-form.dart';
import 'components/autobuska_linija_detalji.dart';

class AutobuskeLinije extends StatefulWidget {
  const AutobuskeLinije({Key? key}) : super(key: key);

  @override
  State<AutobuskeLinije> createState() => _AutobuskeLinijeState();
}

class _AutobuskeLinijeState extends State<AutobuskeLinije> {
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
          ],
        ),
        backgroundColor: Color.fromRGBO(16, 165, 73, 5),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.red
        ),
        child: Column(
          children: [
            SearchForm(),
            AutobuskLinijeDetalji()
          ],
        ),
        
      ),
    );
}}