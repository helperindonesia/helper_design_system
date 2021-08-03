import 'package:flutter/material.dart' hide OutlinedButton;

import '../../../helper_design.dart';

class TipCard extends StatelessWidget {
  final VoidCallback onPressed;

  const TipCard({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer.horizontal(
      radius: 12.0,
      color: HelperColors.orange,
      padding: EdgeInsets.all(12.0),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      border: Border(),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                'Beri Tip Buat Helpermu',
                style: HelperThemeData.textTheme.headline5!.copyWith(
                    fontSize: 16.0,
                    letterSpacing: 0.8 / 100,
                    color: HelperColors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                'Apresiasi Helper yuk',
                style: HelperThemeData.textTheme.caption!
                    .copyWith(color: HelperColors.white),
              ),
            ),
            SizedBox(height: 14.0),
            OutlinedButton(
              backgroundColor: Colors.transparent,
              borderColor: HelperColors.white,
              height: 24.0,
              width: 80.0,
              onPressed: onPressed,
              text: 'Beri Tip',
              textStyle: HelperThemeData.textTheme.buttonText1!
                  .copyWith(color: HelperColors.white),
            )
          ],
        ),
        Image(
          image: AssetImage('assets/images/get_ready.png'),
          fit: BoxFit.cover,
          width: 40,
          height: 40,
        ),
      ],
    );
  }
}
