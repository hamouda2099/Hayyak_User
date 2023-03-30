import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/home_model.dart';
import '../Screens/event_details_screen.dart';


late Timer adsTimer;

class HomeAds extends ConsumerWidget {
  HomeAds({required this.slider});
  List<ExploreSlider> slider;
  PageController controller =
  PageController(viewportFraction: 1, keepPage: true);
  final currentPageIndexProvider = StateProvider<int>((ref) => 0);

  void start(BuildContext context) {
    if (slider.isNotEmpty) {
      try {
        adsTimer.cancel();
      } catch (e) {}

      adsTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        try {
          if (context.read(currentPageIndexProvider).state <=
              slider.length - 2) {
            context.read(currentPageIndexProvider).state++;

            controller.animateToPage(
                context.read(currentPageIndexProvider.notifier).state,
                duration: const Duration(milliseconds: 800),
                curve: const Cubic(1, 1, 1, 1));
          } else {
            context.read(currentPageIndexProvider).state = 0;

            controller.jumpToPage(
              context.read(currentPageIndexProvider).state,
            );
          }
        } catch (e2) {}
      });
    }
  }

  @override
  Widget build(BuildContext context,ScopedReader watch) {
    start(context);
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
                      context
                          .read(currentPageIndexProvider)
                          .state = index;
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
                              fit:BoxFit.fill,
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
