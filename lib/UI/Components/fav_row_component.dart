import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayyak/main.dart';

import '../../Config/constants.dart';

class FavRow extends StatelessWidget {
  const FavRow({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: screenWidth / 1.2,
      child: Row(
        children: [
          Container(
            width: screenWidth / 2.5,
            height: screenWidth / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/amr-diab-promo.jpg'),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Magic Plant',
                style: TextStyle(
                  color: kLightGreyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.location_on,
                    size: 20,
                    color: kLightGreyColor,
                  ),
                  Text(
                    'Riyadh',
                    style: TextStyle(color: kLightGreyColor, fontSize: 12),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    SizedBox(width: screenWidth / 3),
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.file_upload_outlined,
                          size: 20,
                          color: kLightGreyColor,
                        )),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        color: kLightGreyColor,
                        width: 15,
                        height: 15,
                        'assets/icon/Icon feather-heart.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
