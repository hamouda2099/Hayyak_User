import 'package:flutter/material.dart';

class TestDate {
  List<Map> seatsCategory = [
    {
      "seat_category" : "Seat Front",
      "price" : 100,
      "color": const Color(0xFF634773),
      "rows" : [
        {
          "row": "B1",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "B2",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "B3",
          "row_seats" : [
            '1','2','3','4',
          ]
        },

      ],
    },
    {
      "seat_category" : "Seat Middle",
      "price" : 50,
      "color": const Color(0xFFfead1c),
      "rows" : [
        {
          "row": "C1",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "C2",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "C3",
          "row_seats" : [
            '1','2','3','4',
          ]
        },

      ],
    },
    {
      "seat_category" : "Box A",
      "price" : 50,
      "color": const Color(0xFF2EAE78),
      "rows" : [
        {
          "row": "Box 1",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "Box 2",
          "row_seats" : [
            '1','2','3','4',
          ]
        },
        {
          "row": "Box 3",
          "row_seats" : [
            '1','2','3','4',
          ]
        },

      ],
    },
  ];
}