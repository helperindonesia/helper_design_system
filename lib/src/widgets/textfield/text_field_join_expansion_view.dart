import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_design/helper_design.dart';

class TextFieldJoinExpansionView extends StatelessWidget {
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

  final String expansionTitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> expansionChildren;
  final Color? expansionBackgroundColor;
  final Color? expansionCollapsedBackgroundColor;
  final Widget? expansionTrailing;
  final bool initiallyExpanded;
  final bool expansionMaintainState;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? expansionChildrenPadding;
  final Color? expansionIconColor;
  final double? expansionIconSize;
  final TextStyle? expansionTitleStyle;
  final EdgeInsetsGeometry? expansionTitlePadding;

  const TextFieldJoinExpansionView({
    Key? key,
    this.isMultiLine = true,
    this.keyboardType,
    this.textInputAction,
    this.enabled,
    this.initialValue,
    required this.labelText,
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
    //Expansions
    required this.expansionTitle,
    this.onExpansionChanged,
    this.expansionChildren = const <Widget>[],
    this.expansionBackgroundColor,
    this.expansionCollapsedBackgroundColor,
    this.expansionTrailing,
    this.initiallyExpanded = false,
    this.expansionMaintainState = false,
    this.expandedAlignment,
    this.expandedCrossAxisAlignment,
    this.expansionChildrenPadding,
    this.expansionIconColor,
    this.expansionIconSize,
    this.expansionTitleStyle,
    this.expansionTitlePadding,
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
          ),
          Card(
            elevation: 0,
            child: ExpansionView(
              title: expansionTitle,
              onExpansionChanged: onExpansionChanged,
              children: expansionChildren,
              backgroundColor: expansionBackgroundColor,
              collapsedBackgroundColor: expansionCollapsedBackgroundColor,
              trailing: expansionTrailing,
              initiallyExpanded: initiallyExpanded,
              maintainState: expansionMaintainState,
              expandedAlignment: expandedAlignment,
              expandedCrossAxisAlignment: expandedCrossAxisAlignment,
              childrenPadding: expansionChildrenPadding,
              iconColor: expansionIconColor,
              titleStyle: expansionTitleStyle,
              titlePadding: expansionTitlePadding,
              iconSize: expansionIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
