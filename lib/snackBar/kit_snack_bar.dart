import 'package:flutter/material.dart';
import 'package:pro_kit_snackbar/snackBar/bordered_snackbar.dart';
import 'package:pro_kit_snackbar/snackBar/colored_snackbar.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

/// A versatile widget that displays a custom SnackBar or MaterialBanner
/// with customizable properties such as title, message, colors, icons,
/// and auto-close duration.
///
/// The [ProKitSnackBar] can either be of type [ColoredSnackBar] or
/// [BorderedSnackBar], determined by the [snackBarType] parameter.
/// It also provides options for positioning, auto-closing, and custom
/// icons through its parameters.
///
/// The [ProKitNotificationType] specifies the type of notification
/// (success, error, warning, etc.), each with its own color and icon.
/// Users can override the default colors or icons by providing their
/// own values.
///
/// Example usage:
/// ```dart
/// ProKitSnackBar(
///   title: 'Success',
///   message: 'Your action was successful!',
///   snackBarType: ProKitSnackBarType.colored,
///   notificationType: ProKitNotificationType.success,
///   autoClose: true,
///   autoCloseDuration: Duration(seconds: 3),
/// ).showCustomSnackBar(context);
/// ```
///
/// The [inMaterialBanner] option can be used to decide whether to display
/// the SnackBar as a MaterialBanner.
///
/// [ProKitSnackBarPosition] can be used to set the SnackBar's position on
/// the screen (e.g., bottom center, top left, etc.).
///
/// See also:
///  - [ColoredSnackBar]: A colorful SnackBar with optional animations.
///  - [BorderedSnackBar]: A bordered SnackBar with a clean look.
class ProKitSnackBar extends StatelessWidget {
  /// The title text displayed in the SnackBar.
  final String title;

  /// The main message text displayed in the SnackBar.
  final String message;

  /// Optional background color for the SnackBar.
  final Color? color;

  /// Determines the type of the SnackBar, either colored or bordered.
  final ProKitSnackBarType snackBarType;

  /// Specifies the notification type (e.g., success, error, warning) that
  /// controls the default color and icon.
  final ProKitNotificationType notificationType;

  /// Determines whether the SnackBar should be shown as a MaterialBanner.
  final bool inMaterialBanner;

  /// Custom text style for the title.
  final TextStyle? titleTextStyle;

  /// Custom text style for the message.
  final TextStyle? messageTextStyle;

  /// Defines the position of the SnackBar on the screen.
  final ProKitSnackBarPosition? proKitSnackBarPosition;

  /// Whether the SnackBar should auto-close after a duration.
  final bool autoClose;

  /// Duration after which the SnackBar will automatically close.
  final Duration autoCloseDuration;

  /// Optional custom width for the SnackBar.
  final double? width;

  /// Optional custom height for the SnackBar.
  final double? height;

  /// Custom icon widget displayed in the SnackBar.
  final Widget? customIcon;

  /// Creates a customizable [ProKitSnackBar] widget.
  ///
  /// The [title], [message], [snackBarType], and [notificationType] are
  /// required parameters, while all others are optional.
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
    this.autoCloseDuration = const Duration(milliseconds: 4000),
    this.width,
    this.height,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    /// Returns the corresponding SnackBar type widget (either Colored or Bordered).
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

  /// Helper function to get the alignment of the SnackBar based on the
  /// [ProKitSnackBarPosition] value.
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

  /// Displays the custom SnackBar in a dialog at the specified position.
  ///
  /// This function creates a dialog that displays the SnackBar based on
  /// the given [ProKitSnackBarPosition] and the provided parameters.
  void showCustomSnackBar(BuildContext context, ProKitSnackBar snackBar) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        /// Retrieves the alignment for the SnackBar's position.
        final Alignment alignment = snackBar._getAlignmentForPosition(
          snackBar.proKitSnackBarPosition ??
              ProKitSnackBarPosition.bottomCenter,
        );

        /// Adjusts the padding based on the position.
        EdgeInsets padding;
        if (alignment == Alignment.topCenter ||
            alignment == Alignment.topLeft ||
            alignment == Alignment.topRight) {
          padding = EdgeInsets.only(
              top: 15,
              left: alignment == Alignment.topLeft ? 10 : 0,
              right: alignment == Alignment.topRight ? 10 : 0);
        } else if (alignment == Alignment.bottomCenter ||
            alignment == Alignment.bottomLeft ||
            alignment == Alignment.bottomRight) {
          padding = EdgeInsets.only(
              bottom: 15,
              left: alignment == Alignment.bottomLeft ? 10 : 0,
              right: alignment == Alignment.bottomRight ? 10 : 0);
        } else if (alignment == Alignment.centerLeft) {
          padding = const EdgeInsets.only(left: 15);
        } else if (alignment == Alignment.centerRight) {
          padding = const EdgeInsets.only(right: 15);
        } else {
          padding =
              const EdgeInsets.all(15); // Default padding for center alignment
        }

        /// Displays the SnackBar as a dialog with proper alignment and padding.
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
  }
}
