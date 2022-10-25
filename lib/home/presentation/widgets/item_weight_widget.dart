import 'package:fit_tracker/core/core.dart';
import 'package:flutter/material.dart';

import '../../data/models/weight.dart';

class ItemWeightWidget extends StatelessWidget {
  final Weight item;

  const ItemWeightWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.inputDate),
                    const SizedBox(width: spacingSmall),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: item.weight.toString(),
                              style: textMediumBlack_12pt),
                          const TextSpan(
                              text: ' kg', style: textRegularBlack_12pt),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: colorSecondary),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: colorRedError),
              )
            ],
          )),
    );
  }
}
