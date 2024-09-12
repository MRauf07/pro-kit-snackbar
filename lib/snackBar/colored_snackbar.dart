import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

class ColoredSnackBar extends StatefulWidget {
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
    this.autoCloseDuration = const Duration(seconds: 5),
    this.width,
    this.height,
    this.customIcon,
  });

  @override
  _ColoredSnackBarState createState() => _ColoredSnackBarState();
}

class _ColoredSnackBarState extends State<ColoredSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
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

    /// Auto-close the snackbar if enabled
    if (widget.autoClose) {
      Future.delayed(widget.autoCloseDuration).then((value) {
        if(!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width <= 768;
    final hsl = HSLColor.fromColor(widget.color ?? widget.notificationType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              width: widget.width ?? size.width * (isMobile ? 0.85 : 0.5),
              height: widget.height ?? size.height * 0.1,
              decoration: BoxDecoration(
                color: widget.color ?? widget.notificationType.color,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: widget.customIcon ??
                          SizedBox(
                              width: 50,
                              height: 50,
                              child: Lottie.asset(widget.notificationType.anim!)),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title
                          Text(
                            widget.title,
                            style: widget.titleTextStyle ??
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
                            widget.message,
                            style: widget.messageTextStyle ??
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
                  _controller.reverse().then((_) {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  });
                },
                icon: Icon(Icons.close,
                    color: Colors.white, size: size.height * 0.025),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
