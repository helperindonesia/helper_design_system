import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class TaskCard extends StatelessWidget {
  final String? title;
  final TextStyle? titleStyle;
  final String? address;
  final TextStyle? addressStyle;
  final VoidCallback? dragHandle;
  final VoidCallback deleteTaskPressed;
  final VoidCallback editTaskPressed;
  final Color? backgroundColor;

  const TaskCard(
      {Key? key,
      this.title,
      this.titleStyle,
      this.address,
      this.addressStyle,
      this.dragHandle,
      required this.deleteTaskPressed,
      required this.editTaskPressed,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? HelperColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.75, color: HelperColors.black10),
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 13.0, bottom: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    title ?? '',
                    style: titleStyle ??
                        HelperThemeData.textTheme.bodyText1!
                            .copyWith(color: HelperColors.black),
                  ),
                ),
                InkWell(
                  onTap: dragHandle,
                  child: Icon(
                    Icons.drag_handle,
                    color: HelperColors.black8,
                    size: 24.0,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              address ?? '',
              style: addressStyle ??
                  HelperThemeData.textTheme.caption!
                      .copyWith(color: HelperColors.black5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            //TODO : Add Dash Line After Merge
            child: Container(),
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  text: 'Hapus',
                  textStyle: HelperThemeData.textTheme.buttonText2!
                      .copyWith(color: HelperColors.black3),
                  onPressed: deleteTaskPressed,
                  icon: Icon(
                    Icons.remove_circle,
                    size: 16.0,
                    color: HelperColors.black3,
                  ),
                  height: 24.0,
                  width: 82.0,
                  borderColor: HelperColors.black5,
                ),
                OutlinedButton.icon(
                  text: 'Ubah',
                  textStyle: HelperThemeData.textTheme.buttonText2!
                      .copyWith(color: HelperColors.black3),
                  onPressed: deleteTaskPressed,
                  icon: Icon(
                    Icons.edit,
                    size: 16.0,
                    color: HelperColors.black3,
                  ),
                  height: 24.0,
                  width: 75.0,
                  borderColor: HelperColors.black5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
