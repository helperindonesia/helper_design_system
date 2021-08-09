import 'dart:async';
import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

import 'order.dart';

enum OrderState {
  LookingHelper,
  FindingHelper,
  ToDo,
  OnProgress,
  OnConfirmation,
  Done,
  Cancel,
}

class OrderView extends StatefulWidget {
  final OrderState? orderState;

  const OrderView({Key? key, this.orderState = OrderState.LookingHelper})
      : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  int currentStep = 0;
  late OrderState _orderState;
  bool withOutConfirmation = false;

  @override
  void initState() {
    super.initState();
    _orderState = widget.orderState ?? OrderState.LookingHelper;
    Timer(Duration(seconds: 8), () {
      _orderState = OrderState.FindingHelper;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _orderState == OrderState.LookingHelper
              ? SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 18.0, right: 18.0, top: 124.0, bottom: 4.0),
                          child: Stack(
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/images/get_ready.png'),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                bottom: 4.0,
                                left: 30.0,
                                child: Text(
                                  'Helpermu Sedang Bersiap',
                                  style: HelperThemeData.textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Text(
                            'Peralatan disediakan Helpermu akan dikenakan harga pemeliharaan alat.',
                            style: HelperThemeData.textTheme.bodyText3,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Image(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
          Positioned(
            child: HelperAppBar.helpIcon(
                backgroundColor: Colors.transparent, elevation: 0),
          ),
          SafeArea(
            child: DraggableBottomSheet(
                initialChildSize: 0.12,
                minChildSize: 0.12,
                backgroundColor: HelperColors.white,
                child:
                OrderFinishView(onPressed: () {  },)
                // ProgressOrderView(orderState: _orderState),
                ),
          ),
        ],
      ),
    );
  }
}
