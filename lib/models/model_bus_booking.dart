class BusBookingModel {
  int routeId;
  String from;
  String to;
  String departureTime;
  String arrivalTime;
  String duration;
  double price; // Koristi double za price
  String currency;
  int availableSeats; // Koristi int za broj sedišta
  String busCompany;
  List<String> operatingDays;
  List<Stop> stops;

  BusBookingModel({
    required this.routeId,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.currency,
    required this.availableSeats,
    required this.busCompany,
    required this.operatingDays,
    required this.stops,
  });

  factory BusBookingModel.fromJson(Map<String, dynamic> json) {
    List<Stop> stops = [];
    if (json['stops'] != null) {
      stops =
          List.from(json['stops']).map((item) => Stop.fromJson(item)).toList();
    }

    return BusBookingModel(
      routeId: json['route_id'] ?? 0,
      from: json['from'] ?? '',
      to: json['to'] ?? '',
      departureTime: json['departure_time'] ?? '',
      arrivalTime: json['arrival_time'] ?? '',
      duration: json['duration'] ?? '',
      price: double.tryParse(json['price'].toString()) ??
          0.0, // Konvertuj price u double
      currency: json['currency'] ?? '',
      availableSeats: int.tryParse(json['available_seats'].toString()) ??
          0, // Konvertuj broj sedišta u int
      busCompany: json['bus_company'] ?? '',
      operatingDays: List<String>.from(json['operating_days'] ?? []),
      stops: stops,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "route_id": routeId,
      "from": from,
      "to": to,
      "departure_time": departureTime,
      "arrival_time": arrivalTime,
      "duration": duration,
      "price": price,
      "currency": currency,
      "available_seats": availableSeats,
      "bus_company": busCompany,
      "operating_days": operatingDays,
      "stops": stops.map((stop) => stop.toJson()).toList(),
    };
  }
}

class Stop {
  int stopId;
  String location;
  double price; // Koristi double za cenu stanice
  String operatingDays;

  Stop({
    required this.stopId,
    required this.location,
    required this.price,
    required this.operatingDays,
  });

  factory Stop.fromJson(Map<String, dynamic> json) {
    return Stop(
      stopId: json['stop_id'] ?? 0,
      location: json['location'] ?? '',
      price: double.tryParse(json['price'].toString()) ??
          0.0, // Konvertuj price u double
      operatingDays: json['operating_days'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "stop_id": stopId,
      "location": location,
      "price": price,
      "operating_days": operatingDays,
    };
  }
}
