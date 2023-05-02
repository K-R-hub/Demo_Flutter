import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/style/icon_broken.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
      title: Text(title!),
      actions: actions,
    );

Widget defaultButton({
  double width = double.infinity,
  Color Color = Colors.lightBlue,
  required String text,
  double fontSize = 20,
  Function? onpressed,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color,
      ),
      child: MaterialButton(
        onPressed: () {
          onpressed!();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController textControl,
  required TextInputType keyboardType,
  required String label,
  required Widget prefix,
  String? Function(String? value)? validator,
  bool obscureText = false,
  IconData? suffix,
  VoidCallback? suffixPressed,
  ValueChanged<String>? onSubmit,
  var onTap,
  ValueChanged<String>? onChange,
}) =>
    TextFormField(
      controller: textControl,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
    );

void goToScreen(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );

void goToScreenAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
    (route) => false);

void showToast({
  required String msg,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: chooseToastColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, ERROR, WARNING }

Color chooseToastColor({
  required ToastState state,
}) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
