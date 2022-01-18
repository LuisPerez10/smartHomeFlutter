import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SetupServerService with ChangeNotifier {
  final _storage = new FlutterSecureStorage();
  String _url = "";
  String get urlRemote => this._url;

  Future _saveUrlRemote(String urlremote) async {
    return await _storage.write(key: 'urlremoteserver', value: urlremote);
  }

  Future forgotSetup() async {
    await _storage.delete(key: 'urlremoteserver');
  }

  Future<bool> setupServer(String urlremote) async {
    if (urlremote.isEmpty) {
      return false;
    } else {
      await this._saveUrlRemote(urlremote);
      this._url = urlremote;
      return true;
    }
  }

  Future<String> getState() async {
    var url = Uri.parse("http://192.168.43.187:8080/rest/items/NewItem/state");
    final resp =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      print(resp.body);
      return resp.body;
    } else {
      return "error 400";
    }
  }

  Future<bool> isSettedUpRemote() async {
    final urlremote = await this._storage.read(key: 'urlremoteserver');

    if (urlremote == null) {
      print("isSettedUpRemote false");
      return false;
    } else {
      print("isSettedUpRemote true");
      return true;
    }
  }

  Future<String?> getUrlRemote() async {
    final url = await this._storage.read(key: 'urlremoteserver');
    return url;
  }
}
