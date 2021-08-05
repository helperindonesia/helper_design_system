import 'package:example/request_cancel_order/request_cancel_order.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class RequestCancelOrderView extends StatelessWidget {
  const RequestCancelOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar(
        title: Text(
          'Ajukan Pembatalan',
          style: HelperThemeData.textTheme.headline4!
              .copyWith(color: HelperColors.black, fontWeight: FontWeight.w800),
        ),
        leading: Icon(
          Icons.close_rounded,
          color: HelperColors.black3,
          size: 24.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: [
            Text(
              'Untuk pembatalan dibutuhkan kesepakatan antara kamu dan helpermu, Jelaskan alasan pembatalanmu',
              style: HelperThemeData.textTheme.bodyText3,
            ),
            SizedBox(height: 16.0),
            OutlineTextField(labelText: 'Alasannya Apa?'),
            Expanded(child: SizedBox()),
            PrimaryButton(
                text: 'Ajukan Pembatalan',
                onPressed: () {
                  showModalBottomSheet<dynamic>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return RequestCancelOrderRejectedBottomSheet(
                          helpPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HelpPageView(),
                            ),
                          ),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
