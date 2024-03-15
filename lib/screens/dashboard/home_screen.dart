import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../catalogue_screen/catalogue_screen.dart';
import '../notes_screen/notes_screen.dart';
import '../reports_screen/reports_screen.dart';
import '../sales_screen/sales_screen.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import '../staffs/staff_list_screen.dart';
import '../sub_admins/sub_admins_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> homeCardNames = [
    'Sub-Admins',
    'Staffs',
    'Reports',
    'Sales',
    'Catalogue',
    'Notes',
  ];
  List<IconData> icons = [
    Icons.person,
    Icons.supervised_user_circle_sharp,
    Icons.sticky_note_2,
    Icons.currency_rupee,
    Icons.production_quantity_limits,
    Icons.note_alt_sharp,
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DashboardDrawer(height: height, width: width),
      appBar: AppBar(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Icon(
                //   Icons.add_box,
                //   size: 28,
                // ),
                // const SizedBox(
                //   width: 5,
                // ),
                // const Icon(
                //   Icons.notifications,
                //   size: 28,
                // ),
                const SizedBox(
                  width: 5,
                ),
                Hero(
                  tag: "preview",
                  child: IconButton(
                    onPressed: () async {
                      // TimeSheetProvider timeSheetProvider =
                      // Provider.of(context, listen: false);
                      // timeSheetProvider.selectedEmployeeController.clear();
                      // _showLogoutAlertDialog();
                      // final sp = await SharedPreferences.getInstance();
                      // sp.clear();
                      //
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => LoginScreen()),
                      //     (route) => false);
                    },
                    icon: const Icon(
                      Icons.logout,
                      size: 28,
                    ),
                  ),
                )
              ],
            )
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: height / 5.5,
              width: width / 1,
              decoration: BoxDecoration(
                  // color: homeCardColor,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: Constants.homeCardColor, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today's Report",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Constants.bgBlueColor,
                              fontSize: 20),
                        ),
                        Row(
                          children: [
                            Text(
                              "Date: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Constants.bgBlueColor,
                                  fontSize: 16),
                            ),
                            Container(
                              decoration: (BoxDecoration(
                                  // color: homeCardColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8),
                                  border: Border.all(
                                      color: Constants.bgBlueColor,
                                      width: 1.5))),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Text(
                                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Constants.bgBlueColor,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: (BoxDecoration(
                                  color: Constants.greenlightbgColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8))),
                              child: const Center(
                                  child: Text(
                                "20",
                                style: TextStyle(
                                    color: Constants.greenColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            const ReusableDashboardSmallText(
                                text: "Active Staff",
                                color: Constants.greenColor)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: (BoxDecoration(
                                  color: Constants.homeCardColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8))),
                              child: const Center(
                                  child: Text(
                                "5",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            const ReusableDashboardSmallText(
                                text: "Total Order", color: Colors.blue)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: (BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8))),
                              child: Center(
                                  child: Text(
                                "200",
                                style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                            const ReusableDashboardSmallText(
                                text: "Total Sale", color: Colors.purple)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // height: height / 2.2,
              decoration: BoxDecoration(
                color: Constants.homeCardColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 6,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    List<Color> colors =
                        Helper.getRandomColorIndex(seed: index);
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SubAdminsListScreen()));
                        } else {
                          if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const StaffListScreen()));
                          } else {
                            if (index == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReportsScreen()));
                            } else {
                              if (index == 3) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SalesScreen()));
                              } else {
                                if (index == 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CatalogueScreen()));
                                } else {
                                  if (index == 5) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NotesScreen()));
                                  }
                                }
                              }
                            }
                          }
                        }
                      },
                      child: Container(
                        height: height / 5,
                        width: width / 2.3,
                        decoration: BoxDecoration(
                            color: colors.first,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colors.first)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              color: Colors.white,
                              size: 60,
                            ),
                            Text(
                              homeCardNames[index],
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
