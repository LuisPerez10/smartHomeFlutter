// To parse this JSON data, do
//
//     final dialogflow = dialogflowFromJson(jsonString);

import 'dart:convert';

Dialogflow dialogflowFromJson(String str) =>
    Dialogflow.fromJson(json.decode(str));

String dialogflowToJson(Dialogflow data) => json.encode(data.toJson());

class Dialogflow {
  Dialogflow({
    required this.action,
    required this.to,
    required this.commands,
    this.attrib,
  });

  String action;
  String to;
  List<String> commands;
  String? attrib;

  factory Dialogflow.fromJson(Map<String, dynamic> json) => Dialogflow(
        attrib: json["attrib"],
        action: json["action"],
        to: json["to"],
        commands: List<String>.from(json["commands"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "attrib": attrib,
        "action": action,
        "to": to,
        "commands": List<dynamic>.from(commands.map((x) => x)),
      };
}
