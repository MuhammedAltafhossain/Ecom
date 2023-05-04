import 'package:ecom/data/model/category_model.dart';
import 'package:ecom/data/network_utils.dart';
import 'package:ecom/data/urls.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryModel categoryModel = CategoryModel();

  bool getCategoryInProgress = false;

  Future<bool> getCategoryList() async {
    getCategoryInProgress = true;
    update();
    final result = await NetworkUtils().getMethod(Urls.categoryList);
    getCategoryInProgress = false;
    update();
    if (result != null) {
      categoryModel = CategoryModel.fromJson(result);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
