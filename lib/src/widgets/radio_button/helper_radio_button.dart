import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperRadioButton<T> extends StatelessWidget {
  final String text;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final double? borderRadius;
  final IconData? iconData;
  final bool withIcon;
  final bool withBorder;
  final EdgeInsetsGeometry? edgeInsetsGeometry;

  const HelperRadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      this.borderRadius,
      this.withIcon = false,
      this.iconData,
      required this.text,
      this.withBorder = false,
      this.edgeInsetsGeometry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        padding: edgeInsetsGeometry ??
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
            border: withBorder
                ? Border.all(
                    color:
                        isSelected ? HelperColors.orange : HelperColors.black10,
                    width: 1.0)
                : Border.all(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(borderRadius ?? 12.0)),
        child: Row(
          children: [
            withIcon
                ? Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? HelperColors.orange10
                                : HelperColors.black10,
                          ),
                          child: Icon(
                            iconData ?? Icons.watch_later_rounded,
                            color: isSelected
                                ? HelperColors.orange
                                : HelperColors.black3,
                            size: 20.0,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        Text(text,
                            style: HelperThemeData.textTheme.buttonText1),
                      ],
                    ),
                  )
                : SizedBox(),
            _customRadioButton,
            !withIcon
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:
                        Text(text, style: HelperThemeData.textTheme.bodyText1),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: isSelected ? HelperColors.orange : null,
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.0,
          color: isSelected ? HelperColors.orange : HelperColors.black9,
        ),
      ),
      child: isSelected
          ? Icon(
              Icons.check_rounded,
              size: 20.0,
              color: HelperColors.white,
            )
          : SizedBox(),
    );
  }
}
