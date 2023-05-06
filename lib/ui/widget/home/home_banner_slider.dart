import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/data/model/product_slider_model.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  HomeBannerSlider({Key? key, required this.productSliderModel})
      : super(key: key);

  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final CarouselController _carouselController = CarouselController();
  final ProductSliderModel productSliderModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: productSliderModel.data?.map((slider) {
            return Builder(
                builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  // image: DecorationImage(
                  //   image: NetworkImage(slider.image ?? ""),
                  // ),
                ),
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(slider.image ?? ''),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            slider.title ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.all(9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
          }).toList(),
          options: CarouselOptions(
              autoPlay: true,
              reverse: false,
              height: 180.0,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              }),
        ),
        const SizedBox(
          height: 4,
        ),
        ValueListenableBuilder(
          valueListenable: _currentSelectedIndex,
          builder: (context, updateValue, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < (productSliderModel.data?.length ?? 0); i++)
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: i == _currentSelectedIndex.value
                          ? AppColors.primaryColor
                          : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: i == _currentSelectedIndex.value
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
