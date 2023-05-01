import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeBannerSlider extends StatelessWidget {
  HomeBannerSlider({Key? key}) : super(key: key);

  final ValueNotifier<int> _currentSelectedIndex = ValueNotifier(0);
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _carouselController,

          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ),
              );
            });
          }).toList(),
          options: CarouselOptions(
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
                for (int i = 0; i < 5; i++)
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