class Urls {
  static const String baseUrl = 'https://craftybay.teamrabbil.com/api';
  static const String productSliderUrl = '$baseUrl/ListProductSlider';
  static const String categoryList = '$baseUrl/CategoryList';
  static const String productRemarksNew = '$baseUrl/ListProductByRemark/new';
  static const String productRemarksSpeceil = '$baseUrl/ListProductByRemark/special';
  static const String productRemarksPopular = '$baseUrl/ListProductByRemark/popular';
  static const String readProfileDetails = '$baseUrl/ReadProfile';

  static String productbyCategoryUrl(String categoryId) =>
      '$baseUrl/ListProductByCategory/$categoryId';

  static String getProductDetailsById(int productDetailsId) =>
      '$baseUrl/ProductDetailsById/$productDetailsId';

  static String sendOtpToEmail(String email) =>
      '$baseUrl/UserLogin/$email';

  static String otpVerification(String email, String otp) =>
      '$baseUrl/VerifyLogin/$email/$otp';


}