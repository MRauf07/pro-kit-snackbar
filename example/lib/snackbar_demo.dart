import 'package:flutter/material.dart';
import 'package:pro_kit_snackbar/snackBar/snack_bar.dart';
import 'package:pro_kit_snackbar/snackBar/snackbar_enum.dart';

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProKit SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ProKit SnackBar Grid Example'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              // 3 columns for larger screens, 2 for smaller
              childAspectRatio:
                  MediaQuery.of(context).size.width > 600 ? 4 : 2.5,
              // Adjusts ratio for better text visibility
              crossAxisSpacing: 8.0,
              // Spacing between columns
              mainAxisSpacing: 8.0,
              // Spacing between rows
              children: _buildSnackBarGridItems(context),
            )),
      ),
    );
  }

  /// Builds the list of Grid Items for displaying SnackBars
  List<Widget> _buildSnackBarGridItems(BuildContext context) {
    return [
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Success SnackBar",
        onPressed: () => _showSuccessSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Error SnackBar",
        onPressed: () => _showErrorSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Warning SnackBar",
        onPressed: () => _showWarningSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Help SnackBar",
        onPressed: () => _showHelpSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Custom Size SnackBar",
        onPressed: () => _showCustomSizeSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Bordered Centered SnackBar",
        onPressed: () => _showCenteredSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Colored Success SnackBar",
        onPressed: () => _showColoredSuccessSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Colored Error SnackBar",
        onPressed: () => _showColoredErrorSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Colored Warning SnackBar",
        onPressed: () => _showColoredWarningSnackBar(context),
      ),
      _gridSnackBarItem(
        context: context,
        label: "Show Colored Help SnackBar",
        onPressed: () => _showColoredHelpSnackBar(context),
      ),
    ];
  }

  /// Helper method to create a Grid item for each SnackBar
  Widget _gridSnackBarItem({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50], // Background color
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          border: Border.all(color: Colors.blueAccent), // Border style
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  /// Displays a bordered success SnackBar
  void _showSuccessSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Success",
      message: "Operation completed successfully.",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.success,
    );
  }

  /// Displays a bordered error SnackBar
  void _showErrorSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Error",
      message: "Something went wrong.",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.failure,
      snackBarPosition: ProKitSnackBarPosition.topRight,
    );
  }

  /// Displays a bordered warning SnackBar
  void _showWarningSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Warning",
      message: "This is a warning message.",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.warning,
      color: Colors.deepOrange,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  /// Displays a bordered help SnackBar
  void _showHelpSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Help",
      message: "Need help with something?",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.help,
      customIcon: const Icon(Icons.help_outline, color: Colors.white),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      messageTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
    );
  }

  /// Displays a bordered custom size SnackBar
  void _showCustomSizeSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Custom Size",
      message: "This SnackBar has a custom width and height.",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.success,
      width: 300,
      height: 100,
    );
  }

  /// Displays a bordered centered SnackBar
  void _showCenteredSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Centered SnackBar",
      message: "This SnackBar is displayed in the center of the screen.",
      snackBarType: ProKitSnackBarType.bordered,
      notificationType: ProKitNotificationType.help,
      autoClose: false,
      snackBarPosition: ProKitSnackBarPosition.center,
    );
  }

  /// Displays a colored success SnackBar
  void _showColoredSuccessSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Success",
      message: "Operation completed successfully.",
      snackBarType: ProKitSnackBarType.colored,
      notificationType: ProKitNotificationType.success,
    );
  }

  /// Displays a colored error SnackBar
  void _showColoredErrorSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Error",
      message: "Something went wrong.",
      snackBarType: ProKitSnackBarType.colored,
      notificationType: ProKitNotificationType.failure,
      snackBarPosition: ProKitSnackBarPosition.topRight,
    );
  }

  /// Displays a colored warning SnackBar
  void _showColoredWarningSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Warning",
      message: "This is a warning message.",
      snackBarType: ProKitSnackBarType.colored,
      notificationType: ProKitNotificationType.warning,
      color: Colors.deepOrange,
      autoCloseDuration: const Duration(seconds: 5),
    );
  }

  /// Displays a colored help SnackBar
  void _showColoredHelpSnackBar(BuildContext context) {
    showProKitSnackBar(
      context,
      title: "Help",
      message: "Need help with something?",
      snackBarType: ProKitSnackBarType.colored,
      notificationType: ProKitNotificationType.help,
      customIcon: const Icon(Icons.help_outline, color: Colors.white),
      titleTextStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      messageTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
    );
  }
}
