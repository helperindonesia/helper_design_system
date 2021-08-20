import 'package:flutter/material.dart' hide OutlinedButton;

import '../../../helper_design.dart';

class PrimaryCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonText;
  final String? illustrationImage;
  final VoidCallback onPressed;

  const PrimaryCard(
      {Key? key,
      required this.onPressed,
      this.title,
      this.description,
      this.buttonText,
      this.illustrationImage})
      : super(key: key);

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
                title ?? 'Beri Tip Buat Helpermu',
                style: HelperThemeData.textTheme.headline5!.copyWith(
                    fontSize: 16.0,
                    letterSpacing: 0.8 / 100,
                    color: HelperColors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                description ?? 'Apresiasi Helper yuk',
                style: HelperThemeData.textTheme.caption!
                    .copyWith(color: HelperColors.white),
              ),
            ),
            SizedBox(height: 14.0),
            HOutlinedButton(
              backgroundColor: Colors.transparent,
              borderColor: HelperColors.white,
              height: 24.0,
              width: 80.0,
              onPressed: onPressed,
              text: buttonText ?? 'Beri Tip',
              textStyle: HelperThemeData.textTheme.buttonText1!
                  .copyWith(color: HelperColors.white),
            )
          ],
        ),
        Image(
          image: AssetImage(
              illustrationImage ?? 'assets/images/ilustrasi_beri_tip.webp'),
          fit: BoxFit.fill,
          width: 142.0,
          height: 92.0,
        ),
      ],
    );
  }
}
