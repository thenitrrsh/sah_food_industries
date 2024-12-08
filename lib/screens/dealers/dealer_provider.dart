import 'package:flutter/material.dart';
import 'package:sah_food_industries/services/firebase_services.dart';
import '../../app/shared_preferences_helper.dart';
import '../../utils/toast_helper.dart';
import 'get_dealer_list_model.dart';

class DealerProvider extends ChangeNotifier {
  DealerProvider() {
    getDealers();
  }

  bool isLoading = false;
  final FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController searchController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  bool productLoading = false;

  List<GetDealerListModel>? dealerList;

  Future<void> getDealers() async {
    dealerList = await _firebaseServices.getDealersList();
    print(
        "22 check dealer: ${dealerList?.map((dealer) => dealer.region).toList()}");
    notifyListeners();
  }

  Future<void> createDealer({
    required BuildContext context,
    required String name,
    required int phone,
    required String region,
    required String shopName,
  }) async {
    if (name.isEmpty ||
        region.isEmpty ||
        phone.toString().isEmpty ||
        shopName.isEmpty) {
      ToastHelper.showToast("All fields are required");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      var data = await _firebaseServices.createDealer(
        name: nameController.text,
        phone: int.parse(phoneController.text),
        region: regionController.text,
        shopName: shopNameController.text,
        createdBy: SharedPreferencesHelper.getUserData()!.docId ?? '',
        docId: SharedPreferencesHelper.getUserData()!.docId ?? "",
      );

      print("dealer created: $data");
      ToastHelper.showToast("Dealer created successfully");
      clearControllers();

      // Navigate to the notes list screen
      getDealers();

      Navigator.pop(context);
      notifyListeners();

      // Navigator.of(context).pushNamed(Routes.notesListScreen);
    } catch (e) {
      print("Error creating note: $e");
      ToastHelper.showToast("Failed to create note. Please try again.");
    } finally {
      // Ensure isLoading is updated in both success and failure scenarios
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteDealer({
    required BuildContext context,
    required String docID,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      print("87 check delaer doc: $docID");

      print("78 check delaer delete: ${dealerList?.length}");
      var data = await _firebaseServices.deleteDealer(docID);
      print("dealer deleted: $data");
      ToastHelper.showToast("Dealer deleted successfully");
      print("91 check delaer delete: ${dealerList?.length}");
      getDealers();
      notifyListeners();
    } catch (e) {
      print("Error deleting dealer: $e");
      ToastHelper.showToast("Failed to delete dealer. Please try again.");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearControllers() {
    nameController.clear();
    phoneController.clear();
    regionController.clear();
  }
}
