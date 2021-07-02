import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helper_design/helper_design.dart';

class TextFieldJoinExpansionView extends StatefulWidget {
  final bool? isMultiLine;
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

  const TextFieldJoinExpansionView(
      {Key? key,
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
      this.expansionChildren = const [],
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
      this.expansionTitlePadding})
      : super(key: key);

  @override
  _TextFieldJoinExpansionViewState createState() =>
      _TextFieldJoinExpansionViewState();
}

class _TextFieldJoinExpansionViewState
    extends State<TextFieldJoinExpansionView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 0.75, color: HelperColors.black10)),
      child: Column(
        children: [
          OutlineTextField(
            labelText: 'Apa kebutuhanmu?',
            isMultiLine: widget.isMultiLine ?? true,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            enabled: widget.enabled,
            initialValue: widget.initialValue,
            hintText: widget.hintText,
            textAlign: widget.textAlign,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            fillColor: widget.fillColor,
            borderRadius: widget.borderRadius,
            textEditingController: widget.textEditingController,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            trailing: widget.trailing,
          ),
          Card(
            elevation: 0,
            child: ExpansionView(
              title: widget.expansionTitle,
              onExpansionChanged: widget.onExpansionChanged,
              children: widget.expansionChildren,
              backgroundColor: widget.expansionBackgroundColor,
              collapsedBackgroundColor:
                  widget.expansionCollapsedBackgroundColor,
              trailing: widget.expansionTrailing,
              initiallyExpanded: widget.initiallyExpanded,
              maintainState: widget.expansionMaintainState,
              expandedAlignment: widget.expandedAlignment,
              expandedCrossAxisAlignment: widget.expandedCrossAxisAlignment,
              childrenPadding: widget.expansionChildrenPadding,
              iconColor: widget.expansionIconColor,
              titleStyle: widget.expansionTitleStyle,
              titlePadding: widget.expansionTitlePadding,
              iconSize: widget.expansionIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
