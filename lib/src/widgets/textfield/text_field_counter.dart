import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class TextFieldCounter extends StatefulWidget {
  final String? labelText;

  // final TextEditingController? textEditingController;
  // final VoidCallback onAddPressed;
  // final VoidCallback onSubtractPressed;
  final int? value;

  const TextFieldCounter({
    Key? key,
    this.labelText,
    this.value,
    // this.textEditingController,
    // required this.onAddPressed,
    // required this.onSubtractPressed,
  }) : super(key: key);

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
    /* Color increaseButtonColor;
    Color decreaseButtonColor;
    widget.minValue
        ? decreaseButtonColor = HelperColors.black9
        : decreaseButtonColor = HelperColors.orange;
    widget.maxValue
        ? increaseButtonColor = HelperColors.black9
        : increaseButtonColor = HelperColors.orange;*/
    return OutlineTextField(
      readOnly: true,
      textEditingController: _controller,
      labelText: widget.labelText,
      labelColor: HelperColors.black5,
      borderColor: HelperColors.black8,
      enableBorderColor: HelperColors.black8,
      focusedBorderColor: HelperColors.black8,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton.icon(
            // borderColor: decreaseButtonColor,
            height: 24.0,
            width: 24.0,
            onPressed: () {
              setState(() {
                if (_counter > 1) _counter--;
                _controller.text = _counter.toString();
              });
            },
            icon: Icon(
              Icons.remove_rounded,
              size: 20.0,
              // color: decreaseButtonColor,
            ),
          ),
          SizedBox(width: 12.0),
          OutlinedButton.icon(
            // borderColor: increaseButtonColor,
            height: 24.0,
            width: 24.0,
            onPressed: () {
              setState(() {
                _counter++;
                _controller.text = _counter.toString();
              });
            },
            icon: Icon(
              Icons.add_rounded,
              size: 20.0,
              // color: increaseButtonColor,
            ),
          ),
          SizedBox(width: 12.0),
        ],
      ),
    );
  }
}
