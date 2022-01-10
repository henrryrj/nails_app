

import 'dart:convert';

class Salon {
    Salon({
        this.id,
        this.descripcion,
        this.direccion,
        this.lat,
        this.lon,
    });

    int? id;
    String? descripcion;
    String? direccion;
    String? lat;
    String? lon;

    factory Salon.fromJson(String str) => Salon.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Salon.fromMap(Map<String, dynamic> json) => Salon(
        id: json["id"],
        descripcion: json["descripcion"],
        direccion: json["direccion"],
        lat: json["lat"],
        lon: json["lon"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "descripcion": descripcion,
        "direccion": direccion,
        "lat": lat,
        "lon": lon,
    };
}
