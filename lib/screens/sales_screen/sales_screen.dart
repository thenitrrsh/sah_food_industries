import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../side_menu_screen/side_drawer_screen.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.bgBlueColor,
      resizeToAvoidBottomInset: true,
      drawer: DashboardDrawer(height: height, width: width),
      appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Constants.bgBlueColor,
          title: const Text(
            'Sales',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
      body: Container(
        height: height / 1,
        color: Colors.white,
      ),
    );
  }
}
