import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/ReusableContents/reusable_contents.dart';
import 'package:sah_food_industries/models/edit_product_model.dart';
import 'package:sah_food_industries/utils/toast_helper.dart';

import '../../Constants.dart';
import '../../providers/product_category_provider.dart';
import '../../routes/routes.dart';
import '../../services/firebase_services.dart';
import '../../utils/utils.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key,
      this.image,
      this.title,
      this.weight,
      this.description,
      this.price,
      this.docId,
      this.quantity,
      this.provider});

  final String? title;
  final String? image;
  final String? weight;
  final String? price;
  final String? description;
  final String? docId;
  final String? quantity;
  final ProductCategoryProvider? provider;

  // static ChangeNotifierProvider<ProductCategoryProvider> builder(
  //     BuildContext context) {
  //   return ChangeNotifierProvider<ProductCategoryProvider>(
  //       create: (context) => ProductCategoryProvider(),
  //       builder: (context, snapshot) {
  //         return const ProductDetailScreen();
  //       });
  // }

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // late ProductCategoryProvider productProvider;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // ProductCategoryProvider productCategoryProvider =
    //     context.watch<ProductCategoryProvider>();
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, Routes.addProduct,
                    arguments: EditProductModel(
                      weight: widget.weight,
                      title: widget.title,
                      price: widget.price,
                      description: widget.description,
                      image: widget.image,
                      docId: widget.docId,
                      isEdit: true,
                      quantity: widget.quantity,
                    ));
              },
              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                foregroundColor: Constants.bgBlueColor, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Constants.bgBlueColor, width: 1),
                  borderRadius:
                      BorderRadius.circular(10), // Makes the button a rectangle
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Utils.alertDialog(context, () async {
                  await FirebaseServices().deleteProduct(widget.docId ?? "");
                  setState(() {
                    widget.provider?.getProductCategory();
                    ToastHelper.showToast("Product Deleted Successfully");
                  });
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Delete",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                foregroundColor: Colors.red, // Text color
                padding: EdgeInsets.symmetric(
                    horizontal: 32, vertical: 16), // Button padding
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Constants.bgBlueColor, width: 1),

                  borderRadius:
                      BorderRadius.circular(10), // Makes the button a rectangle
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomSheet: Container(
      //   height: 50,
      //   // color: Constants.bgBlueColor,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       ElevatedButton(
      //         onPressed: () {
      //           // Your delete logic here
      //         },
      //         child: const Text("Delete"),
      //         style: ElevatedButton.styleFrom(
      //           foregroundColor: Colors.red,
      //           shape: RoundedRectangleBorder(
      //             borderRadius:
      //                 BorderRadius.zero, // Makes the button a rectangle
      //           ), // foreground
      //         ),
      //       ),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Your delete logic here
      //         },
      //         child: const Text("Edit"),
      //         style: ElevatedButton.styleFrom(
      //           foregroundColor: Colors.green, // foreground
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
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
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       ElevatedButton(
            //         onPressed: () {
            //           Utils.alertDialog(context, () async {
            //             await FirebaseServices()
            //                 .deleteProduct(widget.docId ?? "");
            //             setState(() {});
            //             Navigator.pop(context);
            //           });
            //         },
            //         child: const Text(
            //           "Delete",
            //           style:
            //               TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           elevation: 5,
            //           foregroundColor: Colors.red, // Text color
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 32, vertical: 16), // Button padding
            //           shape: RoundedRectangleBorder(
            //             side:
            //                 BorderSide(color: Constants.bgBlueColor, width: 1),
            //
            //             borderRadius: BorderRadius.circular(
            //                 10), // Makes the button a rectangle
            //           ),
            //         ),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           // Your delete logic here
            //         },
            //         child: const Text(
            //           "Edit",
            //           style:
            //               TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            //         ),
            //         style: ElevatedButton.styleFrom(
            //           elevation: 5,
            //           foregroundColor: Constants.bgBlueColor, // Text color
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 32, vertical: 16), // Button padding
            //           shape: RoundedRectangleBorder(
            //             side:
            //                 BorderSide(color: Constants.bgBlueColor, width: 1),
            //             borderRadius: BorderRadius.circular(
            //                 10), // Makes the button a rectangle
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
