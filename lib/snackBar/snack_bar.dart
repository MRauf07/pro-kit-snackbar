import 'package:flutter/cupertino.dart';
import 'package:pro_kit_snackbar/snackBar/kit_snack_bar.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

/// Show ProKit SnackBar
void showProKitSnackBar(
  BuildContext context, {
  String? title,
  String? message,
  required ProKitSnackBarType snackBarType,
  ProKitNotificationType? notificationType,
  ProKitSnackBarPosition? snackBarPosition,
  Color? color,
  bool autoClose = true,
  Duration autoCloseDuration = const Duration(seconds: 3),
  double? width,
  double? height,
  TextStyle? titleTextStyle,
  TextStyle? messageTextStyle,
  Widget? customIcon,
}) {
  ProKitSnackBar snackBar = ProKitSnackBar(
    title: title ?? "Notification",

    /// Default title if none provided
    message: message ?? "This is a default message",

    /// Default message
    notificationType: notificationType ?? ProKitNotificationType.success,

    ///Default notification type
    proKitSnackBarPosition: snackBarPosition ?? ProKitSnackBarPosition.bottomCenter,

    /// Default position
    color: color,

    /// User can specify a color or default to notificationType color
    autoClose: autoClose,

    /// Handle auto close
    autoCloseDuration: autoCloseDuration,
    // User-defined or default auto-close duration
    width: width,

    /// Customizable width
    height: height,

    /// Customizable height
    titleTextStyle: titleTextStyle,

    /// Customizable title text style
    messageTextStyle: messageTextStyle,

    /// Customizable message text style
    customIcon: customIcon,

    /// SnackBar Type
    snackBarType: snackBarType,
  );
  snackBar.showCustomSnackBar(context, snackBar);
}
