import 'package:flutter/material.dart';

class SwipeItem extends StatefulWidget {
  final String title;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onArchive;

  const SwipeItem({
    super.key,
    required this.title,
    required this.onDelete,
    required this.onEdit,
    required this.onArchive,
  });

  @override
  State<SwipeItem> createState() => _SwipeItemState();
}

class _SwipeItemState extends State<SwipeItem> {
  double offset = 0;

  static const double itemHeight = 80;
  static const double actionWidth = 70;
  static const double actionGap = 6;
  static const double rightPadding = 6;
  static const BorderRadius radius = BorderRadius.all(Radius.circular(12));

  final double leftMax = 70;

  double get rightMax => -((actionWidth * 2)  + rightPadding);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          offset += details.delta.dx;
          offset = offset.clamp(rightMax, leftMax);
        });
      },
      onHorizontalDragEnd: (_) {
        setState(() {
          if (offset < -80) {
            offset = rightMax;
          } else if (offset > 35) {
            offset = leftMax;
          } else {
            offset = 0;
          }
        });
      },
      child: Stack(
        children: [
          if (offset > 0) archiveAction(),
          if (offset < 0) editDeleteActions(),
          Transform.translate(offset: Offset(offset, 0), child: contentCard()),
        ],
      ),
    );
  }

  /// LEFT → Archive
  Widget archiveAction() {
    return Positioned.fill(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: radius),
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: widget.onArchive,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.archive, color: Colors.white),
              SizedBox(height: 4),
              Text(
                "Archive",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// RIGHT → Edit + Delete
  Widget editDeleteActions() {
    return Positioned.fill(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: rightPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            actionButton(
              color: Colors.grey,
              icon: Icons.edit,
              label: "Edit",
              radius: const BorderRadius.only(
                // topLeft: Radius.circular(12),
                // bottomLeft: Radius.circular(12),
                // topRight: Radius.circular(12),
                // bottomRight: Radius.circular(12),
              ),
              onTap: widget.onEdit,
            ),
            actionButton(
              color: Colors.red,
              icon: Icons.delete,
              label: "Delete",
              radius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                // topLeft: Radius.circular(12),
                // bottomLeft: Radius.circular(12),
              ),
              onTap: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton({
    required Color color,
    required IconData icon,
    required String label,
    required BorderRadius radius,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: actionWidth,
        height: itemHeight,
        decoration: BoxDecoration(color: color, borderRadius: radius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  /// CARD
  Widget contentCard() {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // no radius
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: itemHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: Text(widget.title, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
