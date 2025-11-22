import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 Banner Shimmer
          ShimmerBox(width: width, height: 200, radius: 16),

          const SizedBox(height: 20),

          // 🔥 Horizontal Slider Shimmer
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, __) =>
                  ShimmerBox(width: 120, height: 180, radius: 12),
            ),
          ),

          const SizedBox(height: 20),

          // 🔥 Title Shimmer
          ShimmerBox(width: 150, height: 20, radius: 6),

          const SizedBox(height: 16),

          // 🔥 Grid View Shimmer (3 per row)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (_, __) =>
                ShimmerBox(width: width / 3, height: 200, radius: 12),
          ),
        ],
      ),
    );
  }
}
