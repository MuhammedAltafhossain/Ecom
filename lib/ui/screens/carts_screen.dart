import 'package:ecom/ui/getx/bottom_navigation_controller.dart';
import 'package:ecom/ui/getx/cart_controller.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/app_elevated_button.dart';
import 'package:ecom/ui/widget/carts/cart_product_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({Key? key}) : super(key: key);

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  BottomNavigationController controller = Get.put(BottomNavigationController());
  CartController cartController = Get.put(CartController());

  double totalPrice = 0.0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cartController.getCartList();
      if((cartController.cartListModel.data?.length ?? 0) > 0){
        totalPrice = 0.0;
        for (var element in cartController.cartListModel.data!) {
          totalPrice += double.tryParse(element.product?.price ?? '0') ?? 0;
        }}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            controller.changeIndex(0);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: GetBuilder<CartController>(builder: (controller) {
        if (cartController.addToCartInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: controller.cartListModel.data?.length ?? 0,

                  itemBuilder: (context, index) {
                    return CartProductItem(
                      cartData: controller.cartListModel.data![index],
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.20),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text(
                        '\$$totalPrice',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: 100,
                      child: AppElevatedButton(text: 'Checkout', onTap: () {}))
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
