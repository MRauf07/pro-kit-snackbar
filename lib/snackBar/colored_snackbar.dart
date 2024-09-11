import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

class ColoredSnackBar extends StatelessWidget {
  final String title;
  final String message;
  final Color? color;
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

  const ColoredSnackBar({
    super.key,
    this.color,
    this.titleTextStyle,
    this.messageTextStyle,
    required this.title,
    required this.message,
    required this.notificationType,
    this.inMaterialBanner = false,
    this.proKitSnackBarPosition,
    this.autoClose = true,
    this.autoCloseDuration = const Duration(seconds: 3),
    this.width,
    this.height,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width <= 768;

    final hsl = HSLColor.fromColor(color ?? notificationType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          width: width ?? size.width * (isMobile ? 0.85 : 0.5),
          height: height ?? size.height * 0.1,
          decoration: BoxDecoration(
            color: color ?? notificationType.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Proper alignment
              children: [
                /// Icon or customIcon
                Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: hslDark.toColor(),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: customIcon ??
                      /*Icon(
                        _getNotificationIcon(notificationType),
                        color: Colors.white,
                        size: size.height * 0.04,
                      ),*/
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Lottie.asset(notificationType.anim!)),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        title,
                        style: titleTextStyle ??
                            TextStyle(
                              fontSize: !isMobile
                                  ? size.height * 0.03
                                  : size.height * 0.025,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 4),

                      /// Message
                      Text(
                        message,
                        style: messageTextStyle ??
                            TextStyle(
                              fontSize: size.height * 0.016,
                              color: Colors.white,
                            ),
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: IconButton(
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.close,
                color: Colors.white, size: size.height * 0.025),
          ),
        ),
      ],
    );
  }
/*
  IconData _getNotificationIcon(ProKitNotificationType type) {
    switch (type) {
      case ProKitNotificationType.failure:
        return Icons.error;
      case ProKitNotificationType.success:
        return Icons.check_circle;
      case ProKitNotificationType.warning:
        return Icons.warning;
      case ProKitNotificationType.help:
        return Icons.info;
      default:
        return Icons.error;
    }
  }*/
}
