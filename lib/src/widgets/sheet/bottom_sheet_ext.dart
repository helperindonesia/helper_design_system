import 'package:flutter/material.dart';

extension BottomSheetX on BuildContext {
  Future<void> showBottomSheet({
    required Widget child,
    bool isScrollControlled = false,
    // EdgeInsetsGeometry? padding,
    bool isDismissible: true,
  }) {
    return showModalBottomSheet<void>(
      context: this,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      builder: (context) => child,
    );
  }
}
