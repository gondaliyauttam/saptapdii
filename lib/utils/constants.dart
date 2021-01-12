import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static SharedPreferences prefs;
}

File image;
int done = 0;
int all = 0;
int customDone = 0;
int customAll = 0;
int showTime = 0;
BuildContext dialogContext;
