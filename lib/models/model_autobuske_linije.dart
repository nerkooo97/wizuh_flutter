class AutobuskeLinijeModel {
  int routeId;
  String from;
  String to;
  String departureTime;
  String arrivalTime;
  String duration;
  String price;
  String currency;
  String availableSeats;
  String busCompany;
  List<String> operatingDays;
  List<Stop> stops;

  AutobuskeLinijeModel({
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
}

class Stop {
  int stopId;
  String location;
  String price;
  String operatingDays;

  Stop({
    required this.stopId,
    required this.location,
    required this.price,
    required this.operatingDays,
  });
}
