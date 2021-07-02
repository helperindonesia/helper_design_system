import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_design/helper_design.dart';

class OutlineTextField extends StatefulWidget {
  final String? title;
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
  final TextEditingController? textEditingController;
  final bool? readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final Widget? trailing;

  const OutlineTextField(
      {Key? key,
      this.title,
      this.isMultiLine = true,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.enabled,
      this.initialValue,
      @required this.labelText,
      this.hintText,
      this.textAlign,
      this.validator,
      this.inputFormatters,
      this.fillColor,
      this.borderRadius = 0,
      this.textEditingController,
      this.readOnly,
      this.onTap,
      this.onChanged,
      this.onSaved,
      this.trailing})
      : super(key: key);

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
        style: HelperThemeData.textTheme.bodyText1,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          contentPadding: EdgeInsets.fromLTRB(16.0, 13, 13, 0),
          hintText: widget.hintText,
          hintStyle: HelperThemeData.textTheme.bodyText2
              ?.copyWith(color: HelperColors.black7),
          labelText: widget.labelText,
          labelStyle: HelperThemeData.textTheme.bodyText2?.copyWith(
              height: 1, fontSize: _labelFontSize, color: _labelColor),
          border: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: HelperColors.black8),
          ),
          enabledBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: HelperColors.black8),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 4,
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: HelperColors.orange),
          ),
          suffixIcon: widget.trailing,
        ),
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textAlign: widget.textAlign ?? TextAlign.left,
        maxLines: widget.isMultiLine ? null : 1,
        minLines: 1,
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