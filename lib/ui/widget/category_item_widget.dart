import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key, required this.categoryItemName, required this.icon, required this.onTap,
  });

  final String categoryItemName;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(
                icon, size: 32,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              categoryItemName,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}