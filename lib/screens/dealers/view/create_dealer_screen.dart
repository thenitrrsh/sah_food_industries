import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/screens/dealers/dealer_provider.dart';

import '../../../ReusableContents/reusable_contents.dart';

class CreateDealerScreen extends StatefulWidget {
  const CreateDealerScreen({super.key});

  @override
  State<CreateDealerScreen> createState() => _CreateDealerScreenState();
}

class _CreateDealerScreenState extends State<CreateDealerScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late DealerProvider dealerProvider;
  // final UserBloc _userBloc = UserBloc();

  String docID = "";

  @override
  Widget build(BuildContext context) {
    dealerProvider = Provider.of(context);
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
            'Add Dealer',
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
                          hintText: "Enter Name",
                          headingName: "Dealer Name",
                          controller: dealerProvider.nameController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          hintText: "Enter phone number",
                          headingName: "Phone Number",
                          controller: dealerProvider.phoneController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          hintText: "Enter shop name",
                          headingName: "Shop Name",
                          controller: dealerProvider.shopNameController),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                          hintText: "Enter region",
                          headingName: "Region",
                          controller: dealerProvider.regionController),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          // Padding(
                          //   padding: EdgeInsets.only(left: 15),
                          //   child: Text(
                          //     "Description",
                          //     style: TextStyle(
                          //         fontSize: 16, fontWeight: FontWeight.w500),
                          //   ),
                          // ),
                          // Card(
                          //   color: Colors.white,
                          //   shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(22),
                          //       side: BorderSide(
                          //           color: Constants.bgBlueColor, width: 1.5)),
                          //   child: Container(
                          //     height: height / 3,
                          //     child: TextField(
                          //       maxLines: 50,
                          //       controller: dealerProvider.descController,
                          //       decoration: const InputDecoration(
                          //         hintText: "Enter Description",
                          //         hintStyle: TextStyle(fontSize: 14),
                          //         contentPadding: EdgeInsets.all(12),
                          //         border: InputBorder.none,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: height / 14,
                      ),
                      dealerProvider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SaveButton(
                              width: width,
                              onTap: () {
                                dealerProvider.createDealer(
                                  context: context,
                                  name: dealerProvider.nameController.text,
                                  phone: int.parse(
                                      dealerProvider.phoneController.text),
                                  region: dealerProvider.regionController.text,
                                  shopName:
                                      dealerProvider.shopNameController.text,
                                );
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
}
