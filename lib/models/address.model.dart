import 'dart:convert';

class Address {
  String cep,
      logradouro,
      complemento,
      bairro,
      localidade,
      uf,
      ibge,
      gia,
      ddd,
      siafi;

  bool erro = false;

  Address({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.ibge,
    this.gia,
    this.ddd,
    this.siafi,
    this.erro = false,
  });

  Address.fromJsonString(String json) {
    Map jsonMap = jsonDecode(json);
    Address.fromMap(jsonMap);
  }

  Address.fromMap(Map map) {
    this.cep = map['cep'];
    this.logradouro = map['logradouro'];
    this.complemento = map['complemento'];
    this.bairro = map['bairro'];
    this.localidade = map['localidade'];
    this.uf = map['uf'];
    this.ibge = map['ibge'];
    this.gia = map['gia'];
    this.ddd = map['ddd'];
    this.siafi = map['siafi'];
    this.erro = map['erro'] != null ? true : false;
  }
}
