import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/inc_dec_form_field.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 5,
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Image.asset(
            'assets/images/product.png',
            height: 70,
            width: 90,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.4,
                            ),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Color: Block',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                'Size : Xl',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$100',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(
                        width: 95,
                        height: 30,
                        child: IncDecFormField(),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}