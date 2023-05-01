import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.HeaderName,
    required this.onTapSeeAll,
  });

  final String HeaderName;
  final VoidCallback onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          HeaderName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.06,
          ),
        ),
        TextButton(
            onPressed: onTapSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                color: AppColors.primaryColor,
              ),
            )),
      ],
    );
  }
}
