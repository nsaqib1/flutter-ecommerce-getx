import 'package:flutter/material.dart';

class ColorVariations extends StatefulWidget {
  const ColorVariations({super.key, required this.colors});

  final List<Color> colors;

  @override
  State<ColorVariations> createState() => _ColorVariationsState();
}

class _ColorVariationsState extends State<ColorVariations> {
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Color",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: MediaQuery.sizeOf(context).width - 60,
          height: 30,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: widget.colors[index],
                  radius: 15,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : null,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: widget.colors.length,
          ),
        ),
      ],
    );
  }
}
