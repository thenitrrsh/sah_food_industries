import 'package:flutter/material.dart';
import 'package:sah_food_industries/ReusableContents/reusable_contents.dart';

import '../../Constants.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key,
      this.image,
      this.title,
      this.weight,
      this.description,
      this.price});

  final String? title;
  final String? image;
  final String? weight;
  final String? price;
  final String? description;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Product Detail',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: height / 3,
                width: width / 1.1,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(widget.image ?? "na"),
                // child: Image.asset(
                //   imageList[Random().nextInt(2)],
                // ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                CustomText(
                  text: widget.title,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "- ${widget.weight}",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                CustomText(
                  text: "Price: ",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                CustomText(
                  text: "₹ ${widget.price}",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Constants.bgBlueColor.withOpacity(.7)),
              child: CustomText(
                text: " About the Product ",
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(widget.description ?? ""),
          ],
        ),
      ),
    );
  }
}
