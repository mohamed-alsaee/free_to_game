import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GameShimmer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.orange,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              height: 200,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Container(height: 12, color: Colors.white),
            const SizedBox(height: 8),
            Container(height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
