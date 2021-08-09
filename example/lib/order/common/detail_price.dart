import 'package:example/order/order.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DetailPrice extends StatelessWidget {
  final String? taskCost;
  final String? toolCost;
  final String? helperCount;
  final String? totalCost;
  final OrderState? orderState;

  const DetailPrice(
      {Key? key,
      this.taskCost,
      this.toolCost,
      this.helperCount,
      this.totalCost,
      this.orderState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      padding: EdgeInsets.only(bottom: 16.0),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        orderState == OrderState.Done || orderState == OrderState.Cancel
            ? Container(
                margin:
                    const EdgeInsets.only(left: 16.0, top: 13.0, bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Detail Bayar',
                      style: HelperThemeData.textTheme.headline5!
                          .copyWith(fontSize: 16.0),
                    ),
                    LabelHalfCircular(text: 'Helpcash')
                  ],
                ),
              )
            : SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Biaya jasa',
                      style: HelperThemeData.textTheme.caption!
                          .copyWith(color: HelperColors.black5)),
                  Text(
                    taskCost ?? 'Rp 40.000',
                    style: HelperThemeData.textTheme.bodyText1!
                        .copyWith(fontSize: 14.0),
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
                    style: HelperThemeData.textTheme.bodyText1!
                        .copyWith(fontSize: 14.0),
                  ),
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
                    style: HelperThemeData.textTheme.bodyText1!
                        .copyWith(fontSize: 14.0),
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
          ),
        ),
      ],
    );
  }
}
