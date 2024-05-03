import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String text;

  const NoteTile({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        title: Text(text),
      ),
    );
  }
}
