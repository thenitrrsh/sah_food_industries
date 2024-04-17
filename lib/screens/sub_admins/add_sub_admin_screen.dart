import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';
import 'package:sah_food_industries/models/region_model.dart';
import 'package:sah_food_industries/models/state_model.dart';
import 'package:sah_food_industries/providers/admin_subadmin_provider.dart';
import 'package:sah_food_industries/services/firebase_services.dart';

import '../../ReusableContents/reusable_contents.dart';
import '../../helper.dart';
import '../../utils/toast_helper.dart';

class AddSubAdminScreen extends StatefulWidget {
  const AddSubAdminScreen({super.key});

  @override
  State<AddSubAdminScreen> createState() => _AddSubAdminScreenState();
}

class _AddSubAdminScreenState extends State<AddSubAdminScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  String docID = "";
  AdminSubAdminProvider userProvider = AdminSubAdminProvider();

  FirebaseServices _firebaseService = FirebaseServices();
  StateListModel? stateListModel;
  StateModel? selectedState;

  RegionListModel? regionListModel;
  RegionModel? selectedRegion;


  @override
  void initState() {
    super.initState();
    getStates();
  }

  getStates() async {
    stateListModel = await _firebaseService.getStates();
    if (stateListModel != null) {
      setState(() {});
    }
  }

  getRegion() async {
    regionListModel = await _firebaseService.getRegions(stateId: selectedState?.docId ?? "");
    if (regionListModel != null) {
      setState(() {});
    }
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
            'Add Sub-Admin',
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
                        controller: nameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableTextfield(
                        headingName: "Phone Number",
                        hintText: "Enter Phone Number",
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "States",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width / 1.1,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: const BorderSide(
                                    color: Constants.bgBlueColor, width: 1.5)),
                            child: DropdownButton<StateModel>(
                              isExpanded: true,
                              hint: Text("Select State"),
                              padding:
                                  const EdgeInsets.only(left: 12, right: 10),
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
                                getRegion();
                              },
                              items: stateListModel?.regionList?.isEmpty ?? true ? [] : stateListModel!.regionList!
                                  .map<DropdownMenuItem<StateModel>>(
                                      (StateModel value) {
                                return DropdownMenuItem<StateModel>(
                                  value: value,
                                  child: Text(
                                    value.stateName ?? "",
                                    style: TextStyle(),
                                  ),
                                );
                              }).toList(),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Region",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: width / 1.1,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                                side: const BorderSide(
                                    color: Constants.bgBlueColor, width: 1.5)),
                            child: DropdownButton<RegionModel>(
                              isExpanded: true,
                              hint: Text("Select Region"),

                              padding:
                              const EdgeInsets.only(left: 12, right: 10),
                              value: selectedRegion,
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
                              onChanged: (RegionModel? value) {
                                selectedRegion = value;
                                // print(widget.adminDashboardProvider.selectedYear);
                                setState(() {});
                              },
                              items: regionListModel?.regionList?.isEmpty ?? true ? [] : regionListModel!.regionList!.map<DropdownMenuItem<RegionModel>>(
                                      (RegionModel value) {
                                    return DropdownMenuItem<RegionModel>(
                                      value: value,
                                      child: Text(
                                        value.regionName ?? "",
                                        style: TextStyle(),
                                      ),
                                    );
                                  }).toList(),
                            )),
                      ),
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
                      SizedBox(
                        height: height / 14,
                      ),
                      SaveButton(width: width, onTap: () { onUserAdd(); },),
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

  onUserAdd() async {
    if (emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
    selectedRegion == null || selectedState == null) {
      ToastHelper.showToast("All fields are required");
      return;
    }
    var response = await userProvider.createAdmin(phoneController.text,
        passwordController.text, nameController.text, emailController.text, selectedRegion!.docId!, selectedState!.docId!, selectedRegion!.regionName!, selectedState!.stateName!);
    if (response && mounted) {
      Navigator.pop(context);
    }
  }

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
