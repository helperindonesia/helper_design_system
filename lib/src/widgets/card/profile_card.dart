import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ProfileCard extends StatelessWidget {
  final String? imageUrl;
  final String fullName;
  final Widget? child;
  final double rating;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onChatIconPressed;
  final Widget? footer;

  const ProfileCard({
    Key? key,
    this.imageUrl,
    required this.fullName,
    this.child,
    required this.rating,
    this.padding = const EdgeInsets.all(16.0),
    this.onChatIconPressed,
    this.footer,
  }) : super(key: key);

  factory ProfileCard.confirmation({
    Key? key,
    String? text,
    String? imageUrl,
    required String fullName,
    Widget? child,
    required double rating,
    EdgeInsetsGeometry? padding,
    VoidCallback? onChatIconPressed,
    required bool value,
    required ValueChanged<bool> onToggle,
  }) = _ProfileCardWithConfirmation;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      children: [
        CardContainer(
          padding: padding,
          children: [
            Row(
              children: [
                if (imageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image(
                        height: 56,
                        width: 52,
                        image: NetworkImage(imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                          style:
                              HelperThemeData.textTheme.buttonText1!.copyWith(
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
                            color: HelperColors.black8,
                          ),
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
                          style:
                              HelperThemeData.textTheme.buttonText1!.copyWith(
                            fontSize: 12,
                            color: HelperColors.black4,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                if (onChatIconPressed != null)
                  InkWell(
                    onTap: onChatIconPressed,
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
              ],
            ),
            child ?? SizedBox(),
          ],
        ),
        footer ?? SizedBox(),
      ],
    );
  }
}

class _ProfileCardWithConfirmation extends ProfileCard {
  _ProfileCardWithConfirmation({
    Key? key,
    String? text = 'Butuh Persetujuan Untuk Lanjut',
    String? imageUrl,
    required String fullName,
    Widget? child,
    required double rating,
    EdgeInsetsGeometry? padding,
    VoidCallback? onChatIconPressed,
    required bool value,
    required ValueChanged<bool> onToggle,
  }) : super(
          key: key,
          imageUrl: imageUrl,
          fullName: fullName,
          child: child,
          rating: rating,
          padding: padding,
          onChatIconPressed: onChatIconPressed,
          footer: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text!,
                  style: HelperThemeData.textTheme.bodyText1!
                      .copyWith(fontSize: 14),
                ),
                SwitchControl(value: value, onToggle: onToggle)
              ],
            ),
          ),
        );
}
