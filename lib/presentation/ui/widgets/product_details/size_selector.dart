import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/app_colors.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key, required this.sizes, required this.onChange});

  final List<String> sizes;
  final Function(String) onChange;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String _selectedSize;
  @override
  void initState() {
    super.initState();
    _selectedSize = widget.sizes.first;
    widget.onChange(_selectedSize);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Size",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 60,
          height: 35,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  setState(() {
                    _selectedSize = widget.sizes[index];
                    widget.onChange(widget.sizes[index]);
                    setState(() {});
                  });
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedSize == widget.sizes[index] ? AppColors.primaryColor : Colors.grey,
                      width: 1,
                    ),
                    color: _selectedSize == widget.sizes[index] ? AppColors.primaryColor : Colors.transparent,
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        widget.sizes[index],
                        style: TextStyle(
                          color: _selectedSize == widget.sizes[index] ? Colors.white : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: widget.sizes.length,
          ),
        ),
      ],
    );
  }
}
