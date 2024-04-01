import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Constants.dart';
import '../../helper.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import 'add_product_screen.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  bool isAllSelected = true;
  bool isSpicsSelected = false;
  bool isTealeafSelected = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> imageList = [
    'assets/chilli.jpeg',
    'assets/tea.jpg',
  ];

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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: Container(
                  height: 30,
                  // width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      color: Colors.white),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddProductScreen()));
                      },
                      child: const Text(
                        " Add Product ",
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
          ],
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Catalogue',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Container(
                height: height / 15,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        isAllSelected = true;
                        isSpicsSelected = false;
                        isTealeafSelected = false;
                        setState(() {});
                      },
                      child: Container(
                          height: height / 15,
                          width: width / 3.2,
                          decoration: BoxDecoration(
                              color: isAllSelected == true
                                  ? Constants.bgBlueColor
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "All",
                            style: TextStyle(
                                color: isAllSelected == true
                                    ? Colors.white
                                    : Constants.bgBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAllSelected = false;
                        isSpicsSelected = true;
                        isTealeafSelected = false;
                        setState(() {});
                      },
                      child: Container(
                          height: height / 15,
                          width: width / 3.2,
                          color: isSpicsSelected == true
                              ? Constants.bgBlueColor
                              : Colors.white,
                          child: Center(
                              child: Text(
                            "Spices",
                            style: TextStyle(
                                color: isSpicsSelected == true
                                    ? Colors.white
                                    : Constants.bgBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAllSelected = false;
                        isSpicsSelected = false;
                        isTealeafSelected = true;
                        setState(() {});
                      },
                      child: Container(
                          height: height / 15,
                          width: width / 3.2,
                          decoration: BoxDecoration(
                              color: isTealeafSelected == true
                                  ? Constants.bgBlueColor
                                  : Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Center(
                              child: Text(
                            "Tea leaf",
                            style: TextStyle(
                                color: isTealeafSelected == true
                                    ? Colors.white
                                    : Constants.bgBlueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (isAllSelected == true)
              Expanded(child: AllProduct(height: height, width: width)),
            if (isSpicsSelected == true)
              Expanded(child: Spices(height: height, width: width)),
            if (isTealeafSelected == true)
              Expanded(child: Tealeaf(height: height, width: width)),
            Container(
              height: 10,
            )
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      ),
    );
  }
}

class Tealeaf extends StatelessWidget {
  const Tealeaf({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: height / 1,
        decoration: BoxDecoration(
          // color: Constants.homeCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // List<Color> colors =
              //     Helper.getRandomColorIndex(seed: index);
              return GestureDetector(
                // onTap: () {
                //   if (index == 0) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //             const SubAdminsListScreen()));
                //   } else {
                //     if (index == 1) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //               const StaffListScreen()));
                //     } else {
                //       if (index == 2) {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                 const ReportsScreen()));
                //       } else {
                //         if (index == 3) {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) =>
                //                   const SalesScreen()));
                //         } else {
                //           if (index == 4) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                     const CatalogueScreen()));
                //           } else {
                //             if (index == 5) {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                       const NotesScreen()));
                //             }
                //           }
                //         }
                //       }
                //     }
                //   }
                // },
                child: Container(
                  // height: height / 3,
                  // width: width / ,
                  decoration: BoxDecoration(
                      // color: colors.first,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon(
                        //   icons[index],
                        //   color: Colors.white,
                        //   size: 60,
                        // ),
                        // Text(
                        //   homeCardNames[index],
                        //   style:
                        //   TextStyle(fontSize: 18, color: Colors.white),
                        // ),
                        Center(
                          child: Container(
                            height: height / 5,
                            width: width / 2.8,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              'assets/images/tea.jpg',
                              // color: Colors.blue,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: height / 11,
                          width: width / 2.2,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Darjeeling Special Tea ( 500 g )",
                                    style: TextStyle(fontSize: 15),
                                  )),
                                  // Text(""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹ 200.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.orangeAccent,
                                              size: 20,
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Spices extends StatelessWidget {
  const Spices({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: height / 1,
        decoration: BoxDecoration(
          // color: Constants.homeCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // List<Color> colors =
              //     Helper.getRandomColorIndex(seed: index);
              return GestureDetector(
                // onTap: () {
                //   if (index == 0) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //             const SubAdminsListScreen()));
                //   } else {
                //     if (index == 1) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //               const StaffListScreen()));
                //     } else {
                //       if (index == 2) {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                 const ReportsScreen()));
                //       } else {
                //         if (index == 3) {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) =>
                //                   const SalesScreen()));
                //         } else {
                //           if (index == 4) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                     const CatalogueScreen()));
                //           } else {
                //             if (index == 5) {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                       const NotesScreen()));
                //             }
                //           }
                //         }
                //       }
                //     }
                //   }
                // },
                child: Container(
                  // height: height / 3,
                  // width: width / ,
                  decoration: BoxDecoration(
                      // color: colors.first,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon(
                        //   icons[index],
                        //   color: Colors.white,
                        //   size: 60,
                        // ),
                        // Text(
                        //   homeCardNames[index],
                        //   style:
                        //   TextStyle(fontSize: 18, color: Colors.white),
                        // ),
                        Center(
                          child: Container(
                            height: height / 5,
                            width: width / 2.8,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Image.asset(
                              'assets/images/chilli.jpeg',
                              // color: Colors.blue,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: height / 11,
                          width: width / 2.2,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Original Red Chilli Powder ( 1 KG )",
                                    style: TextStyle(fontSize: 15),
                                  )),
                                  // Text(""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹ 120",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.orangeAccent,
                                              size: 20,
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AllProduct extends StatelessWidget {
  AllProduct({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  List<String> imageList = [
    'assets/images/chilli.jpeg',
    'assets/images/tea.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: height / 1,
        decoration: BoxDecoration(
          // color: Constants.homeCardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 12,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // List<Color> colors =
              //     Helper.getRandomColorIndex(seed: index);
              return GestureDetector(
                // onTap: () {
                //   if (index == 0) {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //             const SubAdminsListScreen()));
                //   } else {
                //     if (index == 1) {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //               const StaffListScreen()));
                //     } else {
                //       if (index == 2) {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                 const ReportsScreen()));
                //       } else {
                //         if (index == 3) {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) =>
                //                   const SalesScreen()));
                //         } else {
                //           if (index == 4) {
                //             Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                     const CatalogueScreen()));
                //           } else {
                //             if (index == 5) {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                       const NotesScreen()));
                //             }
                //           }
                //         }
                //       }
                //     }
                //   }
                // },
                child: Container(
                  // height: height / 3,
                  // width: width / ,
                  decoration: BoxDecoration(
                      // color: colors.first,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon(
                        //   icons[index],
                        //   color: Colors.white,
                        //   size: 60,
                        // ),
                        // Text(
                        //   homeCardNames[index],
                        //   style:
                        //   TextStyle(fontSize: 18, color: Colors.white),
                        // ),
                        Center(
                          child: Container(
                            height: height / 5,
                            width: width / 2.8,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              imageList[Random().nextInt(2)],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                          height: height / 11,
                          width: width / 2.2,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Original Red Chilli Powder ( 1 KG )",
                                    style: TextStyle(fontSize: 15),
                                  )),
                                  // Text(""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹ 120.00",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Container(
                                      height: 20,
                                      width: 80,
                                      // color: Colors.red,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 4,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Icon(
                                              Icons.star,
                                              color: Colors.orangeAccent,
                                              size: 20,
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
