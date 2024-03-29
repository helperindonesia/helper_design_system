import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class BulletList extends StatelessWidget {
  final List<Widget> children;

  const BulletList({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.map((children) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                      color: HelperColors.black9, shape: BoxShape.circle),
                ),
                SizedBox(
                  width: 12.0,
                ),
                children
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
