import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

class Profile extends StatelessWidget {
  final String? displayName;
  final String? profileImage;
  final int? messageCount;
  final ValueChanged<bool>? withOutConfirmationTogglePress;
  final VoidCallback? messageButtonPress;
  final bool? withOutConfirmation;
  final ProfileType profileType;
  final bool afterNegotiation;
  final VoidCallback? negotiationButtonPress;
  final bool negotiationSuccess;

  const Profile({
    Key? key,
    this.displayName,
    this.messageCount,
    this.withOutConfirmation,
    this.withOutConfirmationTogglePress,
    this.profileType = ProfileType.WithAutoConfirmation,
    this.profileImage,
    this.messageButtonPress,
    this.afterNegotiation = false,
    this.negotiationButtonPress,
    this.negotiationSuccess = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CardContainer(
          margin: EdgeInsets.only(bottom: 16.0),
          children: [
            profileType == ProfileType.WithAutoConfirmation
                ? CardContainer(
                    children: [_profile(profileType)],
                  )
                : SizedBox(),
            profileType == ProfileType.WithOutAutoConfirmation
                ? _profile(profileType)
                : SizedBox(),
            profileType == ProfileType.WithPriceAndNegotiation
                ? _profile(profileType)
                : SizedBox(),
            profileType == ProfileType.WithAutoConfirmation
                ? Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanpa Konfirmasi Tugas',
                          style: HelperThemeData.textTheme.bodyText1!
                              .copyWith(fontSize: 14.0),
                        ),
                        SwitchControl(
                            value: withOutConfirmation ?? false,
                            onToggle:
                                withOutConfirmationTogglePress ?? (bool) {})
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ],
    );
  }

  Widget _profile(ProfileType profileType) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 16.0),
      child: Column(
        children: [
          Row(
            children: [
              profileType == ProfileType.WithOutAutoConfirmation ||
                      profileType == ProfileType.WithPriceAndNegotiation
                  ? Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            profileImage ?? 'assets/images/profile.png',
                            height: 56.0,
                            width: 52.0,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(width: 16.0),
                      ],
                    )
                  : SizedBox(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName ?? 'No Name',
                      style: HelperThemeData.textTheme.bodyText1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6.0),
                    HOutlinedButton(
                      height: 24.0,
                      width: 116.0,
                      borderWidth: 0.75,
                      borderColor: HelperColors.black,
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lihat Profile',
                              style: HelperThemeData.textTheme.bodyText1!
                                  .copyWith(
                                      fontSize: 12.0,
                                      color: HelperColors.black3),
                            ),
                            Icon(
                              Icons.navigate_next_rounded,
                              size: 16.0,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              profileType == ProfileType.WithAutoConfirmation
                  ? CircleIconButton(
                      onPressed: messageButtonPress ?? () {},
                      badgeCount: messageCount ?? 0,
                    )
                  : SizedBox(),
            ],
          ),
          profileType == ProfileType.WithPriceAndNegotiation
              ? _priceAndNegotiation('Rp 150.000')
              : SizedBox()
        ],
      ),
    );
  }

  Widget _priceAndNegotiation(String? price) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: DashLine(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: price ?? 'Rp 150.000',
                    style: HelperThemeData.textTheme.headline5!
                        .copyWith(color: HelperColors.black)),
                TextSpan(
                  text: ' / Helper',
                  style: HelperThemeData.textTheme.caption!
                      .copyWith(color: HelperColors.black5),
                )
              ]),
            ),
            !afterNegotiation
                ? HOutlinedButton(
                    text: 'Nego harga',
                    height: 24.0,
                    width: 107.0,
                    borderColor: HelperColors.black5,
                    textColor: HelperColors.black3,
                    onPressed: negotiationButtonPress ?? () {})
                : HelperLabel(
                    backgroundColor: HelperColors.green, text: 'Nego Berhasil'),
          ],
        )
      ],
    );
  }
}

enum ProfileType {
  WithAutoConfirmation,
  WithOutAutoConfirmation,
  WithPriceAndNegotiation
}
