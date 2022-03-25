import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class TextFieldCounterWithExpansionView extends StatefulWidget {
  const TextFieldCounterWithExpansionView({
    Key? key,
    this.value,
    this.valueText = '',
    this.labelText,
    this.onSaved,
    required this.expansionTitle,
    this.onExpansionChanged,
    this.expansionChildren = const <Widget>[],
    this.expansionBackgroundColor,
    this.expansionCollapsedBackgroundColor,
    this.expansionTrailing,
    this.initiallyExpanded = false,
    this.expansionMaintainState = false,
    this.expansionIconColor,
    this.expansionIconSize,
    this.expansionTitleStyle,
    this.expansionTitlePadding,
  }) : super(key: key);

  final int? value;
  final String valueText;
  final String? labelText;
  final FormFieldSetter<String>? onSaved;
  final String expansionTitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> expansionChildren;
  final Color? expansionBackgroundColor;
  final Color? expansionCollapsedBackgroundColor;
  final Widget? expansionTrailing;
  final bool initiallyExpanded;
  final bool expansionMaintainState;
  final Color? expansionIconColor;
  final double? expansionIconSize;
  final TextStyle? expansionTitleStyle;
  final EdgeInsetsGeometry? expansionTitlePadding;

  @override
  _TextFieldCounterWithExpansionViewState createState() =>
      _TextFieldCounterWithExpansionViewState();
}

class _TextFieldCounterWithExpansionViewState
    extends State<TextFieldCounterWithExpansionView> {
  int _counter = 1;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value != null
        ? widget.value.toString() + widget.valueText
        : _counter.toString() + widget.valueText;
    _counter = widget.value ?? 1;
  }

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
            readOnly: true,
            textEditingController: _controller,
            labelText: widget.labelText,
            labelColor: HelperColors.black5,
            borderColor: HelperColors.black8,
            enableBorderColor: HelperColors.black8,
            focusedBorderColor: HelperColors.black8,
            onSaved: widget.onSaved,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HOutlinedButton.icon(
                  onPressed: _counter == 1
                      ? null
                      : () {
                          setState(() {
                            if (_counter > 1) _counter--;
                            _controller.text =
                                _counter.toString() + widget.valueText;
                          });
                        },
                  icon: Icon(HelperIcons.ic_indeterminate, size: 20.0),
                ),
                SizedBox(width: 8),
                HOutlinedButton.icon(
                  onPressed: _counter >= 10
                      ? null
                      : () {
                          setState(() {
                            _counter++;
                            _controller.text =
                                _counter.toString() + widget.valueText;
                          });
                        },
                  icon: Icon(HelperIcons.ic_add, size: 20.0),
                ),
                SizedBox(width: 12.0),
              ],
            ),
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
