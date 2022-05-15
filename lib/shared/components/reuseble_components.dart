import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/style/icon-broken.dart';

void navi(context, Widget page) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );

void naviAndExit(context, Widget page) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );

Widget formField({
  required TextEditingController controller,
  TextInputType? type,
  required String label,
  FormFieldValidator<String>? validat,
  ValueChanged<String>? onchange,
  ValueChanged<String>? onFieldSubmitted,
  VoidCallback? editingComplete,
  GestureTapCallback? OneTap,
  Widget? preIcon,
  Widget? prefix,
  Widget? sufIcon,
  Widget? suffix,
  InputBorder? enabledBorder,
  bool obscure = false,
  bool onlyread = false,
  TextInputAction? inputAction = TextInputAction.next,
}) =>
    TextFormField(
      textInputAction: inputAction,
      onEditingComplete: editingComplete,
      controller: controller,
      keyboardType: type,
      onChanged: onchange,
      onFieldSubmitted: onFieldSubmitted,
      onTap: OneTap,
      readOnly: onlyread,
      obscureText: obscure,
      validator: validat,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: preIcon,
        suffixIcon: sufIcon,
        suffix: suffix,
        enabledBorder: enabledBorder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

Future<bool?> toast({required String message, required ToastColor state}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 14.0);

Color chooseToastColor(ToastColor color) {
  if (ToastColor.success == color) {
    return Colors.green;
  }
  if (ToastColor.warning == color) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

enum ToastColor { success, error, warning }

PreferredSizeWidget defaultAppbar(
    {required context, required String title, required List<Widget> action}) {
  return AppBar(
    titleSpacing: 0,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(IconBroken.Arrow___Left_2)),

    title: Text(title),
    actions: action,
  );
}
