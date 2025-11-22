import 'package:flutter/material.dart';

class DetailsInfoCard extends StatelessWidget {
  final String title;
  final String? value;

  const DetailsInfoCard({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(value!, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
