// To parse this JSON data, do
//
//     final error = errorFromMap(jsonString);

import 'dart:convert';

class Errorcito {
    Errorcito({
        this.error,
        this.price,
    });

    String? error;
    int? price;

    factory Errorcito.fromJson(String str) => Errorcito.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Errorcito.fromMap(Map<String, dynamic> json) => Errorcito(
        error: json["error"],
        price: json["price"],
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "price": price,
    };
}
