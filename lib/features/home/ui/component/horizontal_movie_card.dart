import 'package:flutter/material.dart';

import '../../../../common/widget/image_widget.dart';
import '../../../../utils/colors.dart';

class HorizontalMovieCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String rating;
  final String year;
  final bool isFav;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;

  const HorizontalMovieCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.year,
    required this.isFav,
    required this.onTap,
    required this.onSaveTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue.withOpacity(0.1),
          // boxShadow: [
          //   const BoxShadow(
          //     color: Colors.black12,
          //     offset: Offset(6, 6),
          //     spreadRadius: 1,
          //     blurRadius: 4,
          //   ),
          //   BoxShadow(
          //     color: Colors.blue.withOpacity(0.1),
          //     offset: const Offset(-6, -6),
          //     spreadRadius: 1,
          //     blurRadius: 4,
          //   ),
          // ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                color: Colors.blue.withOpacity(0.3),
                child: ImageWidget(
                  imageUrl: imageUrl,
                  height: 110,
                  width: MediaQuery.of(context).size.width / 1.8,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: kMain2Color, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        rating,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: kMain2Color,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        year,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // const SizedBox(height: 4),
                  Text(
                    "--------------------------------------------------------------",
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSaveTap,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? kMainColor : Colors.black,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
