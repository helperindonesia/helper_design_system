import 'package:flutter/material.dart';

import '../../../helper_design.dart';

class ChatBoxContainer extends StatelessWidget {
  final VoidCallback? onSendTap;
  final VoidCallback? onPrefixIconTap;
  final TextEditingController? textEditingController;
  final String? hintText;

  const ChatBoxContainer({
    Key? key,
    required this.onSendTap,
    this.textEditingController,
    this.onPrefixIconTap, this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: HelperColors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlineTextField(
              enableBorderColor: HelperColors.black10,
              prefixIcon: InkWell(
                onTap: onPrefixIconTap,
                child: Icon(Icons.sentiment_satisfied_alt,
                    color: HelperColors.black8),),
              hintText: hintText ?? 'Ketik Pesan',
              borderRadius: 24.0,
              textEditingController: textEditingController,
            ),
          ),
          SizedBox(width: 12.0),
          BaseButton(
            elevation: 0,
            height: 48.0,
            width: 48.0,
            onPressed: onSendTap,
            child:
            Icon(Icons.send_rounded, color: HelperColors.white, size: 20.0),
          )
        ],
      ),
    );
  }
}
