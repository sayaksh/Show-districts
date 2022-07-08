import 'package:flutter/material.dart';

class AddingDistrict extends StatefulWidget {
  const AddingDistrict({Key? key}) : super(key: key);

  @override
  State<AddingDistrict> createState() => _AddingDistrictState();
}

class _AddingDistrictState extends State<AddingDistrict> {
  final control_1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
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
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
