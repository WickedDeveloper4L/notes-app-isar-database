import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEdit;
  final void Function()? onDelete;

  const NoteSettings({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //edit
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onEdit!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
                child: Text(
              "Edit",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),
          ),
        ),

        //delete

        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDelete!();
          },
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
                child: Text(
              "Delete",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary),
            )),
          ),
        )
      ],
    );
  }
}
