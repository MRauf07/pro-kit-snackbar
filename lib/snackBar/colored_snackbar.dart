import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

/// A customizable, animated colored snackbar with an optional icon and auto-close feature.
///
/// The `ColoredSnackBar` widget provides a snackbar that can be customized with
/// a title, message, icon, and color. It supports animations for showing and
/// hiding the snackbar, and can auto-close after a specified duration.
///
/// It can be placed either in a `MaterialBanner` or displayed directly as a
/// standalone snackbar. The `notificationType` parameter allows the inclusion
/// of a predefined animation and color theme based on the notification type.
///
/// ### Example:
/// ```dart
/// ColoredSnackBar(
///   title: 'Success',
///   message: 'Your operation was successful',
///   notificationType: ProKitNotificationType.success,
/// );
/// ```
///
/// You can further customize the snackbar by providing custom title/message text
/// styles, or a custom icon, width, height, etc.
class ColoredSnackBar extends StatefulWidget {
  /// The main title of the snackbar.
  ///
  /// This title is displayed in bold and larger font, and is placed
  /// at the top of the message area.
  final String title;

  /// The message to display below the title.
  ///
  /// This is the main content of the snackbar, displayed below the title.
  final String message;

  /// The background color of the snackbar.
  ///
  /// If not provided, it defaults to the color of the `notificationType`.
  final Color? color;

  /// The type of notification, which defines the default animation and color.
  ///
  /// For example, a success notification will include a success animation
  /// and a green color scheme by default.
  final ProKitNotificationType notificationType;

  /// Whether the snackbar should be placed inside a `MaterialBanner`.
  ///
  /// Defaults to `false`, meaning the snackbar will be displayed as a
  /// standalone widget.
  final bool inMaterialBanner;

  /// Custom text style for the title.
  ///
  /// If not provided, a default bold white text style will be used.
  final TextStyle? titleTextStyle;

  /// Custom text style for the message.
  ///
  /// If not provided, a smaller white text style will be used.
  final TextStyle? messageTextStyle;

  /// The position of the snackbar on the screen.
  ///
  /// If not provided, the snackbar will be shown at the bottom of the screen.
  final ProKitSnackBarPosition? proKitSnackBarPosition;

  /// Whether the snackbar should close automatically after a duration.
  ///
  /// Defaults to `true`. The `autoCloseDuration` specifies the delay before closing.
  final bool autoClose;

  /// The duration after which the snackbar will automatically close.
  ///
  /// Defaults to 5 seconds. Only applicable if `autoClose` is `true`.
  final Duration autoCloseDuration;

  /// The width of the snackbar.
  ///
  /// If not provided, the width will be responsive based on the screen size.
  final double? width;

  /// The height of the snackbar.
  ///
  /// If not provided, the height will be set to 10% of the screen's height.
  final double? height;

  /// Custom icon to display at the start of the snackbar.
  ///
  /// If not provided, a default Lottie animation will be used based on the
  /// `notificationType`.
  final Widget? customIcon;

  /// Creates a new `ColoredSnackBar`.
  ///
  /// Requires a [title], [message], and [notificationType] to display a basic
  /// snackbar. Optional parameters can be used for further customization.
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

/// The state for the `ColoredSnackBar` widget.
///
/// This state handles the animation and auto-close behavior of the snackbar.
class _ColoredSnackBarState extends State<ColoredSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initializes the animation controller for handling the fade and slide animations.
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

    // Starts the animation when the snackbar is displayed.
    _controller.forward();

    // Auto-closes the snackbar after the specified duration, if enabled.
    if (widget.autoClose) {
      Future.delayed(widget.autoCloseDuration).then((value) {
        if (!mounted) return;
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  void dispose() {
    // Disposes the animation controller when the snackbar is dismissed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width <= 768;
    final hsl = HSLColor.fromColor(widget.color ?? widget.notificationType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    // Builds the animated snackbar with the title, message, and icon.
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
                    // Displays either the custom icon or the default Lottie animation.
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

                    // Displays the title and message of the snackbar.
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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

            // Close button to dismiss the snackbar manually.
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
