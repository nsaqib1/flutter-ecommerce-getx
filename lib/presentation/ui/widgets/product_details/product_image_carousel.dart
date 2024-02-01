import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    super.key,
    this.height,
    required this.images,
  });

  final double? height;
  final List<String> images;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: widget.height ?? 220,
            onPageChanged: (index, reason) {
              _currentIndex.value = index;
            },
            viewportFraction: 1,
          ),
          items: widget.images.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    image: DecorationImage(image: Image.network(i).image),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 6,
        ),
        Positioned(
          bottom: 15,
          child: ValueListenableBuilder(
            valueListenable: _currentIndex,
            builder: (context, index, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    Container(
                      height: 13,
                      width: 13,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: i == index ? AppColors.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
