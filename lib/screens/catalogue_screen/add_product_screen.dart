import 'dart:ui';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sah_food_industries/Constants.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../providers/admin_subadmin_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController mrpController = TextEditingController();

  String imageUpload = "";
  String? imagePath;

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
  Widget build(BuildContext context) {
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
            height: 60,
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
                          hintText: "Enter Region",
                          controller: titleController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Price",
                          hintText: "Enter Region",
                          controller: mrpController),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
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
                            side: const BorderSide(
                                color: Constants.bgBlueColor, width: 1.5)),
                        child: Container(
                          height: height / 5,
                          child: TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              hintText: "Enter description",
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
                            side: const BorderSide(
                                color: Constants.bgBlueColor, width: 1.5)),
                        child: Container(
                            height: height / 6,
                            width: width / 1,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Upload Picture",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.black45,
                                      child: GestureDetector(
                                        onTap: () {
                                          _onPickFile();
                                        },
                                        child: Icon(
                                          Icons.upload,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
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
