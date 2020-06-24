import 'package:flutter/material.dart';

const kMainTheme = Color(0xff1a47a2);
const kCircular = Color(0xff6E8BC5);
const kDimText = Color(0xffBEDAFF);
const kDimPink = Color(0x50ECACAC);

const String kAppBarLogo = 'images/logo.jpg';

const kEmail = '';

const List<String> weekdays = [
  'Sunday',
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday'
];

const List<String> months = [
  'January',
  'February ',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

enum Meal { breakfast, lunch, dinner, snack }

const divider = const Divider(
  color: Colors.grey,
  height: 0,
  thickness: 1,
  indent: 20,
  endIndent: 20,
);
