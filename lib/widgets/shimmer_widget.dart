import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatefulWidget {
  const new({super.key, required this.linesHeights});

  final List<double> linesHeights;

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(color: Colors.orange),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.orange,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            for (var l in widget.linesHeights)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: l,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                ),
              ),
            // const SizedBox(height: 16),
            // Container(height: 12, color: Colors.white),
            // const SizedBox(height: 8),
            // Container(height: 12, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
