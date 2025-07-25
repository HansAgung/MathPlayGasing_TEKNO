import 'package:flutter/material.dart';
import 'package:mathgasing_v1/src/features/presentation/Features/homepage.dart';

import '../../features/presentation/Features/QuestFeature/quest_page.dart';

class NavHelper {
  static final List<Widget> pages = [
    const Homepage(),
    const QuestPage(),
  ];

  static final List<IconData> icons = [
    Icons.home,
    Icons.flag,
    Icons.extension,
    Icons.person,
    Icons.emoji_events,
  ];

  static final List<String> labels = [
    'Home',
    'Quest',
    'Artefact',
    'Profile',
    'Leader',
  ];
}
