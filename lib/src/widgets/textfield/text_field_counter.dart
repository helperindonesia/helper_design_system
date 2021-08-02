import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class TextFieldCounter extends StatelessWidget {
  final String? labelText;
  final TextEditingController? textEditingController;
  final VoidCallback increasePress;
  final VoidCallback decreasePress;
  final bool minValue;
  final bool maxValue;

  const TextFieldCounter({
    Key? key,
    this.labelText,
    this.textEditingController,
    required this.increasePress,
    required this.decreasePress,
    required this.minValue,
    required this.maxValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color increaseButtonColor;
    Color decreaseButtonColor;
    minValue
        ? decreaseButtonColor = HelperColors.black9
        : decreaseButtonColor = HelperColors.orange;
    maxValue
        ? increaseButtonColor = HelperColors.black9
        : increaseButtonColor = HelperColors.orange;
    return OutlineTextField(
      readOnly: true,
      textEditingController: textEditingController,
      labelText: labelText,
      labelColor: HelperColors.black5,
      borderColor: HelperColors.black8,
      enableBorderColor: HelperColors.black8,
      focusedBorderColor: HelperColors.black8,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            borderColor: decreaseButtonColor,
            height: 24.0,
            width: 24.0,
            onPressed: decreasePress,
            icon: Icon(
              Icons.remove_rounded,
              size: 20.0,
              color: decreaseButtonColor,
            ),
          ),
          SizedBox(width: 12.0),
          OutlinedButton.icon(
            borderColor: increaseButtonColor,
            height: 24.0,
            width: 24.0,
            onPressed: increasePress,
            icon: Icon(
              Icons.add_rounded,
              size: 20.0,
              color: increaseButtonColor,
            ),
          ),
          SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
