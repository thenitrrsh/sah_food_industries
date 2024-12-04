import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/models/product_model.dart';
import 'package:sah_food_industries/providers/product_category_provider.dart';

import '../../Constants.dart';
import '../../routes/routes.dart';
import '../productDetailScreen/product_detail_screen.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import 'add_product_screen.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();

  static ChangeNotifierProvider<ProductCategoryProvider> builder(
      BuildContext context) {
    return ChangeNotifierProvider<ProductCategoryProvider>(
        create: (context) => ProductCategoryProvider(),
        builder: (context, snapshot) {
          return const CatalogueScreen();
        });
  }
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  late ProductCategoryProvider productProvider;
  bool isAllSelected = true;
  bool isSpicsSelected = false;
  bool isTealeafSelected = false;
  int? selectedCategory;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<String> imageList = [
    'assets/chilli.jpeg',
    'assets/tea.jpg',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productProvider =
        Provider.of<ProductCategoryProvider>(context, listen: false);
    init();
  }

  init() {
    productProvider.getProductCategory();
    productProvider.getProducts(null);
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductCategoryProvider>(context);
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
                      borderRadius: BorderRadiusDirectional.circular(5),
                      color: Colors.white),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddProductScreen(
                                addProductProvider: productProvider,
                              ),
                            ));
                      },
                      child: Text(
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
            Container(
              height: height / 17,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productProvider.categoryList?.length,
                itemBuilder: (context, index) {
                  final categoryList = productProvider.categoryList?[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index == 0) ...[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = null;
                              productProvider.getProducts(null);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(
                                height: height / 17,
                                width: width / 3.5,
                                decoration: BoxDecoration(
                                    color: selectedCategory == null
                                        ? Constants.bgBlueColor
                                        : Colors.black12,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Center(
                                    child: Text(
                                  'All',
                                  style: TextStyle(
                                      // color: Colors.white,
                                      color: selectedCategory == null
                                          ? Colors.white
                                          : Constants.bgBlueColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ))),
                          ),
                        ),
                        SizedBox(
                          width: .5,
                        ),
                      ],
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                            productProvider.getProducts(
                                productProvider.categoryList?[index].docId);
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Container(
                              height: height / 17,
                              width: width / 3.5,
                              decoration: BoxDecoration(
                                  color: selectedCategory == index
                                      ? Constants.bgBlueColor
                                      : Colors.black12,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Center(
                                  child: Text(
                                categoryList?.name ?? "NA",
                                style: TextStyle(
                                    // color: Colors.white,
                                    color: selectedCategory == index
                                        ? Colors.white
                                        : Constants.bgBlueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ))),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // if (isAllSelected == true)
            Expanded(
                child: AllProduct(
                    height: height,
                    width: width,
                    onRefresh: () {
                      init();
                    })),
            // if (isSpicsSelected == true)
            //   Expanded(child: Spices(height: height, width: width)),
            // if (isTealeafSelected == true)
            //   Expanded(child: Tealeaf(height: height, width: width)),
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

// class Tealeaf extends StatelessWidget {
//   const Tealeaf({
//     super.key,
//     required this.height,
//     required this.width,
//   });
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Container(
//         height: height / 1,
//         decoration: BoxDecoration(
//           // color: Constants.homeCardColor,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(5),
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.68,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: 12,
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, int index) {
//               // List<Color> colors =
//               //     Helper.getRandomColorIndex(seed: index);
//               return GestureDetector(
//                 // onTap: () {
//                 //   if (index == 0) {
//                 //     Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (context) =>
//                 //             const SubAdminsListScreen()));
//                 //   } else {
//                 //     if (index == 1) {
//                 //       Navigator.push(
//                 //           context,
//                 //           MaterialPageRoute(
//                 //               builder: (context) =>
//                 //               const StaffListScreen()));
//                 //     } else {
//                 //       if (index == 2) {
//                 //         Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(
//                 //                 builder: (context) =>
//                 //                 const ReportsScreen()));
//                 //       } else {
//                 //         if (index == 3) {
//                 //           Navigator.push(
//                 //               context,
//                 //               MaterialPageRoute(
//                 //                   builder: (context) =>
//                 //                   const SalesScreen()));
//                 //         } else {
//                 //           if (index == 4) {
//                 //             Navigator.push(
//                 //                 context,
//                 //                 MaterialPageRoute(
//                 //                     builder: (context) =>
//                 //                     const CatalogueScreen()));
//                 //           } else {
//                 //             if (index == 5) {
//                 //               Navigator.push(
//                 //                   context,
//                 //                   MaterialPageRoute(
//                 //                       builder: (context) =>
//                 //                       const NotesScreen()));
//                 //             }
//                 //           }
//                 //         }
//                 //       }
//                 //     }
//                 //   }
//                 // },
//                 child: Container(
//                   // height: height / 3,
//                   // width: width / ,
//                   decoration: BoxDecoration(
//                       // color: colors.first,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Colors.black12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Icon(
//                         //   icons[index],
//                         //   color: Colors.white,
//                         //   size: 60,
//                         // ),
//                         // Text(
//                         //   homeCardNames[index],
//                         //   style:
//                         //   TextStyle(fontSize: 18, color: Colors.white),
//                         // ),
//                         Center(
//                           child: Container(
//                             height: height / 5.5,
//                             width: width / 2.8,
//                             decoration: BoxDecoration(
//                                 // color: Colors.red,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Image.asset(
//                               'assets/images/tea.jpg',
//                               // color: Colors.blue,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//
//                         Container(
//                           height: height / 11,
//                           width: width / 2.2,
//                           // color: Colors.red,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Row(
//                                 children: [
//                                   Expanded(
//                                       child: Text(
//                                     "Darjeeling Special Tea ( 500 g )",
//                                     style: TextStyle(fontSize: 14),
//                                   )),
//                                   // Text(""),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     "₹ 200.00",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5),
//                                     child: Container(
//                                       height: 20,
//                                       width: 80,
//                                       // color: Colors.red,
//                                       child: ListView.builder(
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: 4,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             return Icon(
//                                               Icons.star,
//                                               color: Colors.orangeAccent,
//                                               size: 16,
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class Spices extends StatelessWidget {
//   const Spices({
//     super.key,
//     required this.height,
//     required this.width,
//   });
//
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Container(
//         height: height / 1,
//         decoration: BoxDecoration(
//           // color: Constants.homeCardColor,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(5),
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.68,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//             ),
//             itemCount: 12,
//             shrinkWrap: true,
//             itemBuilder: (BuildContext context, int index) {
//               // List<Color> colors =
//               //     Helper.getRandomColorIndex(seed: index);
//               return GestureDetector(
//                 // onTap: () {
//                 //   if (index == 0) {
//                 //     Navigator.push(
//                 //         context,
//                 //         MaterialPageRoute(
//                 //             builder: (context) =>
//                 //             const SubAdminsListScreen()));
//                 //   } else {
//                 //     if (index == 1) {
//                 //       Navigator.push(
//                 //           context,
//                 //           MaterialPageRoute(
//                 //               builder: (context) =>
//                 //               const StaffListScreen()));
//                 //     } else {
//                 //       if (index == 2) {
//                 //         Navigator.push(
//                 //             context,
//                 //             MaterialPageRoute(
//                 //                 builder: (context) =>
//                 //                 const ReportsScreen()));
//                 //       } else {
//                 //         if (index == 3) {
//                 //           Navigator.push(
//                 //               context,
//                 //               MaterialPageRoute(
//                 //                   builder: (context) =>
//                 //                   const SalesScreen()));
//                 //         } else {
//                 //           if (index == 4) {
//                 //             Navigator.push(
//                 //                 context,
//                 //                 MaterialPageRoute(
//                 //                     builder: (context) =>
//                 //                     const CatalogueScreen()));
//                 //           } else {
//                 //             if (index == 5) {
//                 //               Navigator.push(
//                 //                   context,
//                 //                   MaterialPageRoute(
//                 //                       builder: (context) =>
//                 //                       const NotesScreen()));
//                 //             }
//                 //           }
//                 //         }
//                 //       }
//                 //     }
//                 //   }
//                 // },
//                 child: Container(
//                   // height: height / 3,
//                   // width: width / ,
//                   decoration: BoxDecoration(
//                       // color: colors.first,
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Colors.black12)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Icon(
//                         //   icons[index],
//                         //   color: Colors.white,
//                         //   size: 60,
//                         // ),
//                         // Text(
//                         //   homeCardNames[index],
//                         //   style:
//                         //   TextStyle(fontSize: 18, color: Colors.white),
//                         // ),
//                         Center(
//                           child: Container(
//                             height: height / 5.5,
//                             width: width / 2.8,
//                             decoration: BoxDecoration(
//                                 // color: Colors.red,
//                                 borderRadius: BorderRadius.circular(5)),
//                             child: Image.asset(
//                               'assets/images/chilli.jpeg',
//                               // color: Colors.blue,
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//
//                         Container(
//                           height: height / 11,
//                           width: width / 2.2,
//                           // color: Colors.red,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Row(
//                                 children: [
//                                   Expanded(
//                                       child: Text(
//                                     "Original Red Chilli Powder ( 1 KG )",
//                                     style: TextStyle(fontSize: 14),
//                                   )),
//                                   // Text(""),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "₹ 120.00",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 5),
//                                     child: Container(
//                                       height: 20,
//                                       width: 80,
//                                       // color: Colors.red,
//                                       child: ListView.builder(
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: 4,
//                                           itemBuilder: (BuildContext context,
//                                               int index) {
//                                             return const Icon(
//                                               Icons.star,
//                                               color: Colors.orangeAccent,
//                                               size: 16,
//                                             );
//                                           }),
//                                     ),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class AllProduct extends StatelessWidget {
  AllProduct({
    super.key,
    required this.height,
    required this.width,
    required this.onRefresh,
  });

  final double height;
  final double width;
  final Function() onRefresh;

  List<String> imageList = [
    'assets/images/chilli.jpeg',
    'assets/images/tea.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    ProductCategoryProvider productProvider =
        Provider.of<ProductCategoryProvider>(context);
    List<ProductModel> productList = productProvider.productList ?? [];
    List<ProductModel> filteredProductList = productProvider.productList ?? [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: height / 1,
        decoration: BoxDecoration(
          // color: Constants.homeCardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: productList.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              // List<Color> colors =
              //     Helper.getRandomColorIndex(seed: index);
              ProductModel item = productList[index];
              //  = productProvider
              //     .getProducts(productProvider.categoryList?[index].docId);
              // // ProductModel filteredProductList = item.docId == categoryDocId;
              // final filteredProductList = productList.where((item) {
              //   final categoryDocId = productProvider.getProducts(
              //     productProvider.categoryList
              //         ?.firstWhere((category) => category.docId == item.docId,
              //             orElse: () => ProductCategoryModel(docId: ''))
              //         .docId,
              //   );
              //   return item.docId == categoryDocId;
              // }).toList();

              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                                title: item.name,
                                image: item.image,
                                weight: item.weight,
                                price: item.price.toString(),
                                description: item.description,
                                docId: item.docId,
                                provider: productProvider,
                              )));
                  onRefresh();
                  // Navigator.pushNamed(context, Routes.productDetailScreen);
                },
                child: Container(
                  // height: height / 3,
                  // width: width / ,
                  decoration: BoxDecoration(
                      // color: colors.first,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: IgnorePointer(
                            // onTap: () {
                            //   // // print("Working 685");
                            //   // Navigator.push(
                            //   //     context,
                            //   //     MaterialPageRoute(
                            //   //         builder: (context) =>
                            //   //             const ProductDetailScreen()));
                            // },
                            child: Container(
                              height: height / 5.5,
                              width: width / 2.8,
                              decoration: BoxDecoration(
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Image.network(item.image ?? ''),
                              // child: Image.asset(
                              //   imageList[Random().nextInt(2)],
                              // ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        SizedBox(
                          height: height / 11,
                          width: width / 2.2,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    item.name ?? "",
                                    // "Original Red Chilli Powder ( 1 KG )",
                                    style: const TextStyle(fontSize: 14),
                                  )),
                                  Text(item.weight ?? "NA")
                                  // Text(""),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹ ${item.price}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
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
                                              size: 16,
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
