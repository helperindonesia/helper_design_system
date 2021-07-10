import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ModalBottomSheet extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;

  const ModalBottomSheet(
      {Key? key, this.backgroundColor, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: BaseButton(
              onPressed: () => Navigator.pop(context),
              backgroundColor: backgroundColor ?? HelperColors.white,
              height: 40.0,
              width: 40.0,
              child: Icon(
                Icons.close_rounded,
                size: 24.0,
                color: HelperColors.black3,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: backgroundColor ?? HelperColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0),
              ),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
