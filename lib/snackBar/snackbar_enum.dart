import 'package:flutter/material.dart';
import 'package:pro_kit_snackbar/snackBar/snack_bar_colors.dart';

enum ProKitSnackBarPosition {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight
}

class ProKitNotificationType {

  ///ProKit Animations for SnackBars
  static const String helpAnim = "packages/pro_kit_snackbar/assets/anim/info_mark.json";
  static const String errorAnim = "packages/pro_kit_snackbar/assets/anim/cross_mark.json";
  static const String successAnim = "packages/pro_kit_snackbar/assets/anim/check_mark.json";
  static const String warningAnim = "packages/pro_kit_snackbar/assets/anim/warning_mark.json";



  /// The notification message; this parameter is required.
  final String message;

  /// The color of the notification; defaults to `SnackBarColors` if null.
  final Color? color;

  final String? anim;

  const ProKitNotificationType(this.message, [this.color,this.anim]);

  /// Predefined notification types with default messages and colors.
  static const ProKitNotificationType help = ProKitNotificationType('Help', SnackBarColors.help,helpAnim);
  static const ProKitNotificationType failure = ProKitNotificationType('Failure', SnackBarColors.failure,errorAnim);
  static const ProKitNotificationType success = ProKitNotificationType('Success', SnackBarColors.success,successAnim);
  static const ProKitNotificationType warning = ProKitNotificationType('Warning', SnackBarColors.warning,warningAnim);
}

enum ProKitSnackBarType { colored, bordered }
