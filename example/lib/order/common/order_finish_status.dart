import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class OrderFinishStatus extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;

  const OrderFinishStatus({Key? key, this.text, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/ic_helper.webp',
                  height: 40.0,
                  width: 40.0,
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Helper Asisten',
                        style: HelperThemeData.textTheme.headline5,
                      ),
                      Text(
                        'Tawaran Helpermu',
                        style: HelperThemeData.textTheme.buttonText1!
                            .copyWith(fontSize: 12.0, color: HelperColors.black5),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Sen, 17 Agu . 12 : 30',
                      style: HelperThemeData.textTheme.caption!
                          .copyWith(color: HelperColors.black5),
                    ),
                    SizedBox(height: 6.0),
                    HelperLabel(
                        text: text, backgroundColor: backgroundColor ?? HelperColors.green),
                    SizedBox(height: 14.0),
                  ],
                )
              ],
            ),
          ),
          Divider(
            thickness: 0.75,
          )
        ],
      ),
    );
  }
}
