import 'package:ecom/data/model/product_details_model.dart';
import 'package:ecom/ui/getx/auth_controller.dart';
import 'package:ecom/ui/getx/product_details_controller.dart';
import 'package:ecom/ui/getx/user_controller.dart';
import 'package:ecom/ui/screens/reviews_screen.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/app_elevated_button.dart';
import 'package:ecom/ui/widget/inc_dec_form_field.dart';
import 'package:ecom/ui/widget/products_details/product_image_slider.dart';
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
  Color? selectedColor;
  String? selectedSize;
  double totalAmount = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      productDetailsController.getProductDetails(widget.productId);
    });
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
        if (productDetailsController.getProductDetailsInProgress) {
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
                                  for (int i = 0;
                                      i < availabeColors.length;
                                      i++)
                                    GestureDetector(
                                      onTap: () {
                                        selectedColor = availabeColors[i];
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: availabeColors[i],
                                          radius: 15,
                                          child:
                                              selectedColor == availabeColors[i]
                                                  ? const Icon(Icons.check)
                                                  : null,
                                        ),
                                      ),
                                    )
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
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (int i = 0;
                                        i < availabeSize.length;
                                        i++)
                                      GestureDetector(
                                        onTap: () {
                                          selectedSize = availabeSize[i];
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: selectedSize ==
                                                      availabeSize[i]
                                                  ? AppColors.primaryColor
                                                  : null,
                                              border: Border.all(
                                                color: selectedSize ==
                                                        availabeSize[i]
                                                    ? AppColors.primaryColor
                                                    : Colors.black54,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Text(
                                              availabeSize[i],
                                              style: TextStyle(
                                                color: selectedSize ==
                                                        availabeSize[i]
                                                    ? Colors.white
                                                    : Colors.black87,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
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
                      child: AppElevatedButton(
                        text: 'Add to Cart',
                        onTap: () {
                          final bool _authState =
                              _userController.checkAuthState();
                          if (_authState) {}
                        },
                      ),
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
