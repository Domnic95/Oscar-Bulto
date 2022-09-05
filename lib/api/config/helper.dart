import 'package:dating_app/constants/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String s) {
  Fluttertoast.showToast(msg: s,backgroundColor: APP_PRIMARY_COLOR, gravity: ToastGravity.SNACKBAR);
}