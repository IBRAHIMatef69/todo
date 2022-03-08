import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todo/controller/helper_note.dart';
import 'package:todo/view/home_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? title, id, description;
  String date =
      "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}   ${DateTime.now().hour}:${DateTime.now().minute}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB8E4F0),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff5584AC),
        centerTitle: true,
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        // centerTitle: true,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomRight: Radius.circular(30),
        //     bottomLeft: Radius.circular(30),
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter Title",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    labelText: "Title",
                    helperStyle: TextStyle(color: Colors.black12),
                    contentPadding: EdgeInsets.all(10),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ))),
                onChanged: (value) {
                  setState(() {
                    title = value;
                    print("title==$title");
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              TextFormField(
                maxLines: 8,
                decoration: InputDecoration(
                    focusColor: Colors.red,
                    hintText: "Enter description",
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.black,
                    labelText: "description",
                    helperStyle: TextStyle(color: Colors.red),
                    contentPadding: EdgeInsets.all(10),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ))),
                onChanged: (value) {
                  setState(() {
                    description = value;
                    print("title==$description");
                  });
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .012,
              ),
              InkWell(
                onTap: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime(2025, 6, 7, 05, 09),
                      //     onChanged: (date) {
                      //   print('change $date in time zone ' +
                      //       date.timeZoneOffset.inHours.toString());
                      // },
                      onChanged: (value) {
                    setState(() {
                      date =
                          "${value.year}-${value.month}-${value.day}  ${value.timeZoneOffset.inHours.toString()}:${value.minute}";
                      print((date).toString());
                    });
                  }, locale: LocaleType.ar);
                  // DatePicker.showDatePicker(context,
                  //     currentTime: DateTime.now(),
                  //     locale: LocaleType.ar,
                  //     maxTime: DateTime(2031, 01, 01),
                  //     minTime: DateTime(
                  //       DateTime.now().year,
                  //       DateTime.now().month,
                  //       DateTime.now().day,
                  //     ), onChanged: (value) {
                  //   setState(() {
                  //     date = "${value.year}-${value.month}-${value.day}";
                  //   });
                  // });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * .94,
                  height: MediaQuery.of(context).size.height * .08,
                  child: Card(
                    color: Color(0xff5584AC),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "$date",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .39,
              ),
              InkWell(
                onTap: () {
                  Note().insertdb({
                    'description': description,
                    'title': title,
                    'date': date,
                    'done': '0'
                  }).then((value) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomeScreen();
                    }), (route) => false);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .35,
                  height: MediaQuery.of(context).size.height * .05,
                  child: Card(
                    color: Color(0xff22577E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 17,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              //   child: Container(
              //     width: double.infinity,
              //     height: MediaQuery.of(context).size.height * .15,
              //     decoration: BoxDecoration(
              //         color: Colors.white70,
              //         borderRadius: BorderRadius.circular(7)),
              //     child: TextFormField(
              //       maxLines: 4,
              //       onChanged: (value) {
              //         setState(() {
              //           print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$title");
              //           title = value;
              //         });
              //       },
              //       validator: (value) {
              //         if (value!.isEmpty) {
              //           return "Search is Empty";
              //         }
              //       },
              //       cursorColor: Color(0xFF000000),
              //       keyboardType: TextInputType.text,
              //       decoration: InputDecoration(
              //           // prefixIcon: Icon(
              //           //   Icons.search,
              //           //   color: Color(0xFF000000).withOpacity(0.5),
              //           // ),
              //           hintText: "Search",
              //           border: InputBorder.none),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
