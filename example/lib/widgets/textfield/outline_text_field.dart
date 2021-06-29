import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class OutlineTextField extends StatefulWidget {
  final String? title;
  final bool isMultiLine;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final String? initialValue;
  final String? labelText;
  final TextAlign? textAlign;
  final FormFieldValidator? validator;
  // final List<TextInputFormatter> inputFormatters;
  final Color? fillColor;
  final double? borderRadius;
  final TextEditingController? textEditingController;
  final bool? readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
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
      this.textAlign,
      this.validator,
      this.fillColor,
      this.borderRadius = 0,
      this.textEditingController,
      this.readOnly,
      this.onTap,
      this.onChanged,
      this.trailing})
      : super(key: key);

  @override
  _OutlineTextFieldState createState() => _OutlineTextFieldState();
}

class _OutlineTextFieldState extends State<OutlineTextField> {
  Color? _labelColor;
  double? _labelFontSize;

  void validateFont(String? value, bool hasFocus) {
    if (value == null && !hasFocus || value == '' && !hasFocus) {
      _labelFontSize = 16;
      _labelColor = HelperColors.black7;
    } else if(!hasFocus){
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
        style: TextStyle(
            color: HelperColors.black,
            fontFamily: 'packages/helper_design/Nunito',
            fontStyle: FontStyle.normal,
            fontSize: 16.0,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          contentPadding: EdgeInsets.fromLTRB(16.0, 13, 13, 0),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontFamily: 'packages/helper_design/Nunito',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: _labelFontSize,
              height: 1,
              color: _labelColor),
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
      ),
    );
  }
}
