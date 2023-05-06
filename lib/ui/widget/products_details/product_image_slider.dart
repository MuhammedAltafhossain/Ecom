import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageSlider extends StatelessWidget {
  final List<String> sliders;
  ProductImageSlider({Key? key, required this.sliders}) : super(key: key);

  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _carouselController,
          items: sliders.map((slider) {
            return Builder(builder: (BuildContext context) {
              return Container(
                // margin: const EdgeInsets.symmetric(horizontal: 3),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(slider),
                      fit: BoxFit.scaleDown),
                  // borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
              );
            });
          }).toList(),
          options: CarouselOptions(
              height: 230.0,
              viewportFraction: 1,
              onPageChanged: (index, _) {
                _currentSelectedIndex.value = index;
              }),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ValueListenableBuilder(
                  valueListenable: _currentSelectedIndex,
                  builder: (context, updateValue, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 5; i++)
                          Container(
                            margin: const EdgeInsets.all(3),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              color: i == _currentSelectedIndex.value
                                  ? AppColors.primaryColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: i == _currentSelectedIndex.value
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
