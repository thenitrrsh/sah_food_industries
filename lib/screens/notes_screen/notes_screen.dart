import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Constants.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import 'create_notes_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      backgroundColor: Constants.bgBlueColor,
      resizeToAvoidBottomInset: true,
      drawer: DashboardDrawer(height: height, width: width),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateNotesScreen()));
        },
        elevation: 5,
        child: Icon(
          Icons.edit,
          color: Constants.bgBlueColor,
        ),
        backgroundColor: Constants.homeCardColor,
      ),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Notes',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Container(
        height: height / 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 3),
                child: Text(
                  "My Notes",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Constants.bgBlueColor,
                      fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          // print("137 checking userlist${userList.length}");
                          // UserModel userData = userList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              elevation: 3,
                              child: GestureDetector(
                                child: Container(
                                  height: height / 7,
                                  decoration: BoxDecoration(
                                      color: Constants.bgBlueColor,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Text(
                                                    " Monday 11/03/2024 12:15 PM ",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12,
                                                        color: Constants
                                                            .bgBlueColor)),
                                              ),
                                              SizedBox(
                                                width: width / 1.1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Reminder",
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white)),
                                                    Icon(
                                                      Icons.delete_forever,
                                                      color:
                                                          Colors.red.shade300,
                                                      size: 30,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                // color: Colors.red,
                                                width: width / 1.15,
                                                child: Text(
                                                  maxLines: 2,
                                                  "Indian spices include a variety of spices grown across the Indian subcontinent (a sub-region of South Asia). With different climates in different parts of the country, India produces a variety of spices, many of which are native to the subcontinent.",
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
