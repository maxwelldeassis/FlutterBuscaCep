import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:viacep/models/address.model.dart';

class ViaCepApiConnection {
  var reqScheme = 'https', reqHost = 'viacep.com.br', reqPath = '';

  Future<String> _requestJsonData(Uri uri) async {
    Future request = Client().get(uri);
    Response response = await request;
    return response.body;
  }

  Future<Map> requestAddressByCEP(String cep) async {
    var uri = Uri(scheme: reqScheme, host: reqHost, path: '/ws/$cep/json');
    Map map = jsonDecode(await _requestJsonData(uri));
    return map;
  }
}

class ViaCepProvider extends ChangeNotifier {
  bool searching = false;
  bool isErro = false;
  List<Address> addresses;
  ViaCepApiConnection connection = ViaCepApiConnection();

  getAddressByCEP(String cep) async {
    searching = true;
    addresses = null;
    Map map = await connection.requestAddressByCEP(cep);
    addresses = [Address.fromMap(map)];
    searching = false;
    isErro = addresses.first.erro || addresses.first == null;
    notifyListeners();
  }
}
