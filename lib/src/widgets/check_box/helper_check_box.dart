import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperCheckBox extends StatelessWidget {
  final String? text;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final double? radius;
  final double? height;
  final double? width;

  const HelperCheckBox(
      {Key? key,
      required this.onChanged,
      this.value = true,
      this.text,
      this.radius, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CardContainer.horizontal(
        mainAxisAlignment: MainAxisAlignment.start,
        height: height,
        width: width,
        radius: radius ?? 12.0,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        borderColor: value ? HelperColors.orange : HelperColors.black10,
        children: [
          SizedBox(width: 12.0),
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: Checkbox(
              value: value,
              onChanged: onChanged,
              shape: CircleBorder(),
              activeColor: HelperColors.orange,
              side: BorderSide(width: 1.0, color: HelperColors.black9),
            ),
          ),
          SizedBox(width: 8.0),
          Text(
            text ?? '',
            style: HelperThemeData.textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}
