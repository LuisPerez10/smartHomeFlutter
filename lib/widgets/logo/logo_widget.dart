import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final width;
  const LogoWidget({Key? key, @required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        child: Container(
          color: Colors.white.withOpacity(0),
          width: width * 0.3,
          child: Image.asset('assets/logo-main.png'),
        ));
  }
}
