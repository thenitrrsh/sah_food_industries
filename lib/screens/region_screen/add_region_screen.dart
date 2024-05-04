import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/models/state_model.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../providers/admin_subadmin_provider.dart';
import '../../utils/toast_helper.dart';

class CreateRegionScreen extends StatefulWidget {
  const CreateRegionScreen({super.key});

  @override
  State<CreateRegionScreen> createState() => _CreateRegionScreenState();
}

class _CreateRegionScreenState extends State<CreateRegionScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // List<String> indianStates = [
  //   'Andhra Pradesh',
  //   'Arunachal Pradesh',
  //   'Assam',
  //   'Bihar',
  //   'Chhattisgarh',
  //   'Goa',
  //   'Gujarat',
  //   'Haryana',
  //   'Himachal Pradesh',
  //   'Jharkhand',
  //   'Karnataka',
  //   'Kerala',
  //   'Madhya Pradesh',
  //   'Maharashtra',
  //   'Manipur',
  //   'Meghalaya',
  //   'Mizoram',
  //   'Nagaland',
  //   'Odisha',
  //   'Punjab',
  //   'Rajasthan',
  //   'Sikkim',
  //   'Tamil Nadu',
  //   'Telangana',
  //   'Tripura',
  //   'Uttar Pradesh',
  //   'Uttarakhand',
  //   'West Bengal'
  // ];

  TextEditingController regionController = TextEditingController();
  TextEditingController statesController = TextEditingController();

  String docID = "";
  AdminSubAdminProvider userProvider = AdminSubAdminProvider();
  StateModel? selectedState;
  StateListModel? stateListModel;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    stateListModel = await FirebaseServices().getStates();

    setState(() {});
  }

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
            'Create Region',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: stateListModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    // height: height / 1,
                    width: width / 1,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55),
                            topRight: Radius.circular(55)),
                        color: Colors.white),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 22, left: 22),
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
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "State",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              width: width / 1.1,
                              child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      side: BorderSide(
                                          color: Constants.bgBlueColor,
                                          width: 1.5)),
                                  child: DropdownButton<StateModel>(
                                    hint: const Text(
                                      "Select State",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    isExpanded: true,
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 10),
                                    value: selectedState,
                                    iconDisabledColor: Colors.transparent,
                                    underline: Container(
                                      // width: width / 1.1,
                                      color: Colors.transparent,
                                    ),
                                    // icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    onChanged: (StateModel? value) {
                                      selectedState = value;
                                      // print(widget.adminDashboardProvider.selectedYear);
                                      setState(() {});
                                    },
                                    items: stateListModel
                                                ?.regionList?.isEmpty ??
                                            true
                                        ? []
                                        : stateListModel!.regionList!
                                            .map<DropdownMenuItem<StateModel>>(
                                                (StateModel value) {
                                            return DropdownMenuItem<StateModel>(
                                              value: value,
                                              child:
                                                  Text(value.stateName ?? ""),
                                            );
                                          }).toList(),
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ReusableTextfield(
                                headingName: "Region",
                                hintText: "Enter Region",
                                controller: regionController),
                            SizedBox(
                              height: height / 14,
                            ),
                            SaveButton(
                              width: width,
                              onTap: () async {
                                if (regionController.text.isEmpty) {
                                  ToastHelper.showToast("Region is required");
                                  return;
                                }
                                if (selectedState == null) {
                                  ToastHelper.showToast("State is required");
                                  return;
                                }
                                String? data = await FirebaseServices()
                                    .createRegion(
                                        regionController.text,
                                        selectedState?.docId ?? "",
                                        selectedState?.stateName ?? "");
                                if (data == null) {
                                  ToastHelper.showToast(
                                      "Region created successfully");
                                  Navigator.pop(context);
                                } else {
                                  ToastHelper.showToast(data);
                                }
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
