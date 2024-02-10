import 'package:flutter/material.dart';

import '../utility/app_colors.dart';

class ItemCounter extends StatefulWidget {
  const ItemCounter({
    super.key,
    required this.onChange,
    required this.value,
  });

  final Function(int value) onChange;
  final int value;

  @override
  State<ItemCounter> createState() => _ItemCounterState();
}

class _ItemCounterState extends State<ItemCounter> {
  late final ValueNotifier<int> _count = ValueNotifier(widget.value);

  void _increment() {
    if (_count.value < 20) {
      _count.value++;
      widget.onChange(_count.value);
    }
  }

  void _decrement() {
    if (_count.value > 1) {
      _count.value--;
      widget.onChange(_count.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: _decrement,
          child: Card(
            color: AppColors.primaryColor.withOpacity(0.5),
            elevation: 0,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.remove,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ValueListenableBuilder(
            valueListenable: _count,
            builder: (context, value, widget) => Text(
              "$value",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        InkWell(
          onTap: _increment,
          child: const Card(
            color: AppColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.add,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
