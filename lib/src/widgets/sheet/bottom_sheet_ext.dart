import 'package:flutter/material.dart';

extension BottomSheetX on BuildContext {
  Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool isDismissible: true,
    bool enableDrag: false,
    Color backgroundColor = Colors.transparent,
  }) {
    return showModalBottomSheet<T?>(
      context: this,
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      isDismissible: isDismissible,
      builder: (context) => child,
    );
  }
}
