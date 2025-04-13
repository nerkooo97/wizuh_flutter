import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';

class AutobuskLinijeDetalji extends StatelessWidget {
  const AutobuskLinijeDetalji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Sarajevo',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Pocetna stanica',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Mostar1',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        'Krajnja stanica',
                                        style: TextStyle(fontSize: 12),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: const Color.fromARGB(255, 229, 222, 222),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(Images.logotest, height: 50),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: onPressed(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green[600],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: const Text('Rezerviši'))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ))
      ],
    );
  }

  onPressed() {}
}
