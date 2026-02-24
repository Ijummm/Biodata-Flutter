import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:biodata/models/msiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/views/details.dart';
import 'package:biodata/views/create.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;
  final swListkey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    try {
    final response = await http.get(Uri.parse(BaseUrl.data));
    if (response.statusCode == 200) {
      final List items = json.decode(response.body);
      return items.map((json) => SiswaModel.fromJson(json)).toList();
    } else {
      throw Exception("Gagal load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Log Error: $e"); // Cek di terminal/debug console
    rethrow;
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.nis + " " + data.nama,
                      style: TextStyle(fontSize: 20),
                    ), // Text
                    subtitle: Text(data.tplahir + "," + data.tglahir),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                         builder: (context) => Details(sw: data)),
                       );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (_) {
             return Create();
           }));
        },
      ),
    );
  }
}