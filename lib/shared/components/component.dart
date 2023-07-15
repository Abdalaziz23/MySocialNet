import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget,),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget,
  ),
  (Route<dynamic> route) => false,
);

Widget defaultTextButton({
  required VoidCallback? onPressed,
  required String? text,
}) =>TextButton(
    onPressed: onPressed,
    child: Text(
        text!.toUpperCase(),
    ),
);

Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? keyboardType,
  ValueChanged<String>? onFieldSubmit,
  ValueChanged<String>? onChanged,
  GestureTapCallback? onTap,
  @required FormFieldValidator? validator,
  @required String? labelText,
  @required IconData? prefix,
  IconData? suffix,
  bool obscureText = false,
  VoidCallback? onPressed,
}) => TextFormField(
  controller: controller,
  keyboardType: keyboardType,
  onFieldSubmitted: onFieldSubmit,
  obscureText: obscureText,
  onChanged: onChanged,
  validator: validator,
  onTap: onTap,
  decoration: InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(onPressed: onPressed, icon: Icon(suffix,),
    )
        : null,
    border: OutlineInputBorder(),
  ),
);

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  @required VoidCallback? function,
  bool isUpperCase = true,
  required String text,
}) =>
    Container(
      width: width,
      color: color,
      height: 40,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 25.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  title: Text(
      title!,
  ),
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios,
    ),
  ),
  actions:actions,
);

void showToast({
  required String text,
  required ToastStates state,
}) =>Fluttertoast.showToast(
  msg: text ,
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);
enum ToastStates{success,error,warning}
Color chooseToastColor(ToastStates state)
{
  Color color;
  switch(state)
  {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
