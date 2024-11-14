import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:showcasing/asset_manager.dart';
import 'package:showcasing/components/carousel_slider.dart';

final viewAllKey = GlobalKey();
final checkOutKey = GlobalKey();
final offersKey = GlobalKey();
final List<List> products = [
  [
    'Salad',
    ImageAssets.fp1,
  ],
  [
    'Karahi',
    ImageAssets.fp2,
  ],
  [
    'Burger',
    ImageAssets.fp3,
  ],
  [
    'Noodles',
    ImageAssets.fp4,
  ]
];

final List<List> restaurants = [
  [
    'Flavor Haven',
    ImageAssets.fr1,
    'Where flavors meet passion—come savor the magic!'
  ],
  [
    'The Urban Fork',
    ImageAssets.fr2,
    'Bringing you bites of bliss, one plate at a time.'
  ],
  ['Spice Odyssey', ImageAssets.fr3, 'Eat. Laugh. Love. Repeat.'],
  ['Taste Route', ImageAssets.fr4, 'Crafting meals, creating memories'],
];

TextStyle getShowcaseTitleStyle() {
  return GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}

TextStyle getShowcaseDescriptionStyle() {
  return GoogleFonts.poppins(fontSize: 12, color: Colors.black54);
}

class FoodHomePage extends StatefulWidget {
  const FoodHomePage({super.key});

  @override
  State<FoodHomePage> createState() => _FoodHomePageState();
}

class _FoodHomePageState extends State<FoodHomePage> {
  late final ScrollController controller;
  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      onComplete: (index, key) {},
      builder: Builder(
        builder: (ctx) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ShowCaseWidget.of(ctx).startShowCase([viewAllKey]);
          });
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 70,
              title: Text(
                'Food Store',
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel Slider
                  const FoodCarouselSlider(),
                  const SizedBox(height: 28),

                  // Horizontal Products List
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Popular Dishes',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Showcase(
                          key: viewAllKey,
                          disposeOnTap: true,
                          title: 'View All Products',
                          titleTextStyle: getShowcaseTitleStyle(),
                          onTargetClick: () {
                            controller
                                .animateTo(200,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear)
                                .then((value) => ShowCaseWidget.of(ctx)
                                    .startShowCase([checkOutKey]));
                          },
                          descTextStyle: getShowcaseDescriptionStyle(),
                          description:
                              'By taping View All, you will get to see all food products.',
                          child: TextButton(
                              onPressed: () {}, child: const Text('View All')),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 130,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(right: 14),
                          child: Column(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      products[index][1],
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                products[index][0],
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Restaurants List
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Nearby Restaurants',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          leading: CircleAvatar(
                            backgroundImage:
                                Image.asset(restaurants[index][1]).image,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 2.5),
                            child: Text(restaurants[index][0],
                                style: const TextStyle(
                                  fontSize: 14,
                                )),
                          ),
                          subtitle: Text(
                            restaurants[index][2],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                height: 1.35,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[600]),
                          ),
                          trailing: index != 0
                              ? SizedBox(
                                  height: 24,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor:
                                            Colors.orange.withOpacity(0.2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10)),
                                    onPressed: () {},
                                    child: const Text(
                                      'Checkout',
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.orange,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              : Showcase(
                                  key: checkOutKey,
                                  title: 'Checkout Restaurant',
                                  targetBorderRadius: BorderRadius.circular(30),
                                  titleTextStyle: getShowcaseTitleStyle(),
                                  disposeOnTap: true,
                                  onTargetClick: () {
                                    controller
                                        .animateTo(
                                            controller.position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 500),
                                            curve: Curves.linear)
                                        .then((value) => ShowCaseWidget.of(ctx)
                                            .startShowCase([offersKey]));
                                  },
                                  descTextStyle: getShowcaseDescriptionStyle(),
                                  description:
                                      'By taping checkout, you will get to see restaurant profile & products they are offering',
                                  child: SizedBox(
                                    height: 24,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              Colors.orange.withOpacity(0.2),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10)),
                                      onPressed: () {},
                                      child: const Text(
                                        'Checkout',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.sizeOf(context).width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Showcase(
                              key: offersKey,
                              title: 'Explore Offers',
                              targetBorderRadius: BorderRadius.circular(30),
                              titleTextStyle: getShowcaseTitleStyle(),
                              descTextStyle: getShowcaseDescriptionStyle(),
                              description:
                                  'By taping offers, you will get to see the restaurant offers',
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.local_offer),
                                label: const Text('Offers'),
                              )),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.delivery_dining),
                            label: const Text('Delivery'),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map),
                            label: const Text('Nearby'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
