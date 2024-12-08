import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/routes/routes.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../providers/staffProvider.dart';
import '../notes_screen/notes_screen.dart';
import '../reports_screen/reports_screen.dart';
import '../sales_screen/sales_screen.dart';
import '../side_menu_screen/side_drawer_screen.dart';
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
    'Orders',
    'Sales',
    'Reports',
    'Catalogue',
    'Notes',
    'Dealers',
  ];
  List<IconData> icons = [
    Icons.person,
    Icons.supervised_user_circle_sharp,
    Icons.point_of_sale_sharp,
    Icons.currency_rupee,
    Icons.sticky_note_2,
    Icons.production_quantity_limits,
    Icons.note_alt_sharp,
    Icons.person_pin_outlined
  ];

  late StaffProvider staffProvider;
  @override
  Widget build(BuildContext context) {
    staffProvider = Provider.of(context);
    // StaffProvider staffProvider = context.watch<StaffProvider>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Map<String, Color>> shuffledColors = Helper.getShuffledColors();

    int activeStaff = staffProvider.staffListSearch
            ?.where((staff) => staff.status == 'online')
            .length ??
        0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: DashboardDrawer(height: height, width: width),
      appBar: AppBar(
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, Routes.myProfileScreen);
                  },
                  icon: const Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
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
        child: SingleChildScrollView(
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
                                    style: TextStyle(
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
                                child: Center(
                                    child: Text(
                                  activeStaff.toString(),
                                  // "${staffProvider.staffListSearch?.length ?? 0}",
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
                                child: const Center(
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
              const SizedBox(
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
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final Map<String, Color> colorPair =
                          shuffledColors[index]; // Get color for current index

                      return GestureDetector(
                        onTap: () {
                          // Handle navigation logic based on index
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SubAdminsListScreen()));
                              break;
                            case 1:
                              Navigator.pushNamed(context, Routes.staffList);
                              break;
                            case 2:
                              Navigator.pushNamed(
                                  context, Routes.orderListScreen);

                              break;
                            case 3:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SalesScreen()));

                              break;
                            case 4:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ReportsScreen()));

                              break;
                            case 5:
                              Navigator.pushNamed(
                                  context, Routes.catalogScreen);

                              break;
                            case 6:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotesScreen()));
                              break;
                            case 7:
                              Navigator.pushNamed(
                                  context, Routes.dealerListScreen);
                              break;

                            // Add other cases if needed
                          }
                        },
                        child: Container(
                          height: height / 5,
                          width: width / 2.3,
                          decoration: BoxDecoration(
                            color: colorPair['background'],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: colorPair['background']!),
                          ),
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
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
      ),
    );
  }
}
