import 'package:flutter/material.dart';

class BotonPrincipal extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;

  const BotonPrincipal(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: (this.color == null) ? primaryColor : this.color,
      shape: StadiumBorder(side: BorderSide(color: primaryColor)),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.text,
              style: TextStyle(
                  color: this.textColor == null ? Colors.white : this.textColor,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
