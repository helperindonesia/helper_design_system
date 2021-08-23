import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class TextFieldCounter extends StatefulWidget {
  const TextFieldCounter({
    Key? key,
    this.labelText,
    this.value,
    this.onSaved,
  }) : super(key: key);

  final int? value;

  final String? labelText;

  final FormFieldSetter<String>? onSaved;

  @override
  _TextFieldCounterState createState() => _TextFieldCounterState();
}

class _TextFieldCounterState extends State<TextFieldCounter> {
  int _counter = 1;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text =
        widget.value != null ? widget.value.toString() : _counter.toString();
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
            borderColor:
                _counter > 1 ? HelperColors.orange : HelperColors.black9,
            onPressed: () {
              setState(() {
                if (_counter > 1) _counter--;
                _controller.text = _counter.toString();
              });
            },
            icon: Icon(
              HelperIcons.mines,
              size: 20.0,
              color: _counter > 1 ? HelperColors.orange : HelperColors.black9,
            ),
          ),
          SizedBox(width: 8),
          HOutlinedButton.icon(
            onPressed: () {
              setState(() {
                _counter++;
                _controller.text = _counter.toString();
              });
            },
            icon: Icon(
              HelperIcons.plus,
              size: 20.0,
            ),
          ),
          SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
