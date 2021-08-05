import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelpPageView extends StatelessWidget {
  const HelpPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar(
        title: Text(
          'Bantuan',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
                'Laporkan apa keluhanmu, Kami akan membantumu untuk menyelesaikannya.',
                style: HelperThemeData.textTheme.bodyText3),
            SizedBox(height: 16.0),
            OutlineTextField(labelText: 'Ceritakan Keluhanmu'),
            Expanded(child: SizedBox()),
            PrimaryButton(
              text: 'Laporkan',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
