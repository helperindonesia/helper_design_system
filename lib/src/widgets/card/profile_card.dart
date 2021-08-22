import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ProfileCard extends StatelessWidget {
  final String? imageUrl;
  final String fullName;
  final Widget? child;
  final double? rating;
  final EdgeInsetsGeometry? padding;
  final bool image;
  final bool message;
  final VoidCallback? messagePress;
  final bool footer;

  const ProfileCard(
      {Key? key,
      this.imageUrl,
      required this.fullName,
      this.child,
      required this.rating,
      this.padding,
      this.image = false,
      this.message = false,
      this.messagePress,
      this.footer = false})
      : super(key: key);

  factory ProfileCard.confirmation({
    Key? key,
    String? imageUrl,
    required String fullName,
    required double? rating,
    EdgeInsetsGeometry? padding,
    bool? image,
    bool? message,
    VoidCallback? messagePress,
    required bool value,
    required ValueChanged<bool> onToggle,
  }) = _ProfileCardWithConfirmation;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      children: [
        CardContainer.horizontal(
          padding: padding ?? EdgeInsets.all(16.0),
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            image
                ? Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        height: 56,
                        width: 52,
                        image: NetworkImage(imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: HelperThemeData.textTheme.headline5!
                      .copyWith(fontSize: 16.0),
                ),
                SizedBox(height: 6),
                CardContainer.horizontal(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                  children: [
                    Icon(
                      Icons.thumb_up_rounded,
                      color: HelperColors.green,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: HelperThemeData.textTheme.buttonText1!.copyWith(
                        fontSize: 12,
                        color: HelperColors.black4,
                      ),
                    ),
                    Container(
                      width: 0.75,
                      height: 15,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: HelperColors.black8),
                    ),
                    Icon(
                      Icons.emoji_events_rounded,
                      color: HelperColors.orange,
                      size: 16,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Jempolan',
                      style: HelperThemeData.textTheme.buttonText1!.copyWith(
                        fontSize: 12,
                        color: HelperColors.black4,
                      ),
                    )
                  ],
                ),
                !footer ? child ?? SizedBox() : SizedBox(),
              ],
            ),
            message ? Expanded(child: SizedBox()) : SizedBox(),
            message
                ? InkWell(
                    onTap: messagePress,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: HelperColors.green),
                      child: Icon(
                        Icons.chat_bubble_rounded,
                        size: 20,
                        color: HelperColors.white,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        footer ? child ?? SizedBox() : SizedBox(),
      ],
    );
  }
}

class _ProfileCardWithConfirmation extends ProfileCard {
  _ProfileCardWithConfirmation({
    Key? key,
    String? imageUrl,
    required String fullName,
    required double? rating,
    EdgeInsetsGeometry? padding,
    bool? image,
    bool? message,
    VoidCallback? messagePress,
    required bool value,
    required ValueChanged<bool> onToggle,
  }) : super(
          key: key,
          image: image ?? false,
          message: message ?? false,
          fullName: fullName,
          padding: padding,
          messagePress: messagePress,
          rating: rating,
          imageUrl: imageUrl,
          footer: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Butuh Persetujuan Untuk Lanjut',
                  style: HelperThemeData.textTheme.bodyText1!
                      .copyWith(fontSize: 14),
                ),
                SwitchControl(value: value, onToggle: onToggle)
              ],
            ),
          ),
        );
}
