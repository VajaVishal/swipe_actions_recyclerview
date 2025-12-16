import 'package:flutter/material.dart';
import 'package:swipe_actions_recyclerview/src/swipe_items.dart';

class SwipeActionScreen extends StatefulWidget {
  const SwipeActionScreen({super.key});

  @override
  State<SwipeActionScreen> createState() => _SwipeActionScreenState();
}

class _SwipeActionScreenState extends State<SwipeActionScreen> {
  List<String> items = List.generate(10, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Swipe Actions")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return SwipeItem(
            title: items[index],
            onDelete: () {
              setState(() => items.removeAt(index));
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Delete ${items[index]}')));
            },
            onEdit: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Edit ${items[index]}")));
            },
            onArchive: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Archive ${items[index]}')),
              );
            },
          );
        },
      ),
    );
  }
}
