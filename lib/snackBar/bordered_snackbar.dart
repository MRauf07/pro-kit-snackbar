import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

class BorderedSnackBar extends StatefulWidget {
  final String title;
  final String message;
  final Color? color;
  final ProKitNotificationType notificationType;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;
  final ProKitSnackBarType snackBarType;
  final double? width;
  final double? height;
  final bool autoClose;
  final Duration autoCloseDuration;
  final Widget? customIcon;

  const BorderedSnackBar({
    super.key,
    required this.title,
    required this.message,
    required this.notificationType,
    this.color,
    this.titleTextStyle,
    this.messageTextStyle,
    required this.snackBarType,
    this.width,
    this.height,
    this.customIcon,
    this.autoClose = true,
    this.autoCloseDuration = const Duration(seconds: 4),
  });

  @override
  _BorderedSnackBarState createState() => _BorderedSnackBarState();
}

class _BorderedSnackBarState extends State<BorderedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    autoCloseSnackBar();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  autoCloseSnackBar() {
    /// Start the timer for auto-close if autoClose is enabled
    if (widget.autoClose) {
      Future.delayed(widget.autoCloseDuration).then((value) {
        if (!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();

          /// Auto close the dialog
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width <= 768;
    final hsl =
        HSLColor.fromColor(widget.color ?? widget.notificationType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              width: widget.width ?? size.width * (isMobile ? 0.85 : 0.5),
              height: widget.height ?? size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: widget.snackBarType == ProKitSnackBarType.bordered
                    ? Border.all(
                        color: widget.color ?? widget.notificationType.color!,
                        width: 2)
                    : null,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                      // Increased blur intensity for a smoother look
                      child: Container(
                        decoration: BoxDecoration(
                          color: (widget.color ??
                                  widget.notificationType.color!)
                              .withOpacity(
                                  0.15), // Set a semi-transparent background
                        ),
                        child: Transform.translate(
                          offset: const Offset(-1, 0),
                          child: Container(
                            width: 5,
                            decoration: BoxDecoration(
                              color: (widget.color ??
                                  widget.notificationType
                                      .color!), // Use a more translucent color
                            ),
                          ),
                        ),
                      ),
                    ),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Icon or customIcon
                          Center(
                            child: widget.customIcon ??
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(left: 12),
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
                                  child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Lottie.asset(
                                          widget.notificationType.anim!)),
                                ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: widget.titleTextStyle ??
                                      TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: widget.notificationType.color,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Expanded(
                                  child: Text(
                                    widget.message,
                                    maxLines: 2,
                                    style: widget.messageTextStyle ??
                                        TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: widget.notificationType.color,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                onPressed: () {
                  _controller.reverse().then((_) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                icon: Icon(Icons.close,
                    color: widget.notificationType.color,
                    size: size.height * 0.025),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(ProKitNotificationType type) {
    switch (type) {
      case ProKitNotificationType.failure:
        return Icons.error;
      case ProKitNotificationType.success:
        return Icons.check_circle;
      case ProKitNotificationType.warning:
        return Icons.warning_amber_sharp;
      case ProKitNotificationType.help:
        return Icons.info;
      default:
        return Icons.error;
    }
  }
}
