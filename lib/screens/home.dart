import 'package:calender/screens/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'event_page.dart';
import '../models/events.dart';
import '../models/time.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Time> pzt = [];
  List<Time> sal = [];
  List<Time> car = [];
  List<Time> per = [];
  List<Time> cum = [];
  List<Time> cmt = [];
  List<Time> paz = [];
  List<Event> thisEvents = [];
  List<Event> events = [
    Event(
        "1",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "abc"),
    Event(
        "1",
        "ub",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "mno"),
    Event(
        "15",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "öpr"),
    Event(
        "15",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "sşt"),
    Event(
        "15",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "uüv"),
    Event(
        "15",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "yza"),
    Event(
        "15",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "bcd"),
    Event(
        "1",
        "Oca",
        "2022",
        12,
        10,
        "sdfmdslaksldai",
        "efg"),
    Event(
        "1",
        "Mar",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "hıi"),
    Event(
        "1",
        "Oca",
        "2021",
        12,
        10,
        "sdfmdslaksldai",
        "jkl"),
  ];
  int ay = 0;
  int year = 2021;
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
  List yearsAndDays = [];
  initState(){
    super.initState();
    getEvents();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("takvim"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              Spacer(flex: 1,),
              RaisedButton(
                  child: Text("önceki ay"),
                  onPressed: () {
                    thisEvents = [];
                    if (ay != 0) {
                      setState(() {
                        ay = ay - 1;
                      });
                    } else {
                      setState(() {
                        ay = 11;
                        year = year - 1;
                      });
                    }
                  }),
              Spacer(flex: 2,),
              RaisedButton(
                  child: Text("sonraki ay"),
                  onPressed: () {
                    thisEvents = [];
                    if (ay != 11) {
                      setState(() {
                        ay = ay + 1;
                      });
                    } else {
                      setState(() {
                        ay = 0;
                        year = year + 1;
                      });
                    }
                  }),
              Spacer(flex: 1,)
            ],
          ),
          buildMonth(aylar[ay], days(year), year, events),
          buildEvents()
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await addEvent();
        },
      ),
    );
  }

  days(int year) {
    List<Time> listThisYear = [];
    if (year % 4 == 0) {
      for (var day = 1; day < 367; day++) {
        String string = DateFormat.yMMMEd("TR_tr")
            .format(DateTime.utc(
            year,
            1,
            day,
            0,
            0,
            0,
            0,
            0));
        //   print(string);
        string = string.replaceAll(new RegExp(r'[^\w\s]+'), '');
        List<String> list = string.split(new RegExp(r" "));
        listThisYear.add(Time(
          list[0],
          list[1],
          int.tryParse(list[2]),
          list[3],
        ));
      }
    } else {
      for (var day = 1; day < 366; day++) {
        String string = DateFormat.yMMMEd("TR_tr")
            .format(DateTime.utc(
            year,
            1,
            day,
            0,
            0,
            0,
            0,
            0));
        //print(string);
        string = string.replaceAll(new RegExp(r'[^\w\s]+'), '');
        List<String> list = string.split(new RegExp(r" "));
        listThisYear.add(Time(
          list[0],
          list[1],
          int.tryParse(list[2]),
          list[3],
        ));
      }
    }
//  print(list2021.length);
    listThisYear.forEach((element) {
      // print(element.day);
    });
    return listThisYear;
  }

  buildMonth(String month, List<Time> list, int year, List events) {
    List<Time> list2 = [];
    pzt = [];
    sal = [];
    car = [];
    per = [];
    cum = [];
    cmt = [];
    paz = [];

    list.forEach((element) {
      // print(element.month);
      if (element.month == month) {
        list2.add(element);
        //print(element.daysOfWeek);
      }
    });

    list2.forEach((element) {
      if (element.daysOfWeek == "Pzt") {
        pzt.add(element);
      }
      if (element.daysOfWeek == "Sal") {
        sal.add(element);
      }
      if (element.daysOfWeek == "ar") {
        car.add(element);
      }
      if (element.daysOfWeek == "Per") {
        per.add(element);
      }
      if (element.daysOfWeek == "Cum") {
        cum.add(element);
      }
      if (element.daysOfWeek == "Cmt") {
        cmt.add(element);
      }
      if (element.daysOfWeek == "Paz") {
        paz.add(element);
      }
    });

    if (int.tryParse(pzt[0].day) == 1) {} else
    if (int.tryParse(sal[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    } else if (int.tryParse(car[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      sal.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    } else if (int.tryParse(per[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      sal.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      car.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    } else if (int.tryParse(cum[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      sal.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      car.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      per.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    } else if (int.tryParse(cmt[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      sal.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      car.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      per.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      cum.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    } else if (int.tryParse(paz[0].day) == 1) {
      pzt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      sal.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      car.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      per.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      cum.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
      cmt.insert(
          0,
          Time(
            "",
            "",
            0,
            "",
          ));
    }

    pzt.add(Time(
      "",
      "",
      0,
      "",
    ));
    sal.add(Time(
      "",
      "",
      0,
      "",
    ));
    car.add(Time(
      "",
      "",
      0,
      "",
    ));
    per.add(Time(
      "",
      "",
      0,
      "",
    ));
    cum.add(Time(
      "",
      "",
      0,
      "",
    ));
    cmt.add(Time(
      "",
      "",
      0,
      "",
    ));
    paz.add(Time(
      "",
      "",
      0,
      "",
    ));
    pzt.add(Time(
      "",
      "",
      0,
      "",
    ));
    sal.add(Time(
      "",
      "",
      0,
      "",
    ));
    car.add(Time(
      "",
      "",
      0,
      "",
    ));
    per.add(Time(
      "",
      "",
      0,
      "",
    ));
    cum.add(Time(
      "",
      "",
      0,
      "",
    ));
    cmt.add(Time(
      "",
      "",
      0,
      "",
    ));
    paz.add(Time(
      "",
      "",
      0,
      "",
    ));

    return Column(
      children: [
        Text(year.toString()),
        Text(month),
        Table(
          children: [
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("pzt"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("sal"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("çar"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("per"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("cum"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("cmt"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("paz"),
                ),
              ],
            ),
            TableRow(
              children: [
                timeToWidget(pzt[0]),
                timeToWidget(sal[0]),
                timeToWidget(car[0]),
                timeToWidget(per[0]),
                timeToWidget(cum[0]),
                timeToWidget(cmt[0]),
                timeToWidget(paz[0])
              ],
            ),
            TableRow(
              children: [
                timeToWidget(pzt[1]),
                timeToWidget(sal[1]),
                timeToWidget(car[1]),
                timeToWidget(per[1]),
                timeToWidget(cum[1]),
                timeToWidget(cmt[1]),
                timeToWidget(paz[1])
              ],
            ),
            TableRow(
              children: [
                timeToWidget(pzt[2]),
                timeToWidget(sal[2]),
                timeToWidget(car[2]),
                timeToWidget(per[2]),
                timeToWidget(cum[2]),
                timeToWidget(cmt[2]),
                timeToWidget(paz[2])
              ],
            ),
            TableRow(
              children: [
                timeToWidget(pzt[3]),
                timeToWidget(sal[3]),
                timeToWidget(car[3]),
                timeToWidget(per[3]),
                timeToWidget(cum[3]),
                timeToWidget(cmt[3]),
                timeToWidget(paz[3])
              ],
            ),
            buildTableRow(4),
            buildTableRow(5)
          ],
        ),
      ],
    );
  }

  timeToWidget(Time time) {
    List<Widget> valueEvents = [];
    events.forEach((element) {
      if (time.year.toString() == element.year &&
          time.month == element.month &&
          time.day == element.day) {
        setState(() {
          valueEvents.add(Text("."));
        });
      }
    });
    if (valueEvents.length > 4) {
      valueEvents = [Text("."), Text("."), Text("."), Text(".")];
    }
    valueEvents.insert(0, Spacer());
    valueEvents.add(Spacer());
    return Padding(
        padding: EdgeInsets.all(5),
        child: FlatButton(
          child: Column(children: [
            Text(time.day, style: TextStyle(color: Colors.black)),
            Row(children: valueEvents)
          ]),
          onPressed: () {
            thisEvents = [];
            events.forEach((element) {
              if (time.year.toString() == element.year &&
                  time.month == element.month &&
                  time.day == element.day) {
                setState(() {
                  thisEvents.add(element);
                });
              }
            });
          },
        ));
  }

  buildText(int number) {
    if (number < 1) {
      return Text("");
    } else {
      Text(number.toString());
    }
  }

  buildEvents() {
    return Container(
      child: ListView.builder(

        itemCount: thisEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(thisEvents[index].title),
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EventScreen(event: thisEvents[index])));
              getEvents();
              thisEvents = [];
              });
        },
      ),
      height: MediaQuery
          .of(context)
          .size
          .height / 2.5,
      width: MediaQuery
          .of(context)
          .size
          .width / 1.2,
    );
  }

  buildTableRow(int index) {
    if (pzt[index].day != "") {
      return TableRow(
        children: [
          timeToWidget(pzt[index]),
          timeToWidget(sal[index]),
          timeToWidget(car[index]),
          timeToWidget(per[index]),
          timeToWidget(cum[index]),
          timeToWidget(cmt[index]),
          timeToWidget(paz[index])
        ],
      );
    } else {
      return TableRow(
        children: [
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          ),
          Container(
            width: 0,
            height: 0,
          )
        ],
      );
    }
  }
  addEvent() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddPage()));
    await getEvents();
  }


  getEvents() async {
    List<Event> list = [];
    await FirebaseFirestore.instance.collection("events").get().then((value) => value.docs.forEach((element) {
      if(FirebaseAuth.instance.currentUser.uid == element.data()["user"]){
        list.add(fromFirebaseEvent(element));
      }
    }));
    setState(() {
      events = list;
    });
  }

  fromFirebaseEvent(dynamic element){
    return Event(element.data()["day"],element.data()["month"],element.data()["year"],element.data()["hour"],element.data()["minute"],element.data()["konum"],element.data()["title"]);
  }
}