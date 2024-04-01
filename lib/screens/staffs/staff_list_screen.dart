import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Constants.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import '../sub_admins/add_sub_admin_screen.dart';
import 'add_staff_screen.dart';

enum SampleItem { Edit }

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({super.key});

  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  SampleItem? selectedMenu;
  // late UserScreenProvider userScreenProvider;
  bool isLoading = false;
  bool isActiveSeleted = false;
  bool isAllSeleted = true;
  // List<UserModel> allList = [];
  // List<UserModel> userList = [];
  TextEditingController searchController = TextEditingController();

  // final UserBloc userBloc = UserBloc();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   init();
  // }

  // init() async {
  //   isLoading = true;
  //   setState(() {});
  //   allList.clear();
  //   allList.addAll(await userBloc.getUserList());
  //   print("42 working");
  //   userList.clear();
  //   if (searchController.text.trim().isNotEmpty) {
  //     userList.addAll(allList
  //         .where((element) => element.phone!.contains(searchController.text)));
  //   } else {
  //     userList.addAll(allList);
  //   }
  //   isLoading = false;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.black,
      drawer: DashboardDrawer(
        height: height,
        width: width,
      ),
      appBar: AppBar(
          title: const Text(
            "Staff",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Constants.bgBlueColor,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  " Total: 5 ",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Container(
                  height: 30,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.white),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        // UserScreenProvider userScreenProvider =
                        // Provider.of(context, listen: false);
                        // userScreenProvider.isUpdateUser = false;
                        //
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddStaffScreen()));
                        // setState(() {
                        //   init();
                        // });
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontSize: 17,
                            color: Constants.bgBlueColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )

            // Padding(
            //   padding: const EdgeInsets.only(right: 10),
            //   child: SizedBox(
            //     height: 5,
            //     width: width / 4,
            //     child: MaterialButton(
            //       shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadiusDirectional.circular(15)),
            //       color: Colors.blue,
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             Te(
            //                 builder: (context) => AddUserScreen()));
            //       },
            //       child: Text(
            //         " Add",
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //     ),
            //   ),
            // ),
          ]),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: TextField(
          //     controller: searchController,
          //     onChanged: (v) {
          //       userList.clear();
          //       if (v.isNotEmpty) {
          //         userList.addAll(allList.where((element) =>
          //             element.phone!.contains(searchController.text)));
          //       } else {
          //         userList.addAll(allList);
          //       }
          //
          //       setState(() {});
          //     },
          //     decoration: InputDecoration(
          //       hintText: 'Search...',
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(25.0),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          SearchTextField(
            hintText: "Search here...",
            height: height,
            width: width,
            searchController: searchController,
            onChanged: (String? val) {
              setState(() {});
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              height: 40,
              width: width / 1.2,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      isAllSeleted = true;
                      isActiveSeleted = false;
                      setState(() {});
                    },
                    child: Container(
                        height: 40,
                        width: width / 2.4,
                        decoration: BoxDecoration(
                            color: isAllSeleted == false
                                ? Constants.homeCardColor
                                : Constants.bgBlueColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topLeft: Radius.circular(5))),
                        child: Center(
                            child: Text(
                          "All",
                          style: TextStyle(
                              color: isAllSeleted == false
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w500),
                        ))),
                  ),
                  GestureDetector(
                    onTap: () {
                      isActiveSeleted = true;
                      isAllSeleted = false;
                      setState(() {});
                    },
                    child: Container(
                        height: 40,
                        width: width / 2.4,
                        decoration: BoxDecoration(
                            color: isActiveSeleted == false
                                ? Constants.homeCardColor
                                : Constants.bgBlueColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        child: Center(
                            child: Text(
                          "Active",
                          style: TextStyle(
                              color: isActiveSeleted == false
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.w500),
                        ))),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: MaterialButton(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadiusDirectional.circular(15)),
                  //         color: Colors.blue,
                  //         onPressed: () {
                  //           Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => AddUserScreen()));
                  //         },
                  //         child: Text(
                  //           " Add",
                  //           style: TextStyle(color: Colors.white, fontSize: 16),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // if (userList.isNotEmpty)
                  if (isActiveSeleted == true)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
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
                                // onTap: () async {
                                //   UserScreenProvider userScreenProvider =
                                //   Provider.of(context, listen: false);
                                //   userScreenProvider.isUpdateUser = true;
                                //   userScreenProvider.userName =
                                //       userData.name.toString();
                                //   userScreenProvider.phoneNumber =
                                //       userData.phone.toString();
                                //   userScreenProvider.email =
                                //       userData.email.toString();
                                //   userScreenProvider.password =
                                //       userData.password.toString();
                                //   userScreenProvider.tvID =
                                //       userData.tvId.toString();
                                //   userScreenProvider.docID =
                                //       userData.docId.toString();
                                //   print("212 check ${userData.tvId}");
                                //   // setState(() {});
                                //
                                //   await Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //           const AddUserScreen()));
                                //   setState(() {
                                //     init();
                                //   });
                                // },
                                child: Container(
                                  height: height / 12,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade300,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: ExactAssetImage(
                                              "assets/profile.jpg",
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                child: Text("Ramu",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                              ),
                                              const SizedBox(
                                                height: 1,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Phone: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "1234567890",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                  )
                                                ],
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
                        })
                  else
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 5,
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
                                // onTap: () async {
                                //   UserScreenProvider userScreenProvider =
                                //   Provider.of(context, listen: false);
                                //   userScreenProvider.isUpdateUser = true;
                                //   userScreenProvider.userName =
                                //       userData.name.toString();
                                //   userScreenProvider.phoneNumber =
                                //       userData.phone.toString();
                                //   userScreenProvider.email =
                                //       userData.email.toString();
                                //   userScreenProvider.password =
                                //       userData.password.toString();
                                //   userScreenProvider.tvID =
                                //       userData.tvId.toString();
                                //   userScreenProvider.docID =
                                //       userData.docId.toString();
                                //   print("212 check ${userData.tvId}");
                                //   // setState(() {});
                                //
                                //   await Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //           const AddUserScreen()));
                                //   setState(() {
                                //     init();
                                //   });
                                // },
                                child: Container(
                                  height: height / 8,
                                  decoration: BoxDecoration(
                                      color: Constants.bgBlueColor,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Row(
                                      children: [
                                        const CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundImage: ExactAssetImage(
                                              "assets/profile.jpg",
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10, left: 5),
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Expanded(
                                                child: Text("Ramu",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20,
                                                        color: Colors.white)),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Phone: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        "1234567890",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: width / 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        // onTap: () {
                                                        //   Navigator.push(
                                                        //       context,
                                                        //       MaterialPageRoute(
                                                        //           builder: (context) =>
                                                        //               UserReportScreen(
                                                        //                 docId: userList[
                                                        //                 index]
                                                        //                     .docId ??
                                                        //                     "",
                                                        //                 mobile: userList[
                                                        //                 index]
                                                        //                     .phone ??
                                                        //                     "",
                                                        //                 name: userList[
                                                        //                 index]
                                                        //                     .name ??
                                                        //                     "",
                                                        //               )));
                                                        // },
                                                        child: const Icon(
                                                          Icons.add_chart,
                                                          size: 28,
                                                          color: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                        title: const Text(
                                                                            "Are you sure want to delete?"),
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text("No")),
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                // userList
                                                                                //     .remove(
                                                                                //     index);
                                                                                //
                                                                                // setState(
                                                                                //         () {});
                                                                                // onUserDelete(
                                                                                //     userList[index]
                                                                                //         .docId ??
                                                                                //         "");
                                                                                // print(
                                                                                //     "241 userList Length ${userList.length}");
                                                                              },
                                                                              child: Text("Yes")),
                                                                        ],
                                                                      ));
                                                        },
                                                        child: Icon(
                                                          Icons.delete_forever,
                                                          size: 30,
                                                          color: Colors
                                                              .red.shade300,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Total Orders: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        "10",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: width / 4.2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Total Sale: ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        "10",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // const Spacer(),
                                        // Center(
                                        //   child: Row(
                                        //     children: [
                                        //       GestureDetector(
                                        //         // onTap: () {
                                        //         //   Navigator.push(
                                        //         //       context,
                                        //         //       MaterialPageRoute(
                                        //         //           builder: (context) =>
                                        //         //               UserReportScreen(
                                        //         //                 docId: userList[
                                        //         //                 index]
                                        //         //                     .docId ??
                                        //         //                     "",
                                        //         //                 mobile: userList[
                                        //         //                 index]
                                        //         //                     .phone ??
                                        //         //                     "",
                                        //         //                 name: userList[
                                        //         //                 index]
                                        //         //                     .name ??
                                        //         //                     "",
                                        //         //               )));
                                        //         // },
                                        //         child: const Icon(
                                        //           Icons.add_chart,
                                        //           size: 28,
                                        //           color: Colors.green,
                                        //         ),
                                        //       ),
                                        //       const SizedBox(
                                        //         width: 10,
                                        //       ),
                                        //       GestureDetector(
                                        //         onTap: () {
                                        //           showDialog(
                                        //               context: context,
                                        //               builder: (context) =>
                                        //                   AlertDialog(
                                        //                     title: const Text(
                                        //                         "Are you sure want to delete?"),
                                        //                     actions: [
                                        //                       TextButton(
                                        //                           onPressed: () {
                                        //                             Navigator.pop(
                                        //                                 context);
                                        //                           },
                                        //                           child:
                                        //                               Text("No")),
                                        //                       TextButton(
                                        //                           onPressed: () {
                                        //                             // userList
                                        //                             //     .remove(
                                        //                             //     index);
                                        //                             //
                                        //                             // setState(
                                        //                             //         () {});
                                        //                             // onUserDelete(
                                        //                             //     userList[index]
                                        //                             //         .docId ??
                                        //                             //         "");
                                        //                             // print(
                                        //                             //     "241 userList Length ${userList.length}");
                                        //                           },
                                        //                           child:
                                        //                               Text("Yes")),
                                        //                     ],
                                        //                   ));
                                        //         },
                                        //         child: Icon(
                                        //           Icons.delete_forever,
                                        //           size: 28,
                                        //           color: Colors.red,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                  // else if (userList.isEmpty && isLoading == false)
                  //   Center(
                  //     child: Text("No Data"),
                  //   )
                  // else
                  //   Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// onUserDelete(String doc) async {
//   var response = await userBloc.deleteUser(doc);
//   init();
//   if (response && mounted) {
//     Navigator.pop(context);
//   }
// }
}
