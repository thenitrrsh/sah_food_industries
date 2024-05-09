import 'dart:ui';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../utils/toast_helper.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // late UserScreenProvider userScreenProvider;
  // final UserBloc _userBloc = UserBloc();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String docID = "";
  String imageUpload = "";
  String? imagePath;
  String? selectedItem;

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
          // leading: GestureDetector(
          //     onTap: () {
          //       UserScreenProvider userScreenProvider =
          //       Provider.of(context, listen: false);
          //
          //       // nameController.clear();
          //       // emailController.clear();
          //       // phoneController.clear();
          //       // passwordController.clear();
          //       // tvIDController.clear();
          //       userScreenProvider.userName = "";
          //       userScreenProvider.email = "";
          //       userScreenProvider.password = "";
          //       userScreenProvider.phoneNumber = "";
          //       userScreenProvider.tvID = "";
          //
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (context) => UserListScreen()));
          //       setState(() {});
          //     },
          //     child: Icon(Icons.arrow_back_ios_new)),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Add Staff',
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
                          hintText: "Enter Name",
                          headingName: "Name",
                          controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Phone Number",
                          hintText: "Enter Phone Number",
                          controller: phoneController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Email",
                          hintText: "Enter Email",
                          controller: emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Password",
                          hintText: "Enter Password",
                          controller: passwordController),
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
                                        height: 100,
                                        width: 100,
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
                        onTap: () {
                          onUserAdd();
                        },
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

  onUserAdd() async {
    if (emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ToastHelper.showToast("All fields are required");
      return;
    }
    var response = await FirebaseServices().createStaff(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        password: emailController.text);
    if (response && mounted) {
      Navigator.pop(context);
    }
  }

// onUserUpdate() async {
//   if (emailController.text.isEmpty ||
//       phoneController.text.isEmpty ||
//       nameController.text.isEmpty ||
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
}
