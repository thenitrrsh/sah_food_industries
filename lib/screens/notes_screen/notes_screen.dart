import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../providers/notes_provider.dart';
import '../../utils/utils.dart';
import '../side_menu_screen/side_drawer_screen.dart';
import 'create_notes_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  static ChangeNotifierProvider<NotesProvider> builder(BuildContext context) {
    return ChangeNotifierProvider<NotesProvider>(
        create: (context) => NotesProvider(),
        builder: (context, snapshot) {
          return const NotesScreen();
        });
  }

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late NotesProvider notesProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesProvider = Provider.of<NotesProvider>(context, listen: false);

    notesProvider.getNotes();
  }

  @override
  Widget build(BuildContext context) {
    notesProvider = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: Constants.bgBlueColor,
            title: const Text(
              'My Notes',
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
                    builder: (context) => const CreateNotesScreen()));
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
                  itemCount: notesProvider.notesList?.length ?? 0,
                  itemBuilder: (context, index) {
                    print(
                        "80 check notes list ${notesProvider.notesList?.length}");
                    final noteData = notesProvider.notesList?[index];
                    String formatDateTime(DateTime dateTime) {
                      final DateFormat formatter =
                          DateFormat('yyyy-MM-dd, hh:mm a');
                      return formatter.format(dateTime);
                    }

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
                                        noteData?.createdAt != null
                                            ? formatDateTime(
                                                noteData?.createdAt! ??
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
                                          Utils.alertDialog(context, () async {
                                            notesProvider.deleteNotes(
                                              context: context,
                                              docID: noteData?.docId ?? '',
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
                                  noteData?.title ?? '',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Constants.bgBlueColor,
                                  ),
                                ),
                                const SizedBox(height: 1),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Text(
                                    noteData?.description ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
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
