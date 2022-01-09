// To parse this JSON data, do
//
//     final encuestador = encuestadorFromMap(jsonString);

import 'dart:convert';

class Cliente {
  Cliente({
    this.nombre,
    this.apellido,
    this.ci,
    this.telefono,
    this.direccion,
    this.lat,
    this.lon,
    this.email,
    this.pass,
    this.precio,
    this.urlImg,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

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
  String? updatedAt;
  String? deletedAt;

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        ci: json["ci"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        lat: json["lat"],
        lon: json["lon"],
        email: json["email"],
        pass: json["pass"],
        precio: json["precio"],
        urlImg: json["url_img"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toMap() => {
        "nombre": nombre,
        "apellido": apellido,
        "ci": ci,
        "telefono": telefono,
        "direccion": direccion,
        "lat": lat,
        "lon": lon,
        "email": email,
        "pass": pass,
        "precio": precio,
        "url_img": urlImg,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
