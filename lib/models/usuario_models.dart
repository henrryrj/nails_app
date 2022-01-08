// To parse this JSON data, do
//
//     final encuestador = encuestadorFromMap(jsonString);

import 'dart:convert';

class Cliente {
  Cliente({
    this.id,
    this.nombre,
    this.apellido,
    this.ci,
    this.telefono,
    this.direccion,
    this.lat,
    this.lon,
    this.email,
    this.precio,
    this.urlImg,
    this.createdAt,
    this.updtedAt,
    this.deletaAt,
  });

  int? id;
  String? nombre;
  String? apellido;
  int? ci;
  int? telefono;
  String? direccion;
  String? lat;
  String? lon;
  String? email;
  String? pass;
  String? precio;
  String? urlImg;
  String? createdAt;
  String? updtedAt;
  String? deletaAt;

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        ci: json["ci"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        lat: json["lat"],
        lon: json["lon"],
        email: json["email"],
        precio: json["precio"],
        urlImg: json["url_img"],
        createdAt: json["created_at"],
        updtedAt: json["updted_at"],
        deletaAt: json["deleta_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "ci": ci,
        "telefono": telefono,
        "direccion": direccion,
        "lat": lat,
        "lon": lon,
        "email": email,
        "precio": precio,
        "url_img": urlImg,
        "created_at": createdAt,
        "updted_at": updtedAt,
        "deleta_at": deletaAt,
      };
}
