import 'package:flutter/material.dart';
import 'package:todo/controller/helper_note.dart';
import 'package:todo/view/desc_screen.dart';
import 'package:todo/view/form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var value = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Note().db.then((value) {
      print("vvvvvvvvvvv $value");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB8E4F0),
      appBar: AppBar(
        backgroundColor: Color(0xff5584AC),
        title: Text(
          "ToDo",
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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: Note().getdb(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return (snapshot.data.length == 0)
                  ? Center(
                      child: Text("you dont have any tasks"),
                    )
                  : ListView.builder(
                      itemCount: (snapshot.data.length),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Color(0xff22577E),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return DescScreen(
                                  id: snapshot.data[index].id,
                                  description:
                                      "${snapshot.data[index].description}",
                                  title: "${snapshot.data[index].title}",
                                  date: "${snapshot.data[index].date}",
                                  done: "${snapshot.data[index].done}",
                                );
                              }));
                            },
                            title: Text(
                              " ${snapshot.data[index].title}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "${snapshot.data[index].date}",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width * .27,
                              child: Row(
                                children: [
                                  (snapshot.data[index].done == "done")
                                      ? IconButton(
                                          onPressed: () {  setState(() {
                                            Note()
                                                .updateCheck("",
                                                (snapshot.data[index].id))
                                                .then((value) {
                                              print(
                                                  "doneeee${snapshot.data[index].done}");
                                            });
                                          });},
                                          icon: Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            setState(() {
                                              Note()
                                                  .updateCheck("done",
                                                      (snapshot.data[index].id))
                                                  .then((value) {
                                                print(
                                                    "doneeee${snapshot.data[index].done}");
                                              });
                                            });
                                          },
                                          icon: Icon(
                                            Icons.check_circle_outline,
                                            color: Colors.white70,
                                          )),
                                  IconButton(
                                    onPressed: () {
                                      Note()
                                          .deletedb(snapshot.data[index].id)
                                          .then((value) {
                                        setState(() {
                                          print("dddddddddddddddddddddd$value");
                                        });
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xff5584AC),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff5584AC),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return FormScreen();
          }));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
//            Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               color: Color(0xff22577E),
//               child: ListTile(
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (BuildContext context) {
//                     return DescScreen();
//                   }));
//                 },
//                 title: Text(
//                   " title",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 subtitle: Text(
//                   "22/01/2022",
//                   style: TextStyle(
//                     color: Colors.white70,
//                   ),
//                 ),
//                 trailing: IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.delete_forever,
//                     color: Color(0xffCD1818),
//                   ),
//                 ),
//               ),
//             ),
