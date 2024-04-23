import 'package:flutter/material.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/models/user_model.dart';
import 'package:sah_food_industries/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../catalogue_screen/catalogue_screen.dart';
import '../dashboard/home_screen.dart';
import '../login_register_screen.dart/login_screen.dart';
import '../notes_screen/notes_screen.dart';
import '../region_screen/region_list_screen.dart';
import '../reports_screen/reports_screen.dart';
import '../sales_screen/sales_screen.dart';
import '../staffs/staff_list_screen.dart';
import '../sub_admins/sub_admins_list_screen.dart';

class DashboardDrawer extends StatefulWidget {
  const DashboardDrawer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  State<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  bool isButtonClick = false;

  @override
  Widget build(BuildContext context) {
    // LoginModel userData = SharedPreferencesHelper.getUserDetails();
    UserModel? userData = SharedPreferencesHelper.getUserData();
    String adminType = userData?.type ?? "";
    return Drawer(
      width: widget.width / 1.4,
      backgroundColor: Constants.drawerBackgroundColor,
      child: Column(
        children: [
          Container(
            height: widget.height / 5.9,

            // width: weidth / 4,
            color: Constants.drawerBackgroundColor,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/logo_sfi.png',
                            // color: Colors.blue,
                            fit: BoxFit.cover,
                          ),
                        )),
                    SizedBox(
                      width: widget.width / 45,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Mukesh Sah",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: widget.width / 2.7,
                          // color: Colors.red,
                          child: const Text(
                            overflow: TextOverflow.ellipsis,
                            "Admin",
                            style:
                                TextStyle(fontSize: 12, color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          // Container(
          //   height: height / 13,
          //   // color: Colors.white,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 8.0, right: 8),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         MaterialButton(
          //           onPressed: () {},
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20)),
          //           color: userData.data!.user!.userOtherRole == "admin"
          //               ? Colors.transparent
          //               : Colors.white,
          //           child: Text(
          //             "EMPLOYEE",
          //             style: TextStyle(
          //                 color: userData.data!.user!.userOtherRole == "admin"
          //                     ? Colors.white
          //                     : Colors.black),
          //           ),
          //         ),
          //         MaterialButton(
          //           onPressed: () {},
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(15)),
          //           color: userData.data!.user!.userOtherRole == "admin"
          //               ? Colors.white
          //               : Colors.transparent,
          //           child: Text(
          //             "ADMIN",
          //             style: TextStyle(
          //                 color: userData.data!.user!.userOtherRole == "admin"
          //                     ? Colors.black
          //                     : Colors.white),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  DrawerListTile(
                    text: 'Dashboard',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                 if(adminType == 'admin') ...[
                    DrawerListTile(
                      text: 'Regions',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegionListScreen()));
                      },
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: 80,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white12,
                                  Colors.white70,
                                  Colors.white10
                                ])),
                      ),
                    ),
                    DrawerListTile(
                      text: 'Sub-Admins',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const SubAdminsListScreen()));
                      },
                    ),
                    Center(
                      child: Container(
                        height: 1,
                        width: 80,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white12,
                                  Colors.white70,
                                  Colors.white10
                                ])),
                      ),
                    ),


                  ],
                  DrawerListTile(
                    text: 'Staffs',
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const StaffListScreen()));
                      Navigator.pushNamed(context, Routes.staffList);
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Reports',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportsScreen()));
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Sales',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SalesScreen()));
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Catalogue',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CatalogueScreen()));
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white12,
                                Colors.white70,
                                Colors.white10
                              ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Product Category',
                    onTap: () {
                      Navigator.pushNamed(context, Routes.productCategoryListScreen);
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Notes',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesScreen()));
                    },
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: 80,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            Colors.white12,
                            Colors.white70,
                            Colors.white10
                          ])),
                    ),
                  ),
                  DrawerListTile(
                    text: 'Logout',
                    icon: Icons.logout,
                    onTap: () async {
                      // TimeSheetProvider timeSheetProvider =
                      //     Provider.of(context, listen: false);
                      // timeSheetProvider.selectedEmployeeController.clear();
                      // _showLogoutAlertDialog(context);
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginScreen()),
                      //     (route) => false);

                      final sp = await SharedPreferences.getInstance();
                      sp.clear();



                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                              (route) => false);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showLogoutAlertDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          elevation: 15,
          backgroundColor: Constants.drawerCardColor,
          title: const Center(
              child: Text(
            'Log Out',
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          )),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                  child: Text(
                    'Are you sure want to logout?',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadiusDirectional.circular(5)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => NewLeaveScreen()));
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 35,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadiusDirectional.circular(5)),
                  child: Center(
                    child: TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () async {
                        // final sp = await SharedPreferences.getInstance();
                        // sp.clear();
                        SharedPreferencesHelper.clearSharedPreferences();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (route) => false);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({super.key, required this.text, this.onTap, this.icon});
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        color: Constants.drawerBackgroundColor,
        borderOnForeground: false,
        surfaceTintColor: Constants.drawerBackgroundColor,
        elevation: 20,
        child: ListTile(
            dense: true,
            title: Text(
              text,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              icon ?? Icons.keyboard_arrow_right,
              size: 23,
              color: Colors.white70,
            ),
            onTap: onTap),
      ),
    );
  }
}
