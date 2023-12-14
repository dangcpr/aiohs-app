import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key, required this.urlImages}) : super(key: key);

  final List<String> urlImages;

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider.builder(
              carouselController: controller,
              itemCount: widget.urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = widget.urlImages[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                  height: 400,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index))),
          SizedBox(height: 12),
          buildIndicator()
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotWidth: 8,
            activeDotColor: colorProject.primaryColor,
            dotHeight: 12),
        activeIndex: activeIndex,
        count: widget.urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, int index) =>
    Container(child: Image.network(urlImage, fit: BoxFit.cover));
