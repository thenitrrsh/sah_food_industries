import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';

import '../../ReusableContents/reusable_contents.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // late UserScreenProvider userScreenProvider;
  // final UserBloc _userBloc = UserBloc();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tvIDController = TextEditingController();
  String docID = "";

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
            'Create Note',
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
                          hintText: "Enter text",
                          headingName: "Heading",
                          controller: nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          headingName: "Date",
                          hintText: "Choose Date",
                          controller: emailController),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
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
                              height: height / 3,
                              child: TextField(
                                controller: phoneController,
                                decoration: const InputDecoration(
                                  hintText: "Enter description",
                                  contentPadding: EdgeInsets.all(12),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 14,
                      ),
                      Center(
                        child: GestureDetector(
                          // onTap: () {
                          //   UserScreenProvider userScreenProvider =
                          //   Provider.of(context, listen: false);
                          //
                          //   userScreenProvider.isUpdateUser == true
                          //       ? onUserUpdate()
                          //       : onUserAdd();
                          //   userScreenProvider.isUpdateUser = false;
                          //   userScreenProvider.docID = "";
                          //   print("311 tvIDController: ${tvIDController.text}");
                          // },
                          child: Container(
                              height: 35,
                              width: width / 5,
                              decoration: BoxDecoration(
                                  color: Constants.bgBlueColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15)),
                              child: const Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ),
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
}
