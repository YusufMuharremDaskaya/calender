import 'package:calender/models/events.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  EventScreen({Key key, @required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Takvim"),
      ),
      body: Column(
        children: [
          Container(
            height: 20,
          ),
          Row(
          children: [
            Text(event.title, style: TextStyle(
              fontSize: 20
            ),),
            Spacer()
          ],
        ),
          Row(
            children: [
              Text(event.konum, style: TextStyle(
                  fontSize: 20)),
              Spacer()
            ],
          ),
          Spacer(flex: 1,),
          Row(
            children: [
              Spacer(flex: 8,),
              Text("Saat : ${event.hour.toString()}.${event.minute.toString()}",style: TextStyle(
                  fontSize: 15
              ),),
              Spacer(flex: 40,),
              Text("Tarih : ${event.day}/${event.month}/${event.year}",
                style: TextStyle(
                    fontSize: 15
                ),),
              Spacer(flex: 8,)
            ],
          ),
      Spacer(flex: 10,),
          Row(
            children: [
              RaisedButton(
                child: Text("geri dön"),
                  onPressed: (){
                    Navigator.pop(context, event);
                  }),
              RaisedButton(
                child: Text("Sil"),
                  onPressed: () async {
                  await deleteEvent();
                  Navigator.pop(context, null);
                  })
            ],
          )
      ],)
    );
  }

  deleteEvent() async {
    await FirebaseFirestore.instance.collection("events").get().then((value) => value.docs.forEach((element) {
     print(element.data());
     Event event2 = fromFirebaseEvent(element);
     print(event2.title);
     if(event.title == event2.title && event.month == event2.month && event.day == event2.day && event.minute == event2.minute && event.hour == event2.hour && event.konum == event2.konum && event.year == event2.year){
       FirebaseFirestore.instance.collection("events")
           .doc(element.id)
           .delete()
           .then((value) => print("event Deleted"))
           .catchError((error) => print("Failed to delete event: $error"));
     }
    }));

  }
  fromFirebaseEvent(dynamic element){
    return Event(element.data()["day"],element.data()["month"],element.data()["year"],element.data()["hour"],element.data()["minute"],element.data()["konum"],element.data()["title"]);
  }
}
