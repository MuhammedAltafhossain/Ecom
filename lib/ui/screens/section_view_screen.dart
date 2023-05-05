import 'package:ecom/ui/getx/product_controller.dart';
import 'package:ecom/ui/widget/product_item_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewByRemark extends StatefulWidget {
  final String remarkName;

  const ProductViewByRemark(
      {Key? key, required this.remarkName})
      : super(key: key);

  @override
  State<ProductViewByRemark> createState() => _ProductViewByRemarkState();
}

class _ProductViewByRemarkState extends State<ProductViewByRemark> {
  ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.remarkName == 'Popular'){
        controller.getPopularProducts();
      }else if(widget.remarkName == 'Special'){
        controller.getSpecialProducts();
      }else{
        controller.getNewProducts();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          widget.remarkName,
          style: const TextStyle(color: Colors.black54),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
      body: RemarksWidget(widget: widget),
    );
  }
}

class RemarksWidget extends StatelessWidget {
  const RemarksWidget({
    super.key,
    required this.widget,
  });

  final ProductViewByRemark widget;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
        builder: (productController) {
      if(widget.remarkName == 'Popular'){
        if (productController.productByCategoryProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((productController.popularProductMode.data?.length ?? 0) == 0) {
          return const Center(
            child: Text('No products'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2 / 2.5),
          itemCount: productController.popularProductMode.data?.length ?? 0,
          itemBuilder: (context, index) {
            return ProductItemPreviewCard(
              productData:
              productController.popularProductMode.data![index],
            );
          },
        );
      }
      else if (widget.remarkName == 'Special'){
        if (productController.productByCategoryProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((productController.specialProductMode.data?.length ?? 0) == 0) {
          return const Center(
            child: Text('No products'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2 / 2.5),
          itemCount: productController.specialProductMode.data?.length ?? 0,
          itemBuilder: (context, index) {
            return ProductItemPreviewCard(
              productData:
              productController.specialProductMode.data![index],
            );
          },
        );
      }
      else{
        if (productController.productByCategoryProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if ((productController.newProductMode.data?.length ?? 0) == 0) {
          return const Center(
            child: Text('No products'),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 2 / 2.5),
          itemCount: productController.newProductMode.data?.length ?? 0,
          itemBuilder: (context, index) {
            return ProductItemPreviewCard(
              productData:
              productController.newProductMode.data![index],
            );
          },
        );
      }

    });
  }
}
