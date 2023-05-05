import 'package:ecom/data/model/product_model.dart';
import 'package:ecom/ui/screens/product_details_screen.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductItemPreviewCard extends StatelessWidget {
  const ProductItemPreviewCard({
    super.key, required this.productData,
  });

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductDetailsScreen()));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Image.network(
              productData.image ?? '',
              width: 160,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              productData.title ?? '',
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  letterSpacing: 0.4,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '\$${productData.price}',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.star,
                  color: Colors.amberAccent,
                  size: 14,
                ),
                Text(
                  '${productData.star ?? 0.0 }',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(4)),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
