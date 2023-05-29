import 'dart:developer';

import 'package:ecom/data/model/product_details_model.dart';
import 'package:ecom/ui/getx/cart_controller.dart';
import 'package:ecom/ui/getx/product_details_controller.dart';
import 'package:ecom/ui/getx/user_controller.dart';
import 'package:ecom/ui/screens/reviews_screen.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/app_elevated_button.dart';
import 'package:ecom/ui/widget/inc_dec_form_field.dart';
import 'package:ecom/ui/widget/products_details/product_image_slider.dart';
import 'package:ecom/ui/widget/snackbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());
  final UserController _userController = Get.put(UserController());
  final CartController cartController = Get.put(CartController());
  Color? selectedColor;
  String? selectedSize;
  double totalAmount = 0.0;
  var selectedColorIndex = 0;
  var selectedSizeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productDetailsController.getProductDetails(widget.productId);
    });
  }

  Future<void> addToCart(CartController cartController) async {
    final bool authState = _userController.checkAuthState();
    log(selectedColor.toString());
    if (authState && selectedSize != null && selectedColor != null) {
      final result = await cartController.addToCart(widget.productId,
          selectedSize ?? '', selectedColor?.value.toString() ?? '');
      if (result) {
        if (mounted) {
          showSnackbar(context, 'added to cart');
        }
      } else {
        if (mounted) {
          showSnackbar(context, 'Add to card failed! try again', true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Product Details',
          style: TextStyle(color: Colors.black54),
        ),
        leading: const BackButton(
          color: Colors.black54,
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
        if (productDetailsController.getProductDetailsInProgress ||
            productDetailsController.productDetailsModel.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final ProductDetailsData productDetailsData =
              productDetailsController.productDetailsModel.data!.first;
          final List<Color> availabeColors =
              getColorsFromString(productDetailsData.color ?? '');
          final List<String> availabeSize =
              getSizedFormString(productDetailsData.size ?? '');
          if (totalAmount == 0) {
            totalAmount =
                double.tryParse(productDetailsData.product?.price ?? '0.0') ??
                    0.0;
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductImageSlider(
                        sliders: [
                          productDetailsData.img1 ?? '',
                          productDetailsData.img2 ?? '',
                          productDetailsData.img3 ?? '',
                          productDetailsData.img4 ?? '',
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      productDetailsData.product?.title ?? '',
                                      maxLines: 3,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 90,
                                    child: IncDecFormField(
                                      onChange: (newValue) {
                                        totalAmount = (double.tryParse(
                                                    productDetailsData
                                                            .product?.price ??
                                                        '0.0') ??
                                                0) *
                                            newValue;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Text((productDetailsData.product?.star ?? 0.0)
                                      .toStringAsFixed(1)),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ReviewsScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Color',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    height: 50,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: availabeColors.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 1) {
                                          selectedColor = availabeColors[index];
                                        }
                                        return GestureDetector(
                                          onTap: () {
                                            selectedColorIndex = index;
                                            selectedColor =
                                                availabeColors[index];
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                                backgroundColor:
                                                    availabeColors[index],
                                                radius: 15,
                                                child: selectedColorIndex ==
                                                        index
                                                    ? const Icon(Icons.check)
                                                    : null),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Size',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                width: 300,
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: availabeSize.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () {
                                        selectedSizeIndex = index;
                                        selectedSize = availabeSize[index];
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: selectedSizeIndex == index
                                                ? AppColors.primaryColor
                                                : null,
                                            border: Border.all(
                                              color: selectedSizeIndex == index
                                                  ? AppColors.primaryColor
                                                  : Colors.black54,
                                              width: 2,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            availabeSize[index],
                                            style: TextStyle(
                                              color: selectedSizeIndex == index
                                                  ? Colors.white
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              const Text(
                                'Description',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                productDetailsData.des ?? '',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    letterSpacing: 0.4),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                          '\$$totalAmount',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 120,
                      child:
                          GetBuilder<CartController>(builder: (cartController) {
                        if (cartController.addToCartInProgress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return AppElevatedButton(
                          text: 'Add to Cart',
                          onTap: () async {
                            await addToCart(cartController);
                          },
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }),
    );
  }

  List<Color> getColorsFromString(String colors) {
    List<Color> hexaColors = [];
    final List<String> allColors = colors.split(',');
    for (var element in allColors) {
      hexaColors.add(HexColor(element));
    }
    return hexaColors;
  }

  List<String> getSizedFormString(String sizes) {
    return sizes.split(',');
  }
}
