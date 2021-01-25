import 'package:calender/models/events.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddPage extends StatefulWidget{

  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage>{
  String baslik;
  String konum;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  List aylar = [
    "Oca",
    "ub",
    "Mar",
    "Nis",
    "May",
    "Haz",
    "Tem",
    "Au",
    "Eyl",
    "Eki",
    "Kas",
    "Ara"
  ];
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ekle"),
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(bottom: 25,left: 50,right: 50,top: 10),
              child: TextField(
                onChanged: (value){
                  baslik = value;
                },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    filled: true,
                    fillColor: Colors.grey[350]
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10,left: 50,right: 50,top: 10),
              child: TextField(
                onChanged: (value){
                konum = value;
              },
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))
                    ),
                    filled: true,
                    fillColor: Colors.grey[350]
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 10,left: 100,right: 100,top: 10),
              child: RaisedButton(
                color: Colors.grey[350],
                child: Text(selectedDate.day.toString() +"/"+ selectedDate.month.toString() +"/"+ selectedDate.year.toString(),),
                onPressed: () async {
                  final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2060),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                    });
                },
              )
            ),
            Padding(padding: EdgeInsets.only(bottom: 10,left: 50,right: 50,top: 10),
              child:  RaisedButton(
                color: Colors.grey[350],
                child: Text(selectedTime.hour.toString() + "." + selectedTime.minute.toString()),
                onPressed: () async {
                final TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
            );
              if (picked != null)
              setState(() {
              selectedTime = picked;
              });},
              )
            ),
            Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 25,left: 50,right: 50,top: 25),
              child: RaisedButton(
                onPressed: () {
                  var event = Event(selectedDate.day.toString(), aylar[selectedDate.month-1], selectedDate.year.toString(), selectedTime.hour, selectedTime.minute, konum, baslik);
                  addEvent(event);
                  Navigator.pop(context, event);
                  },
              ),
            ),
          ],
        ),
      );

  }
  addEvent(Event event) async {
    await FirebaseFirestore.instance.collection("events").add({
      "hour" : event.hour,
      "minute" : event.minute,
      "day" : event.day,
      "month" : event.month,
      "year" : event.year,
      "konum" : event.konum,
      "title" : event.title,
      "user" : FirebaseAuth.instance.currentUser.uid})
        .then((value) => print("event Added"))
        .catchError((error) => print("Failed to add event: $error"));
  }
}