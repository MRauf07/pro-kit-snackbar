
# ProKitSnackBar

`ProKitSnackBar` is a highly customizable Flutter widget designed for displaying snack bars with advanced features. It offers extensive customization options, including positioning, auto-closing functionality, diverse notification types, and flexible design elements, making it suitable for both mobile and web platforms.

## Features

- **Customizable Positioning:** Control the SnackBar's position on the screen with options for top, center, or bottom placement.
- **Notification Types:** Display various types of notifications including success, error, warning, and information, each with distinct visual styles.
- **Auto-Close Functionality:** Set a duration for the SnackBar to automatically dismiss itself, or configure it to remain visible until manually closed.
- **Flexible Design:** Tailor the SnackBar’s appearance with customizable width, height, background colors, text styles, and icons.
- **Cross-Platform Support:** Ensures consistent performance and appearance on both mobile and web platforms.

## Properties

- **`position`**: `SnackBarPosition` - Defines the position of the SnackBar on the screen. Options include `top`, `center`, and `bottom`.
- **`type`**: `SnackBarType` - Specifies the notification type. Options include `success`, `error`, `warning`, and `info`.
- **`autoCloseDuration`**: `Duration` - Duration before the SnackBar automatically closes. Set to `null` for no auto-close.
- **`backgroundColor`**: `Color` - Custom background color for the SnackBar.
- **`textStyle`**: `TextStyle` - Style configuration for the SnackBar's text.
- **`icon`**: `Widget` - Custom icon displayed alongside the SnackBar message.
- **`width`**: `double` - Width of the SnackBar. Set to `double.infinity` for full width.
- **`height`**: `double` - Height of the SnackBar.
- **`action`**: `SnackBarAction` - Optional action button with a callback.

## Getting Started

To use `ProKitSnackBar` in your Flutter project, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  prokit_snackbar: ^latest_version
```

## Usage

Here’s a simple example of how to use `ProKitSnackBar`:

```dart
import 'package:flutter/material.dart';
import 'package:prokit_snackbar/prokit_snackbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('ProKitSnackBar Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              ProKitSnackBar.show(
                context,
                message: 'This is a success message!',
                type: SnackBarType.success,
                autoCloseDuration: Duration(seconds: 3),
              );
            },
            child: Text('Show SnackBar'),
          ),
        ),
      ),
    );
  }
}
```

## Screenshots

![Success SnackBar Example](screenshots/success.png)
![Error SnackBar Example](screenshots/error.png)

