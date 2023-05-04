import 'package:ecom/ui/getx/home_controller.dart';
import 'package:ecom/ui/widget/category_item_widget.dart';
import 'package:ecom/ui/widget/home/home_banner_slider.dart';
import 'package:ecom/ui/widget/home/section_header.dart';
import 'package:ecom/ui/widget/product_item_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getProductSliderList();
  }

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
              GetBuilder<HomeController>(
                  builder: (homeController) {
                    if(homeController.getProductSliderInProgress){
                      return CircularProgressIndicator();
                    }
                    else{
                      return HomeBannerSlider(
                        productSliderModel: homeController.productSliderModel,
                      );
                    }

              }),
              SectionHeader(
                HeaderName: 'All Categories',
                onTapSeeAll: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.computer,
                      categoryItemName: 'Electronics',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.add_business,
                      categoryItemName: 'Tools',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.shop_outlined,
                      categoryItemName: 'Shop',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.add_chart_outlined,
                      categoryItemName: 'Add Chart',
                    ),
                    CategoryItemWidget(
                      onTap: () {},
                      icon: Icons.today_outlined,
                      categoryItemName: 'today',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'Popular',
                onTapSeeAll: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'Special',
                onTapSeeAll: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SectionHeader(
                HeaderName: 'New',
                onTapSeeAll: () {},
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                    ProductItemPreviewCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
