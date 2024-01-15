import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_getx/presentation/ui/utility/app_colors.dart';

class SizeVariations extends StatefulWidget {
  const SizeVariations({super.key, required this.sizes});

  final List<String> sizes;

  @override
  State<SizeVariations> createState() => _SizeVariationsState();
}

class _SizeVariationsState extends State<SizeVariations> {
  int _selectedSize = 0;
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
                    _selectedSize = index;
                  });
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _selectedSize == index ? AppColors.primaryColor : Colors.grey,
                      width: 1,
                    ),
                    color: _selectedSize == index ? AppColors.primaryColor : Colors.transparent,
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        widget.sizes[index],
                        style: TextStyle(
                          color: _selectedSize == index ? Colors.white : Colors.grey,
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
