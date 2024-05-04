import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../utils/toast_helper.dart';

class AddProductCategory extends StatefulWidget {
  const AddProductCategory({super.key});

  @override
  State<AddProductCategory> createState() => _AddProductCategoryState();
}

class _AddProductCategoryState extends State<AddProductCategory> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController nameController = TextEditingController();

  String docID = "";

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
            'Add Product Category',
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
                          hintText: "Enter Category",
                          headingName: "Category",
                          controller: nameController),
                      SizedBox(
                        height: height / 14,
                      ),
                      SaveButton(
                        width: width,
                        onTap: () {
                          onCategoryAdd();
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

  onCategoryAdd() async {
    if (nameController.text.isEmpty) {
      ToastHelper.showToast("All fields are required");
      return;
    }
    var response = await FirebaseServices()
        .createProductCategory(nameController.text.trim());
    if (response && mounted) {
      Navigator.pop(context);
    }
  }
}
