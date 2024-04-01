import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Constants.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import '../sub_admins/add_sub_admin_screen.dart';
import 'add_region_screen.dart';

class RegionListScreen extends StatefulWidget {
  const RegionListScreen({super.key});

  @override
  State<RegionListScreen> createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<RegionListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      backgroundColor: Constants.bgBlueColor,
      resizeToAvoidBottomInset: true,
      drawer: DashboardDrawer(height: height, width: width),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Regions',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          actions: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: Text(
                  " Total: 10 ",
                  style: TextStyle(
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
                                builder: (context) =>
                                    const CreateRegionScreen()));
                        // setState(() {
                        // init();
                        // });
                      },
                      child: const Text(
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
      body: Container(
        height: height / 1,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            SearchTextField(
              hintText: "Search here...",
              height: height,
              width: width,
              searchController: searchController,
              onChanged: (String? val) {
                // adminSubAdminProvider.searchData(val ?? "");
              },
            ),
            SizedBox(
              height: 5,
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
                            padding: const EdgeInsets.all(5),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(20)),
                              elevation: 3,
                              child: GestureDetector(
                                child: Container(
                                  // height: height / 8.2,
                                  decoration: BoxDecoration(
                                      color: Constants.bgBlueColor,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5, left: 5),
                                      child: Column(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width / 1.1,
                                            // color: Colors.red,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Row(
                                                  children: [
                                                    Text(
                                                      "State: ",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      " Bihar ",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red.shade300,
                                                  size: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 1,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Region: ",
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    width: width / 1.5,
                                                    child: Text(
                                                      maxLines: 2,
                                                      "Madhubani",
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
