import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  final String base_url = "http://jsonplaceholder.typicode.com/users";

  List nameListesi = [];

  List surnameListesi = [];

  List idListesi = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internettenVeriCek();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Deneme"),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.grey,
            child: const Center(
              child: Text(
                "Kullanıcılar Listesi",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: ListView.builder(
                itemCount: nameListesi.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("Ad : ${nameListesi[index]}"),
                    subtitle: Text("Kullanıcı Adı : ${surnameListesi[index]}"),
                    trailing: Text(idListesi[index].toString()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void internettenVeriCek() async {
    Uri uri = Uri.parse(base_url);
    http.Response response = await http.get(uri);
    List parsedResponse = jsonDecode(response.body);

    for (var i = 0; i < parsedResponse.length; i++) {
      Map<String, dynamic> responseMap = parsedResponse[i];
      String nameTutucu = responseMap["name"];
      nameListesi.add(nameTutucu);
      String surnameTutucu = responseMap["username"];
      surnameListesi.add(surnameTutucu);
      int idTutucu = responseMap["id"];
      idListesi.add(idTutucu);
    }
  }
}
