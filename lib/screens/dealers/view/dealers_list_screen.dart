import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/screens/dealers/view/create_dealer_screen.dart';

import '../../../Constants.dart';
import '../../../utils/utils.dart';
import '../../side_menu_screen/side_drawer_screen.dart';
import '../dealer_provider.dart';

class DealerListScreen extends StatefulWidget {
  const DealerListScreen({super.key});

  static ChangeNotifierProvider<DealerProvider> builder(BuildContext context) {
    return ChangeNotifierProvider<DealerProvider>(
        create: (context) => DealerProvider(),
        builder: (context, snapshot) {
          return const DealerListScreen();
        });
  }

  @override
  State<DealerListScreen> createState() => _DealerListScreenState();
}

class _DealerListScreenState extends State<DealerListScreen> {
  late DealerProvider dealerListProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dealerListProvider = Provider.of<DealerProvider>(context, listen: false);

    dealerListProvider.getDealers();
  }

  @override
  Widget build(BuildContext context) {
    dealerListProvider = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Constants.bgBlueColor,
            title: const Text(
              'Dealers',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
        // backgroundColor: Constants.bgBlueColor,
        resizeToAvoidBottomInset: true,
        drawer: DashboardDrawer(height: height, width: width),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateDealerScreen()));
          },
          elevation: 5,
          child: Icon(
            Icons.edit,
            color: Constants.bgBlueColor,
          ),
          backgroundColor: Constants.homeCardColor,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: dealerListProvider.dealerList?.length ?? 0,
                  itemBuilder: (context, index) {
                    print(
                        "80 check dealer list: ${dealerListProvider.dealerList?.length}");
                    final dealerData = dealerListProvider.dealerList?[index];
                    String formatDateTime(DateTime dateTime) {
                      final DateFormat formatter =
                          DateFormat('yyyy-MM-dd, hh:mm a');
                      return formatter.format(dateTime);
                    }

                    print(
                        "89 check dealer list: ${dealerListProvider.dealerList?.first.docId}");

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        dealerData?.createdAt != null
                                            ? formatDateTime(
                                                dealerData?.createdAt! ??
                                                    DateTime.now())
                                            : "No Date",
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Constants.textColor,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print(
                                              "check dealer docId: ${dealerData?.docId}");
                                          Utils.alertDialog(context, () async {
                                            dealerListProvider.deleteDealer(
                                              context: context,
                                              docID: dealerData?.docId ?? '',
                                            );
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete_rounded,
                                          color: Colors.grey,
                                          size: 30,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  dealerData?.name ?? '',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Constants.bgBlueColor,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.storefront_rounded,
                                          size: 20, color: Colors.grey),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        dealerData?.shopName ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Constants.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 1),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.location_on_rounded,
                                          size: 20, color: Colors.grey),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        dealerData?.region ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Constants.textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]));
  }
}
