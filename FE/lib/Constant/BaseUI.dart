import 'package:dart_findy/Constant/Constants.dart';
import 'package:flutter/material.dart';

import './InApp.dart';

class NavItem {
  final int index;
  final double size;
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;

  const NavItem({
    required this.index,
    required this.size,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}

