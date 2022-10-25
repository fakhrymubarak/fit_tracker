import 'package:flutter/material.dart';

class BottomSheetInsertWeight extends StatelessWidget {
  const BottomSheetInsertWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            )),
      ],
    );
  }
}
