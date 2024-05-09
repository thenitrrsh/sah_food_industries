import 'dart:ui';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/Constants.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../models/product_category_model.dart';
import '../../models/state_model.dart';
import '../../providers/admin_subadmin_provider.dart';
import '../productCategories/provider/add_product_screen_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late AddProductProvider addProductProvider;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  // List<ProductCategoryModel>? categoryList;
  // ProductCategoryModel? productCategoryList;

  String imageUpload = "";
  String? imagePath;
  String? selectedItem;

  String docID = "";
  AdminSubAdminProvider userProvider = AdminSubAdminProvider();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // UserScreenProvider userScreenProvider = Provider.of(context, listen: false);
  //   nameController.text = userScreenProvider.userName;
  //   phoneController.text = userScreenProvider.phoneNumber;
  //   emailController.text = userScreenProvider.email;
  //   passwordController.text = userScreenProvider.password;
  //   tvIDController.text = userScreenProvider.tvID;
  //   docID = userScreenProvider.docID;
  //   print("40 working-- ${tvIDController.text} -- ${userScreenProvider.tvID}");
  //   print(
  //       "40 working-- ${passwordController.text} -- ${userScreenProvider.password}");
  //   super.initState();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addProductProvider = Provider.of(context, listen: false);
    addProductProvider.getProductCategory();
  }

  @override
  Widget build(BuildContext context) {
    addProductProvider = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Constants.bgBlueColor,
      resizeToAvoidBottomInset: true,
      key: _key,
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Add Product',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              // height: height / 1,
              width: width / 1,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 22, left: 22),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: width / 2.8,
                          color: Colors.black26,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReusableTextfield(
                          headingName: "Title",
                          hintText: "Enter Title",
                          controller: titleController),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Category",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      // SizedBox(
                      //   width: width / 1.1,
                      //   child: Card(
                      //       color: Colors.white,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(22),
                      //           side: BorderSide(
                      //               color: Constants.bgBlueColor, width: 1.5)),
                      //       child: DropdownButton<List<ProductCategoryModel>>(
                      //         isExpanded: true,
                      //         hint: Text(
                      //           "Select Category",
                      //           style: TextStyle(fontSize: 14),
                      //         ),
                      //
                      //         padding:
                      //             const EdgeInsets.only(left: 12, right: 10),
                      //         value: addProductProvider.categoryList,
                      //         iconDisabledColor: Colors.transparent,
                      //         underline: Container(
                      //           // width: width / 1.1,
                      //           color: Colors.transparent,
                      //         ),
                      //         // icon: const Icon(Icons.arrow_downward),
                      //         elevation: 16,
                      //         style: const TextStyle(
                      //             color: Colors.black54,
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.w500),
                      //         onChanged: (List<ProductCategoryModel>? value) {
                      //           addProductProvider.categoryList = value;
                      //           // print(widget.adminDashboardProvider.selectedYear);
                      //           // getRegion();
                      //         },
                      //         items: addProductProvider.categoryList?.isEmpty ??
                      //                 true
                      //             ? []
                      //             : addProductProvider.categoryList!.first.map<
                      //                     DropdownMenuItem<
                      //                         List<ProductCategoryModel>>>(
                      //                 (List<ProductCategoryModel> value) {
                      //                 return DropdownMenuItem<
                      //                     List<ProductCategoryModel>>(
                      //                   value: value,
                      //                   child: Text(
                      //                     value.name ?? "",
                      //                     style: TextStyle(),
                      //                   ),
                      //                 );
                      //               }).toList(),
                      //       )),
                      // ),
                      SizedBox(
                        width: width / 1.1,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: BorderSide(
                                  color: Constants.bgBlueColor, width: 1.5)),
                          child: GestureDetector(
                            onTap: () {
                              _showProductCategoryDropdown(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedItem == null
                                            ? "Select category"
                                            : selectedItem!,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                selectedItem == null ? 14 : 16,
                                            color: selectedItem == null
                                                ? Colors.black54
                                                : Colors.black,
                                            fontWeight: selectedItem == null
                                                ? FontWeight.w500
                                                : FontWeight.w400),
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Price",
                          hintText: "Enter Price",
                          controller: mrpController),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Description",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                            side: BorderSide(
                                color: Constants.bgBlueColor, width: 1.5)),
                        child: Container(
                          height: height / 6,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              hintText: "Enter Description",
                              contentPadding: EdgeInsets.all(12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                            side: BorderSide(
                                color: Constants.bgBlueColor, width: 1.5)),
                        child: Container(
                            // height: height / 6,
                            width: width / 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Upload Picture",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        // color: Colors.red,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Colors.black54)),
                                        child: Center(
                                            child: InkWell(
                                                onTap: () {
                                                  _onPickFile();
                                                },
                                                child: imageUpload.isNotEmpty
                                                    ? Image.file(
                                                        File(imageUpload),
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                      )
                                                    : Icon(
                                                        Icons.cloud_upload,
                                                        size: 35,
                                                        color: Constants
                                                            .bgBlueColor,
                                                      ))),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height / 14,
                      ),
                      SaveButton(
                        width: width,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showProductCategoryDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: addProductProvider.categoryList
                ?.length, // Replace 10 with the number of items in your list
            itemBuilder: (BuildContext context, int index) {
              final categoryList = addProductProvider.categoryList![index];
              print(
                  "raj cateData:${addProductProvider.categoryList?.length} --------------------------${categoryList.name} ");
              List<Color> colors = Helper.getRandomColorIndex(seed: index);
              return Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selectedItem = categoryList.name ?? "NA";
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: colors.first,
                        borderRadius: BorderRadiusDirectional.circular(10),
                        border: Border.all(color: colors.first, width: 1.5)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: CustomText(
                          text: categoryList.name ?? "NA",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

// onUserAdd() async {
//   if (emailController.text.isEmpty ||
//       phoneController.text.isEmpty ||
//       nameController.text.isEmpty ||
//       tvIDController.text.isEmpty ||
//       passwordController.text.isEmpty) {
//     ToastHelper.showToast("All fields are required");
//     return;
//   }
//   var response = await _userBloc.createUser(
//       phoneController.text,
//       passwordController.text,
//       nameController.text,
//       tvIDController.text,
//       emailController.text);
//   if (response && mounted) {
//     Navigator.pop(context);
//   }
// }
//
// onUserUpdate() async {
//   if (emailController.text.isEmpty ||
//       phoneController.text.isEmpty ||
//       nameController.text.isEmpty ||
//       tvIDController.text.isEmpty ||
//       passwordController.text.isEmpty) {
//     ToastHelper.showToast("All fields are required");
//     return;
//   }
//   var response = await _userBloc.updateUser(
//     phoneController.text,
//     passwordController.text,
//     nameController.text,
//     tvIDController.text,
//     emailController.text,
//     docID,
//   );
//   if (response && mounted) {
//     Navigator.pop(context);
//   }
//   print(response);
// }

  _onPickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path ?? "");
      imagePath = file.path;
      setState(() {
        imageUpload = imagePath ?? "";
      });
    } else {
      Fluttertoast.showToast(msg: "Cancelled");
    }
  }
}
