import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/navigator.dart';

import '../../Models/home_model.dart';
import '../Screens/event_details_screen.dart';

late Timer adsTimer;

class HomeAds extends ConsumerWidget {
  HomeAds({required this.slider});

  List<ExploreSlider> slider;
  PageController controller =
      PageController(viewportFraction: 1, keepPage: true);
  final currentPageIndexProvider = StateProvider<int>((ref) => 0);

  void start(BuildContext context, WidgetRef ref) {
    if (slider.isNotEmpty) {
      try {
        adsTimer.cancel();
      } catch (e) {}

      adsTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        try {
          if (ref.read(currentPageIndexProvider.notifier).state <=
              slider.length - 2) {
            ref.read(currentPageIndexProvider.notifier).state++;

            controller.animateToPage(
                ref.read(currentPageIndexProvider.notifier).state,
                duration: const Duration(milliseconds: 800),
                curve: const Cubic(1, 1, 1, 1));
          } else {
            ref.read(currentPageIndexProvider.notifier).state = 0;

            controller.jumpToPage(
              ref.read(currentPageIndexProvider.notifier).state,
            );
          }
        } catch (e2) {}
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    start(context, ref);
    return Container(
      child: slider.isEmpty ?? true
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: AspectRatio(
                aspectRatio: 1 / 0.8,
                child: Stack(
                  children: [
                    PageView.builder(
                      itemCount: slider.length ?? 0,
                      controller: controller,
                      onPageChanged: (index) {
                        ref.read(currentPageIndexProvider.notifier).state =
                            index;
                      },
                      itemBuilder: (BuildContext context, index) {
                        return InkWell(
                          onTap: () {
                            navigator(
                                context: context,
                                screen: EventDetails(
                                  eventId: slider[index].id,
                                ));
                          },
                          child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  slider[index].image,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
