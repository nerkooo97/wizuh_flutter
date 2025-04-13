class RedVoznjeModel {
  bool? success;
  List<Data>? data;

  RedVoznjeModel({this.success, this.data});

  RedVoznjeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? routeId;
  String? pocetnaStanica;
  String? krajnjaStanica;
  String? datumPolaska;
  String? datumDolaska;
  Prevoznik? prevoznik;
  List<Stanice>? stanice;

  Data(
      {this.routeId,
      this.pocetnaStanica,
      this.krajnjaStanica,
      this.datumPolaska,
      this.datumDolaska,
      this.prevoznik,
      this.stanice});

  Data.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    pocetnaStanica = json['pocetna_stanica'];
    krajnjaStanica = json['krajnja_stanica'];
    datumPolaska = json['datum_polaska'];
    datumDolaska = json['datum_dolaska'];
    prevoznik = json['prevoznik'] != null
        ? new Prevoznik.fromJson(json['prevoznik'])
        : null;
    if (json['stanice'] != null) {
      stanice = <Stanice>[];
      json['stanice'].forEach((v) {
        stanice!.add(new Stanice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    data['pocetna_stanica'] = this.pocetnaStanica;
    data['krajnja_stanica'] = this.krajnjaStanica;
    data['datum_polaska'] = this.datumPolaska;
    data['datum_dolaska'] = this.datumDolaska;
    if (this.prevoznik != null) {
      data['prevoznik'] = this.prevoznik!.toJson();
    }
    if (this.stanice != null) {
      data['stanice'] = this.stanice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prevoznik {
  String? id;
  String? naziv;
  String? logo;
  Kontakt? kontakt;

  Prevoznik({this.id, this.naziv, this.logo, this.kontakt});

  Prevoznik.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    naziv = json['naziv'];
    logo = json['logo'];
    kontakt =
        json['kontakt'] != null ? new Kontakt.fromJson(json['kontakt']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['naziv'] = this.naziv;
    data['logo'] = this.logo;
    if (this.kontakt != null) {
      data['kontakt'] = this.kontakt!.toJson();
    }
    return data;
  }
}

class Kontakt {
  String? adresa;
  String? telefon;
  String? viber;
  String? whatsapp;

  Kontakt({this.adresa, this.telefon, this.viber, this.whatsapp});

  Kontakt.fromJson(Map<String, dynamic> json) {
    adresa = json['adresa'];
    telefon = json['telefon'];
    viber = json['viber'];
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adresa'] = this.adresa;
    data['telefon'] = this.telefon;
    data['viber'] = this.viber;
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}

class Stanice {
  int? stopId;
  String? start;
  String? stop;
  String? cijena;
  List<String>? daniVoznje;

  Stanice({this.stopId, this.start, this.stop, this.cijena, this.daniVoznje});

  Stanice.fromJson(Map<String, dynamic> json) {
    stopId = json['stop_id'];
    start = json['start'];
    stop = json['stop'];
    cijena = json['cijena'];
    daniVoznje = json['dani_voznje'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stop_id'] = this.stopId;
    data['start'] = this.start;
    data['stop'] = this.stop;
    data['cijena'] = this.cijena;
    data['dani_voznje'] = this.daniVoznje;
    return data;
  }
}