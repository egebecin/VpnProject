// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vpnapp/add_person/add_person_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SmsReadView());
}

class Person {
  final String personName;
  final String personNumber;
  final String personEmail;
   bool? personSelect;

  Person({
    required this.personName,
    required this.personNumber,
    required this.personEmail,
    required this.personSelect,
  });
}

class SmsReadView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOn=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vpn Kodları",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Switch(
            value: isOn,
            onChanged: (value) {
              setState(
                () {
                  isOn = value;
                },
              );
            },
            activeColor: Colors.green[700],
          ),
          SizedBox(
            height: 30,
          ),
              

              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Person').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final persons = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Person(
                      personName: data['PersonName'],
                      personNumber: data['PersonNumber'],
                      personEmail: data['PersonEmail'],
                      personSelect: data['PersonSelect'] ?? false,
                    );
                  }).toList();

                  return Container(
                    height: 300,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.black54, width: 3),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          for (final person in persons) PadCheckB(person),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 70,
              ),
              Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        Route routeaddperson =
                            MaterialPageRoute(builder: (context) {
                          return PersonApp();
                        });
                        Navigator.push(context, routeaddperson);
                      },
                      icon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.add_circle),
                      ),
                      iconSize: 100,
                      color: Colors.green[700]))),

            ],
          ),
        ),
      ),
    );
  }

 Future<void> updatePersonSelect(String personName, bool? newValue) async {
    await FirebaseFirestore.instance
        .collection('Person')
        .doc("C9hv88pwCRDNuUYqjQka")
        .update({'PersonSelect': newValue});
  }







  Padding PadCheckB(Person person) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CheckboxListTile(
        title: Text(person.personName),
        subtitle: Text(person.personNumber),
        value: person.personSelect,
        onChanged: (bool? newValue) {setState(() {
          updatePersonSelect(person.personName, newValue);
        });
          
        },
        activeColor: Colors.green[700],
        checkColor: Colors.white,
        tileColor: Colors.white,
      ),
    );
  }
}