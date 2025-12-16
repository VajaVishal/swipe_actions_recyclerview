# SwipeActionsRecyclerView

A lightweight Flutter library to add swipe actions (Edit / Delete / Archive) to list items without using any third‑party packages.
This package is designed to be clean, flexible, and library‑friendly — no forced UI, no forced radius, full control to the user.

---
## ✨ Features
- Swipe left & right actions
- Edit / Delete / Archive callbacks
- No third‑party dependency
- No forced border radius or UI
- Fully customizable item UI
- Works with ListView / Lazy loading
- Production‑ready & lightweight
---
## ✨ Preview
![screen-20251216-1546252](https://github.com/user-attachments/assets/1aad4245-8cab-439a-82bd-e9cead6993c0)

---
## 📦 Installation
Add dependency in your pubspec.yaml:
```
dependencies:
  swipe_actions:
    path: ../swipe_actions  # For local development
```
from git:
```
dependencies:
  swipe_actions:
    git:
      url: https://github.com/yourusername/swipe_actions.git  # Your github path
```
Then run:
```
flutter pub get
```
---
## 🎨 UI Customization
This package does not force UI styles.
You control:
- Item height
- Child widget
- Colors
- Border radius
- Theme
---
## 📁 Folder Structure
```
swipe_actions/
│
├── lib/
│   |
│   └── swipe_item.dart
│
├── example/
│   └── main.dart
│
├── test/
│   └── swipe_actions_test.dart
│
├── README.md
├── pubspec.yaml

```
--- 
## 🚀 Basic Usage
  ```
import 'package:swipe_actions/swipe_actions.dart';
SwipeItem(
  title: 'Item 1',
  onEdit: () {
    print('Edit item');
},
  onDelete: () {
    print('Delete item');
},
  onArchive: () {
    print('Archive item');
  },
);
```
---
## 📱Example
```
class SwipeListScreen extends StatefulWidget {
  const SwipeListScreen({super.key});

  @override
  State<SwipeListScreen> createState() => _SwipeListScreenState();
}

class _SwipeListScreenState extends State<SwipeListScreen> {
  final List<String> items = List.generate(10, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Swipe Actions Demo')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return SwipeItem(
            key: ValueKey(item),
            title: item,
            onEdit: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Edit $item')));
            },
            onDelete: () {
              setState(() => items.remove(item));
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Delete $item')));
            },
            onArchive: () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Archive $item')));
            },
          );
        },
      ),
    );
  }
}
```
---
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.
