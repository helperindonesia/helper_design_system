import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_design/helper_design.dart';

class TextFieldWithContent extends StatelessWidget {
  final bool isMultiLine;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool? enabled;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final TextAlign textAlign;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color fillColor;
  final double borderRadius;
  final TextEditingController? textEditingController;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final Widget? trailing;
  final Widget? child;
  final TextStyle? errorStyle;

  const TextFieldWithContent({
    Key? key,
    this.isMultiLine = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled,
    this.initialValue,
    required this.labelText,
    this.hintText,
    this.textAlign = TextAlign.left,
    this.validator,
    this.inputFormatters,
    this.fillColor = HelperColors.white,
    this.borderRadius = 12,
    this.textEditingController,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onSaved,
    this.trailing,
    this.child,
    this.errorStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 0.75, color: HelperColors.black10),
      ),
      child: Column(
        children: [
          OutlineTextField(
            labelText: labelText,
            isMultiLine: isMultiLine,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            enabled: enabled,
            initialValue: initialValue,
            hintText: hintText,
            textAlign: textAlign,
            validator: validator,
            inputFormatters: inputFormatters,
            fillColor: fillColor,
            borderRadius: borderRadius,
            textEditingController: textEditingController,
            readOnly: readOnly,
            onTap: onTap,
            onChanged: onChanged,
            onSaved: onSaved,
            trailing: trailing,
            errorStyle: errorStyle,
          ),
          child ?? SizedBox(),
        ],
      ),
    );
  }
}
