import 'package:flutter/material.dart';

class BotonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool? state;
  final Color? color;
  final IconData? icon;
  final String label;
  final BorderRadiusGeometry? borderRadius;
  // final Color? textColor;

  const BotonCustom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.state,
    this.color,
    this.icon,
    this.borderRadius,
    required this.label,
    // this.color,
    // this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: this.color != null
              ? null
              : LinearGradient(
                  colors: [
                    // const Color.fromARGB(255, 88, 160, 250),
                    // const Color.fromARGB(255, 54, 117, 246),
                    const Color.fromARGB(255, 88, 160, 240),
                    const Color.fromARGB(255, 54, 117, 246),
                  ],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
          color: this.color != null ? this.color : null,
          borderRadius: this.borderRadius,
          // border: Border.all(color: Colors.blueAccent),
        ),
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        width: size.width / 3.7,
        height: 80,
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  this.icon == null ? Icons.ac_unit_outlined : this.icon,
                  color: this.color == null ? Colors.white : Colors.blue,
                ),
                Expanded(child: SizedBox()),
                Text(
                  this.label,
                  style: TextStyle(
                      color: this.color == null ? Colors.white : Colors.blue,
                      fontSize: 13),
                  softWrap: true,
                )
              ],
            ),
            Center(
              child: Text(this.text,
                  style: TextStyle(
                      color: this.color == null ? Colors.white : Colors.blue,
                      fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
