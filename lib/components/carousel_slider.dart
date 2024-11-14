import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcasing/asset_manager.dart';

class FoodCarouselSlider extends StatefulWidget {
  const FoodCarouselSlider({super.key});

  @override
  State<FoodCarouselSlider> createState() => _FoodCarouselSliderState();
}

class _FoodCarouselSliderState extends State<FoodCarouselSlider> {
  int currentIndex = 0;
  late CarouselController carouselController;
  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  Widget carouselOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 140,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.blue[200]!.withOpacity(0.4),
                      Colors.blue[100]!.withOpacity(0.3),
                      Colors.orange.withOpacity(0.2),
                      Colors.orange.withOpacity(0.3)
                    ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New User',
                      style: GoogleFonts.satisfy(
                          height: 1,
                          fontSize: 10,
                          color: const Color(0xffE8AD0D)),
                    ),
                    Text(
                      'Discount',
                      style: GoogleFonts.satisfy(
                          height: 1,
                          fontSize: 16,
                          color: const Color(0xff8282D7)),
                    ),
                    Text(
                      'Upto 50% off',
                      style: GoogleFonts.satisfy(
                          height: 1, fontSize: 16, color: Colors.orange),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              side: const BorderSide(color: Colors.orange),
                              backgroundColor: Colors.transparent),
                          onPressed: () {},
                          child: Text(
                            'CLAIM VOUCHER',
                            style: GoogleFonts.notoSans(
                                fontSize: 10,
                                letterSpacing: -0.2,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange),
                          )),
                    )
                  ],
                ),
                Image.asset(
                  ImageAssets.burger,
                  scale: 1.5,
                )
              ],
            ),
          ),
          Positioned(
              bottom: 6,
              child: DotsIndicator(
                dotsCount: 3,
                position: currentIndex,
                onTap: (index) {
                  carouselController.animateToPage(index);
                },
                decorator: DotsDecorator(
                    color: Colors.grey,
                    activeColor: Colors.orange,
                    size: const Size.square(8),
                    activeSize: const Size(16, 8),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        items: [carouselOptions(), carouselOptions(), carouselOptions()],
        options: CarouselOptions(
          height: 140,
          viewportFraction: 1,
          autoPlay: true,
          onPageChanged: (page, _) {
            setState(() {
              currentIndex = page;
            });
          },
          autoPlayInterval: const Duration(seconds: 3),
        ));
  }
}
