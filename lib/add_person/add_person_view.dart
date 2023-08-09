// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(PersonView());
}

class PersonView extends StatelessWidget {
  const PersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PersonApp());
  }
}

class PersonApp extends StatefulWidget {
  const PersonApp({super.key});

  @override
  State<PersonApp> createState() => _PersonAppState();
}

class _PersonAppState extends State<PersonApp> {
  var textname = TextEditingController();

  var textphone = TextEditingController();

  var textemail = TextEditingController();

  var person = FirebaseFirestore.instance;

  String addname = " ", addnumber = " ", addmail = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Kişi Ekle", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            TextField(
                controller: textname,
                decoration: InputDecoration(
                    hintText: "Name?",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        textname.clear();
                      },
                      icon: Icon(Icons.clear),
                    ))),
            SizedBox(
              height: 30,
            ),
            TextField(
                controller: textphone,
                decoration: InputDecoration(
                    hintText: "Phone?",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        textphone.clear();
                      },
                      icon: Icon(Icons.clear),
                    ))),
            SizedBox(
              height: 30,
            ),
            TextField(
                controller: textemail,
                decoration: InputDecoration(
                    hintText: "Email?",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        textemail.clear();
                      },
                      icon: Icon(Icons.clear),
                    ))),
            SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                addname = textname.text;
                addmail = textemail.text;
                addnumber = textphone.text;

                person.collection("Person").add({
                  "PersonName": addname,
                  "PersonNumber": addnumber,
                  "PersonEmail": addmail,
                  "PersonSelect": false
                });
                setState(() {});
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 140),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.green[700]),
                  child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
