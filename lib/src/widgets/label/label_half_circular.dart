import 'package:flutter/material.dart';

import '../../../helper_design.dart';

class LabelHalfCircular extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;

  const LabelHalfCircular({Key? key, this.text, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: backgroundColor ?? HelperColors.orange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(
        text ?? '',
        style: HelperThemeData.textTheme.caption!
            .copyWith(color: HelperColors.white),
      ),
    );
  }
}
