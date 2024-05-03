import 'package:flutter/material.dart';
import 'package:sah_food_industries/Constants.dart';

class ReusableDashboardSmallText extends StatelessWidget {
  const ReusableDashboardSmallText(
      {super.key, required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w500),
    );
  }
}

class ReusableTextfield extends StatelessWidget {
  ReusableTextfield({
    super.key,
    required this.controller,
    required this.headingName,
    required this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String headingName;
  final String hintText;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            headingName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
              side:  BorderSide(color: Constants.bgBlueColor, width: 1.5)),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.all(12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key,
      required this.height,
      required this.width,
      required this.searchController,
      required this.onChanged,
      required this.hintText,
      this.inputColor});

  final double height;
  final double width;
  final TextEditingController searchController;
  final void Function(String)? onChanged;
  final String hintText;

  final Color? inputColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 17,
      width: width / 1.1,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadiusDirectional.circular(
            15,
          ),
          border: Border.all(color: Constants.bgBlueColor)),
      child: Row(
        children: [
          Container(
            height: height / 16,
            width: width / 1.35,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15))),
            child: TextField(
              style: TextStyle(color: inputColor),
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
                hintText: hintText,
                hintStyle:  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    color: Constants.bgBlueColor),
              ),
            ),
          ),
          Container(
            height: height / 16,
            width: width / 6.19,
            decoration: BoxDecoration(
                color: Constants.bgBlueColor,
                border:
                    Border.all(color: Colors.white.withOpacity(1), width: 3),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
            child: GestureDetector(
              // onTap: () {
              //   searchController.text.isEmpty
              //       ? Flu.showToast("Type here")
              //       : "";
              // },
              child: Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReusableSaveButton extends StatelessWidget {
  const ReusableSaveButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: width / 3.5,
        decoration: BoxDecoration(
            color: Constants.bgBlueColor,
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: const Center(
          child: Text(
            "Save",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ));
  }
}

class SaveButton extends StatelessWidget {
  SaveButton({super.key, required this.width, required this.onTap});

  final double width;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
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
            height: 50,
            width: width / 2,
            decoration: BoxDecoration(
                color: Constants.bgBlueColor,
                borderRadius: BorderRadiusDirectional.circular(15)),
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
    );
  }
}
