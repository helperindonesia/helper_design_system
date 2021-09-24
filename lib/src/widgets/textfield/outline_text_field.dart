import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_design/helper_design.dart';

class OutlineTextField extends StatefulWidget {
  final bool isMultiLine;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final TextAlign? textAlign;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final double? borderRadius;
  final Color? borderColor;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final TextEditingController? textEditingController;
  final bool? readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final Widget? trailing;
  final Widget? prefixIcon;
  final bool? autoFocus;
  final Color? labelColor;
  final int? hintMaxLines;
  final int? minLines;
  final String? prefixText;

  const OutlineTextField({
    Key? key,
    this.isMultiLine = true,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.enabled,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.textAlign,
    this.validator,
    this.inputFormatters,
    this.fillColor,
    this.borderRadius,
    this.textEditingController,
    this.readOnly,
    this.onTap,
    this.onChanged,
    this.onSaved,
    this.trailing,
    this.prefixIcon,
    this.borderColor,
    this.enableBorderColor,
    this.focusedBorderColor,
    this.autoFocus,
    this.labelColor,
    this.hintMaxLines,
    this.minLines,
    this.prefixText,
  }) : super(key: key);

  @override
  _OutlineTextFieldState createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
  late Color? _labelColor;
  late double? _labelFontSize;

  @override
  void initState() {
    super.initState();
    _labelColor = HelperColors.black7;
    _labelFontSize = 16;
  }

  void validateFont(String? value, bool hasFocus) {
    if (value == null && !hasFocus || value == '' && !hasFocus) {
      _labelFontSize = 16;
      _labelColor = HelperColors.black7;
    } else if (!hasFocus) {
      _labelFontSize = 12;
      _labelColor = HelperColors.black5;
    } else {
      _labelFontSize = 12;
      _labelColor = HelperColors.orange3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          validateFont(widget.textEditingController?.text, hasFocus);
        });
      },
      child: TextFormField(
        autofocus: widget.autoFocus ?? false,
        style: HelperThemeData.textTheme.bodyText1,
        decoration: InputDecoration(
          prefixText: widget.prefixText,
          prefixStyle: HelperThemeData.textTheme.bodyText1,
          hintMaxLines: widget.hintMaxLines,
          prefixIcon: widget.prefixIcon ?? null,
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          contentPadding: EdgeInsets.fromLTRB(16.0, 13, 13, 0),
          hintText: widget.hintText,
          hintStyle: HelperThemeData.textTheme.bodyText2
              ?.copyWith(color: HelperColors.black7),
          labelText: widget.labelText,
          labelStyle: HelperThemeData.textTheme.bodyText2?.copyWith(
              height: 1,
              fontSize: _labelFontSize,
              color: widget.labelColor ?? _labelColor),
          border: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
            borderSide: BorderSide(
                width: 1, color: widget.borderColor ?? HelperColors.black8),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
            borderSide: BorderSide(
                width: 1,
                color: widget.enableBorderColor ?? HelperColors.black8),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.0),
            borderSide: BorderSide(
                width: 1,
                color: widget.focusedBorderColor ?? HelperColors.orange),
          ),
          suffixIcon: widget.trailing,
        ),
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.isMultiLine ? null : 1,
        minLines: widget.minLines,
        validator: widget.validator,
        controller: widget.textEditingController,
        readOnly: widget.readOnly ?? false,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
