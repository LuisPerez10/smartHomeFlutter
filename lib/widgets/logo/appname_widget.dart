import 'package:flutter/material.dart';

class AppNameWidget extends StatelessWidget {
  final double? width;
  final Color? color;

  const AppNameWidget({Key? key, @required this.width, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Open',
              style: TextStyle(
                fontSize: 34,
                fontFamily: "Cabin",
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text('HabC',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 74, 75, 77))),
          ],
        ),
      ),
      Container(
        width: width,
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        child: Text(
          'EMPODERANDO LA CASA INTELIGENTE',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 124, 125, 126),
              fontFamily: 'Metropolis',
              fontSize: 11,
              letterSpacing: 2),
        ),
      ),
    ]);
  }
}
