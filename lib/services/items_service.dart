import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:openhab_flutter/models/items_model.dart';

class ItemsService with ChangeNotifier {
  late List<Items> items;
  final _storage = new FlutterSecureStorage();
  String _url = "";
  String get urlRemote => this._url;

  Future<String> getItemState(String itemName) async {
    final domain = await this._storage.read(key: 'urlremoteserver');

    var url = Uri.parse("$domain/rest/items/$itemName/state");
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      // print(resp.body);
      return resp.body;
    } else {
      return "error 400";
    }
  }

  Future<bool> setItemsState(String itemName, String state) async {
    final domain = await this._storage.read(key: 'urlremoteserver');

    var url = Uri.parse("$domain/rest/items/$itemName");
    final resp = await http
        .post(url, body: state, headers: {'Content-Type': 'text/plain'});

    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> getItems(String itemName) async {
  //   final domain = await this._storage.read(key: 'urlremoteserver');

  //   var url = Uri.parse("$domain/rest/items/$itemName");
  //   final resp =
  //       await http.get(url, headers: {'Content-Type': 'application/json'});

  //   if (resp.statusCode == 200) {
  //     this.items = itemsFromJson(resp.body);
  //     // aqui debo ver que me llega con los items , y mostrarlos en un future builder cada n segundos
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

}
