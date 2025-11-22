import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/assets.dart';

class DashTvTitle extends StatelessWidget {
  const DashTvTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: Image.asset(
            ImageAssets.kAppLogo,
            height: 25,
            width: 25,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 10),
        Shimmer.fromColors(
          baseColor: Colors.blueAccent,
          highlightColor: Colors.white,
          period: const Duration(seconds: 2),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Dash",
                  style: GoogleFonts.mogra(
                    textStyle: const TextStyle(
                      color: Colors.blueAccent,
                      letterSpacing: 2.5,
                      wordSpacing: 2,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextSpan(
                  text: "Tv",
                  style: GoogleFonts.mogra(
                    textStyle: TextStyle(
                      color: Colors.black, // <-- secondary color
                      letterSpacing: 2.5,
                      wordSpacing: 2,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
