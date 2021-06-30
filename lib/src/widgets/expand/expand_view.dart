import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ExpandView extends StatefulWidget {
  final String title;
  final List<Widget> child;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool? initialExpanded;
  final ValueChanged<bool>? onExpansionChanged;

  const ExpandView({
    Key? key,
    required this.title,
    this.child = const [],
    this.backgroundColor,
    this.textStyle,
    this.initialExpanded,
    this.onExpansionChanged,
  }) : super(key: key);

  @override
  _ExpandViewState createState() => _ExpandViewState();
}

class _ExpandViewState extends State<ExpandView> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        backgroundColor: widget.backgroundColor ?? HelperColors.white,
        onExpansionChanged: widget.onExpansionChanged,
        initiallyExpanded: widget.initialExpanded ?? false,
        iconColor: HelperColors.black5,
        tilePadding:
            EdgeInsets.only(left: 16.0, top: 0, bottom: 0, right: 12.0),
        childrenPadding: EdgeInsets.only(left: 16.0, bottom: 16.0, right: 12.0),
        title: Text(
          widget.title,
          style: widget.textStyle ??
              HelperThemeData.textTheme.caption
                  ?.copyWith(color: HelperColors.black5),
        ),
        children: widget.child,
      ),
    );
  }
}
