import 'package:flutter/material.dart';
import 'package:sah_food_industries/models/product_model.dart';
import 'package:sah_food_industries/services/firebase_services.dart';
import 'package:sah_food_industries/utils/toast_helper.dart';
import '../models/notes_list_model.dart';
import '../models/product_category_model.dart';
import '../routes/routes.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider() {
    getNotes();
  }

  bool isLoading = false;
  final FirebaseServices _firebaseServices = FirebaseServices();
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<GetNotesModel>? notesList;
  bool productLoading = false;

  Future<void> getNotes() async {
    print("working get notes:");
    notesList = await _firebaseServices.getNotes();
    print("22 check notes: ${notesList?.first.title}");
    notifyListeners();
  }

  Future<void> createNotes({
    required BuildContext context,
    required String title,
    required String description,
  }) async {
    if (title.isEmpty || description.isEmpty) {
      ToastHelper.showToast("All fields are required");
      return;
    }

    isLoading = true;
    notifyListeners();

    try {
      var data = await _firebaseServices.createNotes(
        title,
        description,
      );

      print("Note created: $data");
      ToastHelper.showToast("Note created successfully");
      clearControllers();

      // Navigate to the notes list screen
      getNotes();

      Navigator.pop(context);

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

  void clearControllers() {
    titleController.clear();
    descController.clear();
  }
}
