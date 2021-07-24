import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DetailPrice extends StatelessWidget {
  final String? taskCost;
  final String? toolCost;
  final String? helperCount;
  final String? totalCost;

  const DetailPrice(
      {Key? key,
      this.taskCost,
      this.toolCost,
      this.helperCount,
      this.totalCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 13.0),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Harga Tugas',
                style: HelperThemeData.textTheme.caption!
                    .copyWith(color: HelperColors.black5)),
            Text(
              taskCost ?? 'Rp 40.000 x 3 Jam',
              style:
                  HelperThemeData.textTheme.bodyText1!.copyWith(fontSize: 14.0),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Pemeliharaan alat',
              style: HelperThemeData.textTheme.caption!
                  .copyWith(color: HelperColors.black5),
            ),
            Text(
              toolCost ?? 'Rp 20.000',
              style:
                  HelperThemeData.textTheme.bodyText1!.copyWith(fontSize: 14.0),
            )
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Helpermu',
              style: HelperThemeData.textTheme.caption!
                  .copyWith(color: HelperColors.black5),
            ),
            Text(
              helperCount ?? 'x 2 Orang',
              style:
                  HelperThemeData.textTheme.bodyText1!.copyWith(fontSize: 14.0),
            )
          ],
        ),
        SizedBox(height: 16.0),
        DashLine(),
        SizedBox(height: 13.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Bayar',
              style: HelperThemeData.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              totalCost ?? 'Rp 280.000',
              style: HelperThemeData.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.w700),
            )
          ],
        ),
      ],
    );
  }
}
