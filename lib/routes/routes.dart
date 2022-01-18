import 'package:flutter/material.dart';
import 'package:openhab_flutter/pages/loading/loading_page.dart';
import 'package:openhab_flutter/pages/screens/home_screen.dart';
import 'package:openhab_flutter/pages/screens/control_screen.dart';
import 'package:openhab_flutter/pages/setup/setup_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'loading': (BuildContext c) => LoadingPage(),
  'setup': (BuildContext c) => SetupPage(),
  'home': (BuildContext c) => HomeScreen(),
  'control': (BuildContext c) => ControlScreen(),
};
