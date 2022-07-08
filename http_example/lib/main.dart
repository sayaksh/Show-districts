import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:http_example/model/districts.dart';

Future<Districts> fetchData() async {
  final response = await http.get(
      Uri.parse('https://kanglei-tourist-app.herokuapp.com/api/districts'));
  if (response.statusCode == 200) {
    return Districts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Unexpected error occured!');
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final control_1 = TextEditingController();
  Future<Districts>? districtsData;
  @override
  void initState() {
    super.initState();
    districtsData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter API and ListView Example',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Flutter ListView'),
          ),
          body: Center(
            child: FutureBuilder<Districts>(
              future: districtsData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Districts? data = snapshot.data;

                  return Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: data!.meta.pagination.total,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 75,
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                    data.data[index].attributes.districtName),
                              ),
                            );
                          }),
                      FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  title: const Text("Add new district"),
                                  content: Container(
                                    padding: EdgeInsets.zero,
                                    height: 200,
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                            labelText: 'Enter district name',
                                          ),
                                          keyboardType: TextInputType.name,
                                          controller: control_1,
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Add')),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        tooltip: 'Add district',
                        child: const Icon(Icons.add),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
