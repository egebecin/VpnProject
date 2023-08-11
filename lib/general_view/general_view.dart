// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vpnapp/add_person/add_person_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vpnapp/general_view/general_view_read.dart';

void main() {
  runApp(SmsReadView());
}

class ContactView {
  String name;
  String telno;
  String email;
  bool? isSelected;

  ContactView(this.name, this.email, this.telno, this.isSelected);
}

class SmsReadView extends StatelessWidget {
  const SmsReadView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOn = false;
  int i = 0;
  

  
  List<ContactView> contacts = [ContactView("Ege","sadsa","sadsad",false)];

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
        child: Column(children: [
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
          Container(
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
                  for (i = 0; i < contacts.length; i++) 
                  PadCheckB(contacts[i]),
                  
                  
                ],
                
              ),
            ),
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
          
        ]),
      )),
    );
  }

  Padding PadCheckB(ContactView con1) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CheckboxListTile(
        title: Text(con1.name),
        subtitle: Text(con1.telno),
        value: con1.isSelected,
        onChanged: (bool? newValue) {
          setState(() {
            con1.isSelected = newValue;
          });
        },
        activeColor: Colors.green[700],
        checkColor: Colors.white,
        tileColor: Colors.white,
      ),
    );
  }
}
