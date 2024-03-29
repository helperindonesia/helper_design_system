import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class TextFieldCounter extends StatefulWidget {
  const TextFieldCounter({
    Key? key,
    this.labelText,
    this.value,
    this.valueText = '',
    this.onSaved,
    this.counting = 1,
    this.maxCount = 10,
  }) : super(key: key);

  final int? value;
  final String valueText;
  final String? labelText;
  final FormFieldSetter<String>? onSaved;
  final int counting;
  final int maxCount;

  @override
  _TextFieldCounterState createState() => _TextFieldCounterState();
}

class _TextFieldCounterState extends State<TextFieldCounter> {
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
    return OutlineTextField(
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
            onPressed: _counter == widget.counting
                ? null
                : () {
                    setState(() {
                      if (_counter > widget.counting)
                        _counter -= widget.counting;
                      _controller.text = _counter.toString() + widget.valueText;
                    });
                  },
            icon: Icon(HelperIcons.ic_indeterminate, size: 20.0),
          ),
          SizedBox(width: 8),
          HOutlinedButton.icon(
            onPressed: _counter == widget.maxCount
                ? null
                : () {
                    setState(() {
                      _counter += widget.counting;
                      _controller.text = _counter.toString() + widget.valueText;
                    });
                  },
            icon: Icon(HelperIcons.ic_add, size: 20.0),
          ),
          SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
