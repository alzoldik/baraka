import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: 111.0,
      child: Swiper(
        autoplay: false,
        loop: false,
        pagination: SwiperPagination(),
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            "assets/imgs/slider-img.png",
            fit: BoxFit.contain,
            height: 200.0,
          );
        },
        itemCount: 3,
        viewportFraction: 1.0,
        scale: 0.9,
      ),
    );
  }
}
