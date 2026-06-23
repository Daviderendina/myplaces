import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../circular_icon_button.dart';

class AppImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool showBackButton;

  //TODO troppi valori fixed

  const AppImageCarousel({
    super.key,
    required this.images,
    required this.height,
    this.showBackButton = true,
  });

  @override
  State<AppImageCarousel> createState() => _AppImageCarouselState();
}

class _AppImageCarouselState extends State<AppImageCarousel> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.image_not_supported, color: Colors.white30),
      );
    }

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: CarouselSlider(
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              autoPlay: false,
              pageSnapping: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
            items: widget.images.map((imageUrl) {
              return Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(color: Colors.grey.shade900);
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade900,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.white30,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        if (widget.images.length > 1)
          Positioned(
            bottom: 12.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.images.asMap().entries.map((entry) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                      _currentImageIndex == entry.key ? 0.9 : 0.4,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        if (widget.showBackButton)
          Positioned(
            left: 8,
            top: 8,
            child: CircularIconButton(
              icon: Icons.arrow_back_outlined,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
      ],
    );
  }
}
