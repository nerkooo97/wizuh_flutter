import 'package:listar_flutter_pro/models/model_cityV2.dart';

class BuslinesModel {
    BuslinesModel({
        required this.success,
        required this.data,
        required this.message,
    });

    final bool? success;
    final List<Datum> data;
    final String? message;

    factory BuslinesModel.fromJson(Map<String, dynamic> json){ 
        return BuslinesModel(
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.map((x) => x?.toJson()).toList(),
        "message": message,
    };

    @override
    String toString(){
        return "$success, $data, $message, ";
    }
}

class Datum {
    Datum({
        required this.id,
        required this.company,
        required this.amenities,
        required this.cityStart,
        required this.cityEnd,
        required this.stations,
        required this.daysInWeek,
    });

    final int? id;
    final Company? company;
    final Amenities? amenities;
    final CityV2? cityStart;
    final CityV2? cityEnd;
    final List<Station> stations;
    final String? daysInWeek;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            company: json["company"] == null ? null : Company.fromJson(json["company"]),
            amenities: json["amenities"] == null ? null : Amenities.fromJson(json["amenities"]),
            cityStart: json["cityStart"] == null ? null : CityV2.fromJson(json["cityStart"]),
            cityEnd: json["cityEnd"] == null ? null : CityV2.fromJson(json["cityEnd"]),
            stations: json["stations"] == null ? [] : List<Station>.from(json["stations"]!.map((x) => Station.fromJson(x))),
            daysInWeek: json["days_in_week"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "company": company?.toJson(),
        "amenities": amenities?.toJson(),
        "cityStart": cityStart?.toJson(),
        "cityEnd": cityEnd?.toJson(),
        "stations": stations.map((x) => x?.toJson()).toList(),
        "days_in_week": daysInWeek,
    };

    @override
    String toString(){
        return "$id, $company, $cityStart, $cityEnd, $stations, $daysInWeek, ";
    }
}

class Amenities {
    Amenities({
        required this.wifi,
        required this.powerSockerts,
        required this.airConditioning,
        required this.toilet,
        required this.entertrainment,
    });

    final bool? wifi;
    final bool? powerSockerts;
    final bool? airConditioning;
    final bool? toilet;
    final bool? entertrainment;

    factory Amenities.fromJson(Map<String, dynamic> json){ 
        return Amenities(
            wifi: json["wifi"],
            powerSockerts: json["power-sockerts"],
            airConditioning: json["air-conditioning"],
            toilet: json["toilet"],
            entertrainment: json["entertrainment"],
        );
    }

    Map<String, dynamic> toJson() => {
        "wifi": wifi,
        "power-sockerts": powerSockerts,
        "air-conditioning": airConditioning,
        "toilet": toilet,
        "entertrainment": entertrainment,
    };

    @override
    String toString(){
        return "$wifi, $powerSockerts, $airConditioning, $toilet, $entertrainment, ";
    }
}

class Company {
    Company({
        required this.id,
        required this.name,
        required this.description,
        required this.phone,
        required this.email,
        required this.address,
        required this.city,
        required this.imgLogo,
    });

    final int? id;
    final String? name;
    final String? description;
    final String? phone;
    final String? email;
    final String? address;
    final String? city;
    final String? imgLogo;

    factory Company.fromJson(Map<String, dynamic> json){ 
        return Company(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            phone: json["phone"],
            email: json["email"],
            address: json["address"],
            city: json["city"],
            imgLogo: json["img_logo"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "phone": phone,
        "email": email,
        "address": address,
        "city": city,
        "img_logo": imgLogo,
    };

    @override
    String toString(){
        return "$id, $name, $description, $phone, $email, $address, $city, $imgLogo, ";
    }
}

class Station {
    Station({
        required this.id,
        required this.type,
        required this.buslineId,
        required this.cityId,
        required this.time,
        required this.fetured,
        required this.city,
    });

    final int? id;
    final int? type;
    final int? buslineId;
    final int? cityId;
    final String? time;
    final int? fetured;
    final CityV2? city;

    factory Station.fromJson(Map<String, dynamic> json){ 
        return Station(
            id: json["id"],
            type: json["type"],
            buslineId: json["busline_id"],
            cityId: json["city_id"],
            time: json["time"],
            fetured: json["fetured"],
            city: json["city"] == null ? null : CityV2.fromJson(json["city"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "busline_id": buslineId,
        "city_id": cityId,
        "time": time,
        "fetured": fetured,
        "city": city?.toJson(),
    };

    @override
    String toString(){
        return "$id, $type, $buslineId, $cityId, $time, $fetured, $city, ";
    }
}
