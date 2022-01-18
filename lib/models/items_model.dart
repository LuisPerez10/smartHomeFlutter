// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

List<Items> itemsFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  Items({
    required this.state,
    required this.type,
  });

  String state;
  String type;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        state: json["state"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "state": state,
        "type": type,
      };
}
