import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/UI/Components/box_shadow.dart';

class FAQItem extends StatelessWidget {
  FAQItem({required this.question, required this.answer});

  final expandProvider = StateProvider<bool>((ref) => false);
  String question, answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer(
        builder: (context, ref, child) {
          final expand = ref.watch(expandProvider);
          return InkWell(
            onTap: () {
              if (expand) {
                ref.read(expandProvider.notifier).state = false;
              } else {
                ref.read(expandProvider.notifier).state = true;
              }
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: boxShadow),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$question ?',
                          style: TextStyle(
                              color: kDarkGreyColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: kDarkGreyColor,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    expand
                        ? Text(
                            answer.toString(),
                            style: TextStyle(
                              color: kLightGreyColor,
                            ),
                          )
                        : SizedBox()
                  ],
                )),
          );
        },
      ),
    );
  }
}
