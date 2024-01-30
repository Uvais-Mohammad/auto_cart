import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({
    super.key,
    required ValueNotifier<int> current,
    required this.images,
  }) : _current = current;

  final ValueNotifier<int> _current;
  final List<String> images;

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Card(
              elevation: 4,
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    widget._current.value = index;
                  },
                ),
                carouselController: buttonCarouselController,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Image.network(
                  widget.images[itemIndex],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      buttonCarouselController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                      if (widget._current.value > 0) {
                        widget._current.value = widget._current.value - 1;
                      } else {
                        widget._current.value = widget.images.length - 1;
                      }
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      buttonCarouselController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear);
                      if (widget._current.value < widget.images.length - 1) {
                        widget._current.value = widget._current.value + 1;
                      } else {
                        widget._current.value = 0;
                      }
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ],
        ),
        ValueListenableBuilder(
            valueListenable: widget._current,
            builder: (context, value, child) {
              return DotsIndicator(
                dotsCount: widget.images.length,
                position: value,
                decorator: DotsDecorator(
                  shape: const CircleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                  ),
                  activeColor: Colors.white,
                  color: Colors.grey.shade300,
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  size: const Size(10, 10),
                ),
              );
            })
      ],
    );
  }
}
