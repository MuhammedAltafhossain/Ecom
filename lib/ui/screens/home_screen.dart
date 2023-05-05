import 'package:ecom/ui/getx/bottom_navigation_controller.dart';
import 'package:ecom/ui/getx/category_controller.dart';
import 'package:ecom/ui/getx/home_controller.dart';
import 'package:ecom/ui/getx/product_controller.dart';
import 'package:ecom/ui/screens/category_screen.dart';
import 'package:ecom/ui/screens/product_list_screen.dart';
import 'package:ecom/ui/screens/section_view_screen.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:ecom/ui/widget/category_item_widget.dart';
import 'package:ecom/ui/widget/home/home_banner_slider.dart';
import 'package:ecom/ui/widget/home/section_header.dart';
import 'package:ecom/ui/widget/product_item_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '.././widget/shimmer_loader_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SvgPicture.asset(
          'assets/images/logo_nav.svg',
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.person,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.call,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 16,
            child: Icon(
              Icons.notifications,
              size: 18,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              //Home Controller listen
              GetBuilder<HomeController>(builder: (homeController) {
                if (homeController.getProductSliderInProgress) {
                  return ShimmerLoaderWidget(
                    sizedBoxHeight: 180,
                    highlightColor: AppColors.primaryColor,
                  );
                } else {
                  return HomeBannerSlider(
                    productSliderModel: homeController.productSliderModel,
                  );
                }
              }),
              SectionHeader(
                HeaderName: 'All Categories',
                onTapSeeAll: () {
                  bottomNavigationController.changeIndex(1);
                },
              ),
              GetBuilder<CategoryController>(builder: (controller) {
                if (controller.getCategoryInProgress) {
                  return ShimmerLoaderWidget(
                    sizedBoxHeight: 100,
                    highlightColor: Colors.grey.withOpacity(0.2),
                  );
                } else {
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CategoryItemWidget(
                          categoryItemName: controller
                                  .categoryModel.data?[index].categoryName ??
                              '',
                          image: controller
                                  .categoryModel.data?[index].categoryImg ??
                              '',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductListScreen(
                                  categoryId:
                                      '${controller.categoryModel.data![index].id ?? 1}',
                                  categoryName:
                                      '${controller.categoryModel.data![index].categoryName}',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }
              }),
              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'Popular',
                onTapSeeAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ProductViewByRemark(remarkName: 'Popular'),
                    ),
                  );
                },
              ),
              GetBuilder<ProductController>(
                builder: (productController) {
                  if (productController.popularInProgress) {
                    return ShimmerLoaderWidget(
                      sizedBoxHeight: 100,
                      highlightColor: Colors.grey.withOpacity(0.2),
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController
                                  .popularProductMode.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return ProductItemPreviewCard(
                                productData: productController
                                    .popularProductMode.data![index]);
                          }),
                    );
                  }
                },
              ),

              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'Special',
                onTapSeeAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const ProductViewByRemark(remarkName: 'Special'),
                    ),
                  );
                },
              ),
              GetBuilder<ProductController>(
                builder: (productController) {
                  if (productController.specialInProgress) {
                    return ShimmerLoaderWidget(
                      sizedBoxHeight: 100,
                      highlightColor: Colors.grey.withOpacity(0.2),
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController
                                  .specialProductMode.data?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return ProductItemPreviewCard(
                                productData: productController
                                    .specialProductMode.data![index]);
                          }),
                    );
                  }
                },
              ),
              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'New',
                onTapSeeAll: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const ProductViewByRemark(remarkName: 'New'),
                    ),
                  );
                },
              ),
              GetBuilder<ProductController>(
                builder: (productController) {
                  if (productController.newInProgress) {
                    return ShimmerLoaderWidget(
                      sizedBoxHeight: 100,
                      highlightColor: Colors.grey.withOpacity(0.2),
                    );
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productController.newProductMode.data?.length ??
                                  0,
                          itemBuilder: (context, index) {
                            return ProductItemPreviewCard(
                                productData: productController
                                    .newProductMode.data![index]);
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
