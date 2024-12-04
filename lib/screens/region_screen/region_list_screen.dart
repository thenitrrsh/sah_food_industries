import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sah_food_industries/models/region_model.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

import '../../Constants.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../utils/utils.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import 'add_region_screen.dart';

class RegionListScreen extends StatefulWidget {
  const RegionListScreen({super.key});

  @override
  State<RegionListScreen> createState() => _RegionListScreenState();
}

class _RegionListScreenState extends State<RegionListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TextEditingController searchController = TextEditingController();
  RegionListModel? snapshot;
  List<RegionModel> regionList = [];

  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    await FirebaseServices().getRegions().then((value) {
      setState(() {
        snapshot = value;
        regionList = snapshot?.regionList ?? [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      // backgroundColor: Constants.bgBlueColor,
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
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: Text(
                  " Total: ${regionList.length ?? 0} ",
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
                      borderRadius: BorderRadiusDirectional.circular(5),
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
                        setState(() {
                          init();
                        });
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
      body: Builder(builder: (context) {
        if (snapshot == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot?.error != null) {
          return Center(
            child: Text(snapshot?.error ?? ""),
          );
        }
        return Container(
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
                  if (val != null) {
                    setState(() {
                      regionList = snapshot?.regionList
                              ?.where(
                                (element) =>
                                    element.regionName
                                        ?.toLowerCase()
                                        .contains(val ?? "") ??
                                    false,
                              )
                              .toList() ??
                          [];
                    });
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: regionList.length,
                          itemBuilder: (context, index) {
                            // print("137 checking userlist${userList.length}");
                            RegionModel itemData = regionList[index];
                            List<Color> colors =
                                Helper.getRandomColorIndex(seed: index);
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                child: Container(
                                  // height: height / 8.2,
                                  decoration: BoxDecoration(
                                      // color: Constants.bgBlueColor,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                      border: Border.all(
                                          color: colors.first, width: 1.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      width: width / 1.2,
                                      // color: Colors.red,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "State: ",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 12,
                                                        color: Colors.black54),
                                                  ),
                                                  Text(
                                                    itemData.regionName ?? "",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                        color: Constants
                                                            .bgBlueColor),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Utils.alertDialog(context,
                                                      () async {
                                                    await FirebaseServices()
                                                        .deleteRegion(
                                                            itemData.docId ??
                                                                "");
                                                    await init();
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.black12,
                                                  child: Icon(
                                                    Icons.delete_forever,
                                                    color: Colors.red.shade600,
                                                    size: 30,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            "Region: ",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Colors.black54),
                                          ),
                                          SizedBox(
                                            width: width / 1.5,
                                            child: Text(
                                              maxLines: 2,
                                              itemData.regionName ?? "",
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Constants.bgBlueColor),
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
        );
      }),
    );
  }
}
