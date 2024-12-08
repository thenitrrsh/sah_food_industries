import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sah_food_industries/providers/admin_subadmin_provider.dart';
import 'package:sah_food_industries/providers/notes_provider.dart';
import 'package:sah_food_industries/providers/product_category_provider.dart';
import 'package:sah_food_industries/providers/staffProvider.dart';
import 'package:sah_food_industries/routes/routes.dart';
import 'package:sah_food_industries/screens/dealers/dealer_provider.dart';
import 'package:sah_food_industries/screens/productCategories/provider/add_product_screen_provider.dart';
import 'app/shared_preferences_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferencesHelper.initSharedPrefs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminSubAdminProvider>(
            create: (context) => AdminSubAdminProvider()),
        ChangeNotifierProvider<AddProductProvider>(
            create: (context) => AddProductProvider()),
        ChangeNotifierProvider<ProductCategoryProvider>(
            create: (context) => ProductCategoryProvider()),
        ChangeNotifierProvider<NotesProvider>(
            create: (context) => NotesProvider()),
        ChangeNotifierProvider<DealerProvider>(
            create: (context) => DealerProvider()),
        ChangeNotifierProvider<StaffProvider>(
            create: (context) => StaffProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: Routes.routes,
        initialRoute: Routes.splashScreen,
        // home: const SplashScreen(),
      ),
    );
  }
}
