import 'package:flutter/material.dart';
import 'package:pro_kit_snackbar/snackBar/bordered_snackbar.dart';
import 'package:pro_kit_snackbar/snackBar/colored_snackbar.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

class ProKitSnackBar extends StatelessWidget {
  final String title;
  final String message;
  final Color? color;
  final ProKitSnackBarType snackBarType;
  final ProKitNotificationType notificationType;
  final bool inMaterialBanner;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final ProKitSnackBarPosition? proKitSnackBarPosition;
  final bool autoClose;
  final Duration autoCloseDuration;
  final double? width;
  final double? height;
  final Widget? customIcon;

  const ProKitSnackBar({
    super.key,
    this.color,
    this.titleTextStyle,
    this.messageTextStyle,
    required this.title,
    required this.message,
    required this.snackBarType,
    required this.notificationType,
    this.inMaterialBanner = false,
    this.proKitSnackBarPosition,
    this.autoClose = true,
    this.autoCloseDuration = const Duration(milliseconds: 3000),
    this.width,
    this.height,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return snackBarType == ProKitSnackBarType.colored
        ? ColoredSnackBar(
            title: title,
            message: message,
            notificationType: notificationType,
            color: color,
            titleTextStyle: titleTextStyle,
            messageTextStyle: messageTextStyle,
            inMaterialBanner: inMaterialBanner,
            proKitSnackBarPosition: proKitSnackBarPosition,
            autoClose: autoClose,
            autoCloseDuration: autoCloseDuration,
            width: width,
            height: height,
            customIcon: customIcon,
          )
        : BorderedSnackBar(
            title: title,
            message: message,
            notificationType: notificationType,
            color: color,
            titleTextStyle: titleTextStyle,
            messageTextStyle: messageTextStyle,
            width: width,
            height: height,
            customIcon: customIcon,
            snackBarType: snackBarType,
          );
  }

  Alignment _getAlignmentForPosition(ProKitSnackBarPosition position) {
    switch (position) {
      case ProKitSnackBarPosition.topLeft:
        return Alignment.topLeft;
      case ProKitSnackBarPosition.topCenter:
        return Alignment.topCenter;
      case ProKitSnackBarPosition.topRight:
        return Alignment.topRight;
      case ProKitSnackBarPosition.centerLeft:
        return Alignment.centerLeft;
      case ProKitSnackBarPosition.center:
        return Alignment.center;
      case ProKitSnackBarPosition.centerRight:
        return Alignment.centerRight;
      case ProKitSnackBarPosition.bottomLeft:
        return Alignment.bottomLeft;
      case ProKitSnackBarPosition.bottomCenter:
        return Alignment.bottomCenter;
      case ProKitSnackBarPosition.bottomRight:
        return Alignment.bottomRight;
      default:
        return Alignment.bottomCenter;
    }
  }

  void showCustomSnackBar(BuildContext context, ProKitSnackBar snackBar) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {

        final Alignment alignment = snackBar._getAlignmentForPosition(
          snackBar.proKitSnackBarPosition ??
              ProKitSnackBarPosition.bottomCenter,
        );

        EdgeInsets padding;

        /// Check the alignment and set the corresponding padding
        if (alignment == Alignment.topCenter ||
            alignment == Alignment.topLeft ||
            alignment == Alignment.topRight) {

          padding = EdgeInsets.only(
              top: 15,
              left: alignment == Alignment.topLeft ? 10 : 0,
              right: alignment == Alignment.topRight ? 10 : 0);
        }

        else if (alignment == Alignment.bottomCenter ||
            alignment == Alignment.bottomLeft ||
            alignment == Alignment.bottomRight) {

          padding = EdgeInsets.only(
              bottom: 15,
              left: alignment == Alignment.bottomLeft ? 10 : 0,
              right: alignment == Alignment.bottomRight ? 10 : 0);
        }

        else if (alignment == Alignment.centerLeft) {
          padding = const EdgeInsets.only(left: 15);
        }

        else if (alignment == Alignment.centerRight) {
          padding = const EdgeInsets.only(right: 15);
        }

        else {
          padding = const EdgeInsets.all(15);

          /// Default padding for center alignment
        }


        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: padding,
            child: Align(
              alignment: snackBar._getAlignmentForPosition(
                  snackBar.proKitSnackBarPosition ??
                      ProKitSnackBarPosition.bottomCenter),
              child: snackBar,
            ),
          ),
        );
      },
    );

    if (snackBar.autoClose) {
      Future.delayed(snackBar.autoCloseDuration, () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }
  }
}
