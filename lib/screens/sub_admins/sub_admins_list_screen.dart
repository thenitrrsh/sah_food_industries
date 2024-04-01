import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/providers/admin_subadmin_provider.dart';

import '../../Constants.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../../models/user_model.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import '../staffs/add_staff_screen.dart';
import 'add_sub_admin_screen.dart';

enum SampleItem { Edit }

class SubAdminsListScreen extends StatefulWidget {
  const SubAdminsListScreen({super.key});

  @override
  State<SubAdminsListScreen> createState() => _SubAdminsListScreenState();
}

class _SubAdminsListScreenState extends State<SubAdminsListScreen> {
  SampleItem? selectedMenu;
  // late UserScreenProvider userScreenProvider;
  bool isLoading = false;
  // List<UserModel> allList = [];
  // List<UserModel> userList = [];
  TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // final UserBloc userBloc = UserBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    Provider.of<AdminSubAdminProvider>(context, listen: false)
        .getAdminList(isReset: true);
    scrollController.addListener(() {
      if (scrollController.hasClients) {
        var nextPageTrigger = 0.6 * scrollController.position.maxScrollExtent;
        print("44 working");
        if (scrollController.position.pixels > nextPageTrigger &&
            Provider.of<AdminSubAdminProvider>(context, listen: false)
                    .paginationLoading ==
                false) {
          Provider.of<AdminSubAdminProvider>(context, listen: false)
              .getAdminList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AdminSubAdminProvider adminSubAdminProvider =
        Provider.of<AdminSubAdminProvider>(context);
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
            "All Sub Admins",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          backgroundColor: Constants.bgBlueColor,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  " Total: ${adminSubAdminProvider.adminData?.data?.length ?? "0"} ",
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
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
                                builder: (context) => AddSubAdminScreen()));
                        // setState(() {
                        init();
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
              adminSubAdminProvider.searchData(val ?? "");
            },
          ),
          if (adminSubAdminProvider.loading == true)
            const Expanded(
                child: Center(
              child: CircularProgressIndicator(),
            ))
          else if (adminSubAdminProvider.adminData?.error != null)
            const Expanded(
                child: Center(
              child: Text("Something went wrong"),
            ))
          else if (adminSubAdminProvider.adminData?.data?.isEmpty ?? true)
            const Expanded(
                child: Center(
              child: Text("No Data"),
            ))
          else
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
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
                    const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ),

                    // if (userList.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            adminSubAdminProvider.adminData?.data?.length,
                        itemBuilder: (context, index) {
                          // print("137 checking userlist${userList.length}");
                          UserModel userData =
                              adminSubAdminProvider.adminData!.data![index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
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
                                              BorderRadiusDirectional.circular(
                                                  20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                    ExactAssetImage(
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
                                                  Expanded(
                                                    child: Text(
                                                        userData?.name ?? '',
                                                        style: const TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white)),
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
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            "1234567890",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
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
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            title:
                                                                                const Text("Are you sure want to delete?"),
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
                                                              Icons
                                                                  .delete_forever,
                                                              size: 30,
                                                              color: Colors
                                                                  .red.shade300,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
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
                                                          const Text(
                                                            "Total Staff: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            "${userData.totalStaff ?? 0}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: width / 15,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            "Region: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Container(
                                                            width: width / 3.3,
                                                            height: 20,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child: Center(
                                                              child: const Text(
                                                                "Bihar",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14,
                                                                    color: Constants
                                                                        .bgBlueColor),
                                                              ),
                                                            ),
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
                              ),
                              if (adminSubAdminProvider.paginationLoading &&
                                  index ==
                                      ((adminSubAdminProvider
                                                  .adminData?.data?.length ??
                                              0) -
                                          1))
                                const Center(
                                  child: CircularProgressIndicator(),
                                )
                            ],
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
