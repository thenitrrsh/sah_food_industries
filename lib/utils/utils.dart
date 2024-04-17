import 'package:flutter/material.dart';

class Utils{

  static alertDialog(BuildContext context, Function onTap){
    ValueNotifier<bool> isLoading = ValueNotifier(false);
    showDialog(
        context:
        context,
        builder:
            (context) =>
            ValueListenableBuilder<bool>(
              valueListenable: isLoading,
              builder: (context, snapshot, _) {
                return AlertDialog(
                  title:
                  const Text("Are you sure want to delete?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () async  {
                          isLoading.value = true;
                          await onTap();
                          isLoading.value = false;
                          Navigator.pop(context, true);
                        },
                        child: snapshot ? Center(
                          child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                        ): Text("Yes")),
                  ],
                );
              }
            ));
  }
}