import 'package:ecom/ui/getx/bottom_navigation_controller.dart';
import 'package:ecom/ui/getx/category_controller.dart';
import 'package:ecom/ui/screens/product_list_screen.dart';
import 'package:ecom/ui/widget/category_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({Key? key}) : super(key: key);

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {
  BottomNavigationController controller = Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Categories',
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
      body: GetBuilder<CategoryController>(builder: (controller) {
        if (controller.getCategoryInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            controller.getCategoryList();
          },
          child: GridView.builder(
              itemCount: controller.categoryModel.data?.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                return CategoryItemWidget(
                    categoryItemName:
                        controller.categoryModel.data?[index].categoryName ??
                            '',
                    image:
                        controller.categoryModel.data?[index].categoryImg ?? '',
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
                    });
              }),
        );
      }),
    );
  }
}
