import 'package:flutter/material.dart';

class FormFieldInput extends StatelessWidget {
  final String? placeholder;
  final TextEditingController? textController;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  // const GlobalKey<FormFieldState> fieldFormKey = GlobalKey<FormFieldState>();
  final TextInputType? keyboardType;
  final String? labelText;
  final bool isPassword;
  final Icon? suffixIcon;

  const FormFieldInput(
      //const
      {Key? key,
      @required this.placeholder,
      @required this.textController,
      @required this.validator,
      @required this.onChanged,
      this.keyboardType = TextInputType.text,
      this.labelText = '',
      this.isPassword = false,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: this.textController,
        validator: this.validator,
        keyboardType: this.keyboardType,
        obscureText: this.isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 242, 242, 242),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: this.placeholder,
          labelText: this.labelText,
          suffixIcon: this.suffixIcon,
        ),
        onChanged: this.onChanged,
      ),
    );
  }
}
