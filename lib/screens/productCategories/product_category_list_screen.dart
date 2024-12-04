import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/app/shared_preferences_helper.dart';
import 'package:sah_food_industries/models/product_category_model.dart';
import 'package:sah_food_industries/screens/productCategories/add_product_category_screen.dart';

import '../../Constants.dart';
import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../models/user_model.dart';
import '../../providers/product_category_provider.dart';
import '../../services/firebase_services.dart';
import '../../utils/toast_helper.dart';
import '../../utils/utils.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import '../sub_admins/add_sub_admin_screen.dart';

enum SampleItem { Edit }

class CategoryListScreen extends StatefulWidget {
  // final StaffProvider staffProvider;
  const CategoryListScreen({
    super.key,
    // required this.staffProvider
  });

  static ChangeNotifierProvider<ProductCategoryProvider> builder(
      BuildContext context) {
    return ChangeNotifierProvider<ProductCategoryProvider>(
        create: (context) => ProductCategoryProvider(),
        builder: (context, snapshot) {
          return const CategoryListScreen();
        });
  }

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    ProductCategoryProvider productCategoryProvider =
        context.watch<ProductCategoryProvider>();

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
            "Categories",
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
                  " Total: ${productCategoryProvider.staffListSearch?.length ?? 0} ",
                  style: const TextStyle(
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
                                builder: (context) =>
                                    const AddProductCategory()));

                        productCategoryProvider.getProductCategory();
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
          const SizedBox(
            height: 10,
          ),
          SearchTextField(
            hintText: "Search here...",
            height: height,
            width: width,
            searchController: productCategoryProvider.searchController,
            onChanged: (String? val) {
              productCategoryProvider.searchData();
            },
          ),
          const SizedBox(
            height: 10,
          ),

          if (productCategoryProvider.staffListSearch == null)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          if (productCategoryProvider.staffListSearch?.isEmpty ?? true)
            const Expanded(
              child: Center(child: Text("No Data")),
            )
          else
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

                    GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3.5,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            productCategoryProvider.staffListSearch?.length ??
                                0,
                        itemBuilder: (context, index) {
                          ProductCategoryModel categoryData =
                              productCategoryProvider.staffListSearch![index];
                          // List<Color> colors =
                          //     Helper.getRandomColorIndex(seed: index);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                    // color: colors.first,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10),
                                    border: Border.all(
                                        color: Constants.bgBlueColor,
                                        width: 1.5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(categoryData.name!.toUpperCase(),
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Constants
                                                  .drawerBackgroundColor)),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "Are you sure want to delete?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text("No")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Utils.alertDialog(
                                                                context,
                                                                () async {
                                                              await FirebaseServices()
                                                                  .deleteProductCategory(
                                                                      categoryData
                                                                              .docId ??
                                                                          "");
                                                              setState(() {
                                                                productCategoryProvider
                                                                    .getProductCategory();
                                                                ToastHelper
                                                                    .showToast(
                                                                        "Category Deleted Successfully");
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text("Yes")),
                                                    ],
                                                  ));
                                        },
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 30,
                                          color: Colors.red.shade600,
                                        ),
                                      ),
                                    ],
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
