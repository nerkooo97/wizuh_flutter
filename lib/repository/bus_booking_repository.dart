import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/models/model_bus_booking.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:flutter/material.dart';

class BusRouteRepository {
  /// Učitaj listu autobusnih linija
  static Future<List<BusBookingModel>?> loadBusRoutes() async {
    final response =
        await Api.requestAutobuskeLinije(); // Poziv API-a bez parametara
    if (response.success) {
      final busRoutes = (response.origin['data'] as List<dynamic>).map((item) {
        return BusBookingModel.fromJson(item);
      }).toList();
      return busRoutes;
    }

    AppBloc.messageBloc.add(MessageEvent(message: response.message));
    return null;
  }
}
