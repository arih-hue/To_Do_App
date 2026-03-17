import 'package:flutter/material.dart';

import 'button.dart';

class dialog extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  dialog({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color(0xFF6A89A7),
        content: Container(
          height: 120,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  controller: controller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Add a new task",
                    hintStyle: TextStyle(color: Color(0xFFC1C1C1FF)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),

                //button save and cancel
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Save button
                      button(text: 'Save', onPressed: onSave),

                      const SizedBox(width: 8,),

                      //Cancel Button
                      button(text: 'Cancel', onPressed: onCancel)
                    ]
                )

              ]
          ),
        )
    );
  }
}
