import 'dart:async';

import 'package:flutter/material.dart';
import 'package:openhab_flutter/pages/screens/screens.dart';
import 'package:openhab_flutter/pages/setup/setup_page.dart';
import 'package:openhab_flutter/services/setupServer_service.dart';
import 'package:openhab_flutter/widgets/logo/appname_widget.dart';
import 'package:openhab_flutter/widgets/logo/logo_widget.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Hero(
              tag: 'logo',
              transitionOnUserGestures: true,
              child: Material(
                type: MaterialType.transparency,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoWidget(width: 300.0),
                    AppNameWidget(
                        width: 300.0, color: Theme.of(context).primaryColor),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final setupServerService = Provider.of<SetupServerService>(context);

    // await Timer(Duration(seconds: 1), () {});
    final isSetteUp = await setupServerService.isSettedUpRemote();

    if (isSetteUp) {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => HomeScreen(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => SetupPage(),
              transitionDuration: Duration(milliseconds: 1000)));
    }
  }
}
