import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoaderWidget extends StatelessWidget {
  const ShimmerLoaderWidget({
    super.key, required this.sizedBoxHeight,
  });
  final double sizedBoxHeight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizedBoxHeight,
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(0.1),
          highlightColor: AppColors.primaryColor,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
