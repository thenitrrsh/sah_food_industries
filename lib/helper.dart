import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class Helper {
  static List<Map<String, Color>> getShuffledColors() {
    List<Map<String, Color>> shuffledColors = List.from(colors);
    shuffledColors.shuffle(Random());
    return shuffledColors;
  }

  // List of colors
  static final List<Map<String, Color>> colors = [
    {
      'background': Colors.red.shade300,
      'text': Colors.red.shade500,
    },
    {
      'background': Colors.green.shade300,
      'text': Colors.green.shade500,
    },
    {
      'background': Colors.blue.shade300,
      'text': Colors.blue.shade500,
    },
    {
      'background': Colors.teal.shade300,
      'text': Colors.teal.shade500,
    },
    {
      'background': Colors.pink.shade300,
      'text': Colors.pink.shade500,
    },
    {
      'background': Colors.orange.shade300,
      'text': Colors.orange.shade500,
    },
    {
      'background': Colors.purple.shade300,
      'text': Colors.purple.shade500,
    },
    {
      'background': Colors.brown.shade300,
      'text': Colors.brown.shade500,
    }
  ];

// Method to pick a random index
  static List<Color> getRandomColorIndex({int seed = 0}) {
    final random = Random(seed);
    Map<String, Color> data = colors[random.nextInt(colors.length)];
    List<Color> color = [];
    color.add(data['background']!);
    color.add(data['text']!);
    return color;
  }

  List<String> homeCardNames = [
    'John Doe',
    'Jane Smith',
    'Michael Johnson',
    'Emily Brown',
  ];
  cardNames(index) {
    return homeCardNames[index];
  }

  static final List<String> indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  stateNames(index) {
    return indianStates[index];
  }
}
