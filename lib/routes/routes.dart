import 'package:flutter/cupertino.dart';
import 'package:sah_food_industries/screens/catalogue_screen/catalogue_screen.dart';
import 'package:sah_food_industries/screens/dashboard/home_screen.dart';
import 'package:sah_food_industries/screens/productCategories/product_category_list_screen.dart';

import '../screens/login_register_screen.dart/login_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/staffs/add_staff_screen.dart';
import '../screens/staffs/staff_list_screen.dart';

class Routes{

  static const String home = '/home';
  static const String splashScreen = '/';
  static const String login = '/login';
  static const String staffList = '/staffList';
  static const String addStaff = '/addStaff';
  static const String editStaff = '/editStaff';
  static const String addAdmin = '/addAdmin';
  static const String editAdmin = '/editAdmin';
  static const String adminList = '/adminList';
  static const String addSubAdmin = '/addSubAdmin';
  static const String editSubAdmin = '/editSubAdmin';
  static const String subAdminList = '/subAdminList';
  static const String addRegion = '/addRegion';
  static const String editRegion = '/editRegion';
  static const String regionList = '/regionList';
  static const String addState = '/addState';
  static const String editState = '/editState';
  static const String stateList = '/stateList';
  static const String addCity = '/addCity';
  static const String editCity = '/editCity';
  static const String cityList = '/cityList';
  static const String addCategory = '/addCategory';
  static const String editCategory = '/editCategory';
  static const String categoryList = '/categoryList';
  static const String addProduct = '/addProduct';
  static const String editProduct = '/editProduct';
  static const String productList = '/productList';
  static const String addOrder = '/addOrder';
  static const String editOrder = '/editOrder';
  static const String orderList = '/orderList';
  static const String addCustomer = '/addCustomer';
  static const String editCustomer = '/editCustomer';
  static const String customerList = '/customerList';
  static const String productCategoryListScreen = '/productListCategoryScreen';
  static const String catalogScreen = '/catalogue_screen';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{

    splashScreen: (context) =>const SplashScreen(),
    login: (context) =>const LoginScreen(),
    staffList: StaffListScreen.builder,
    addStaff: (context) => const AddStaffScreen(),
    home: (context) => const HomeScreen(),
    productCategoryListScreen:  CategoryListScreen.builder,
    catalogScreen: CatalogueScreen.builder


  };
}


