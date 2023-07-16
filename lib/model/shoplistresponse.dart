// To parse this JSON data, do
//
//     final art = artFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Art> artFromMap(String str) => List<Art>.from(json.decode(str).map((x) => Art.fromMap(x)));

String artToMap(List<Art> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Art {
  final String model;
  final String pk;
  final Fields fields;

  Art({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Art.fromMap(Map<String, dynamic> json) => Art(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromMap(json["fields"]),
  );

  Map<String, dynamic> toMap() => {
    "model": model,
    "pk": pk,
    "fields": fields.toMap(),
  };
}

class Fields {
  final String title;
  final String description;

  Fields({
    required this.title,
    required this.description,
  });

  factory Fields.fromMap(Map<String, dynamic> json) => Fields(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
  };
}
