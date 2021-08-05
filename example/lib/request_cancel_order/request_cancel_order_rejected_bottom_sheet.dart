import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class RequestCancelOrderRejectedBottomSheet extends StatelessWidget {
  final VoidCallback? helpPressed;

  const RequestCancelOrderRejectedBottomSheet({Key? key, this.helpPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModalBottomSheet(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 48.0, right: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/ilustrasi_pengajuan_ditolak.webp',
                height: 148.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 16.0),
              Text('Opsss, Pengajuanmu Ditolak',
                  style: HelperThemeData.textTheme.headline5),
              Text(
                'Karena saya telah mengerjakan beberapa progres order. - Mitra Helper',
                style: HelperThemeData.textTheme.bodyText3!
                    .copyWith(color: HelperColors.black3),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: PrimaryButton(
                      backgroundColor: HelperColors.black8,
                      text: 'Bantuan',
                      onPressed: helpPressed ?? () {})),
              SizedBox(width: 12.0),
              Flexible(
                child: PrimaryButton(
                  text: 'Ok, Mengerti',
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
