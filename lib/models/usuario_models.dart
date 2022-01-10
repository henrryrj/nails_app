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
  int? lat;
  int? lon;
  String? email;
  String? pass;
  int? precio;
  String? urlImg;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory Cliente.fromJson(String str) => Cliente.fromMap(json.decode(str));
  
  String toJson() => json.encode(toMap());
  String toJsonSolicitud() => json.encode(toSolicitud());

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
  Map<String, dynamic> toSolicitud() => {
        "nombre": nombre,
        "apellido": apellido,
        "ci": ci,
        "telefono": telefono,
        "direccion": direccion,
        "lat": lat,
        "lon": lon,
        "email": email,
      };
}

class Solicitud {
  Solicitud({
    this.id,
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
  int? precio;
  String? urlImg;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  factory Solicitud.fromJsonSolicitud(String str) =>
      Solicitud.fromMapSolicitud(json.decode(str));

  factory Solicitud.fromMapSolicitud(Map<String, dynamic> json) => Solicitud(
        id: json["id"],
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
}
