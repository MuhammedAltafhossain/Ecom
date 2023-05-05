class Urls{
  static const String baseUrl = 'https://craftybay.teamrabbil.com/api';
  static const String productSliderUrl = '${baseUrl}/ListProductSlider';
  static const String categoryList = '${baseUrl}/CategoryList';
  static const String productRemarksNew = '${baseUrl}/ListProductByRemark/new';
  static const String productRemarksSpeceil = '${baseUrl}/ListProductByRemark/special';
  static const String productRemarksPopular = '${baseUrl}/ListProductByRemark/popular';

  static String productbyCategoryUrl(String categoryId)=>
      '${baseUrl}/ListProductByCategory/${categoryId}';


}