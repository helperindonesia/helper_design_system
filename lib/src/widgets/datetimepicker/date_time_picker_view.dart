import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

typedef DateChangedCallback(DateTime time);
typedef DateCancelledCallback();
typedef String? StringAtIndexCallBack(int index);

class DateTimePickerView extends StatelessWidget {
  final DateTime? minTime;
  final DateTime? maxTime;
  final DateChangedCallback? onChanged;
  final LocaleType? locale;
  final DateTime? currentTime;
  final DatePickerTheme? theme;

  const DateTimePickerView({
    Key? key,
    this.minTime,
    this.maxTime,
    required this.onChanged,
    this.locale,
    this.currentTime,
    this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _DatePickerComponent(
      theme: theme,
      onChanged: onChanged,
      pickerModel: DateTimePickerModel(
        currentTime: currentTime ?? DateTime.now().add(Duration(hours: 3)),
        minTime: minTime ?? DateTime.now(),
        maxTime: maxTime,
        locale: locale ?? LocaleType.id,
      ),
    );
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent({
    Key? key,
    required this.pickerModel,
    this.onChanged,
    this.locale,
    this.theme,
  }) : super(key: key);

  final DateChangedCallback? onChanged;
  final DatePickerTheme? theme;
  final LocaleType? locale;

  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.theme ?? DatePickerTheme();
    return Container(
      margin: theme.margin,
      decoration: BoxDecoration(
          color: theme.backgroundColor,
          border:
              Border.all(width: theme.borderWidth, color: theme.borderColor),
          borderRadius: BorderRadius.circular(theme.borderRadius)),
      child: _renderPickerView(theme),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(widget.pickerModel.finalTime()!);
    }
  }

  Widget _renderPickerView(DatePickerTheme theme) {
    Widget itemView = _renderItemView(theme);
    return itemView;
  }

  Widget _renderColumnView(
    ValueKey key,
    DatePickerTheme theme,
    StringAtIndexCallBack stringAtIndexCB,
    ScrollController scrollController,
    int layoutProportion,
    ValueChanged<int> selectedChangedWhenScrolling,
    ValueChanged<int> selectedChangedWhenScrollEnd,
  ) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        padding: EdgeInsets.all(0),
        height: theme.containerHeight,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
                  notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: theme.itemHeight,
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            itemBuilder: (BuildContext context, int index) {
              final content = stringAtIndexCB(index);
              if (content == null) {
                return null;
              }
              return Container(
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: theme.itemStyle ??
                      HelperThemeData.textTheme.bodyText1!
                          .copyWith(color: HelperColors.black),
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _renderItemView(DatePickerTheme theme) {
    return Stack(
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: widget.pickerModel.layoutProportions()[0] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.leftStringAtIndex,
                        leftScrollCtrl,
                        widget.pickerModel.layoutProportions()[0], (index) {
                        widget.pickerModel.setLeftIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      })
                    : null,
              ),
              Text(
                widget.pickerModel.leftDivider(),
                style: theme.itemStyle ??
                    HelperThemeData.textTheme.bodyText1!
                        .copyWith(color: HelperColors.black),
              ),
              Container(
                child: widget.pickerModel.layoutProportions()[1] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.middleStringAtIndex,
                        middleScrollCtrl,
                        widget.pickerModel.layoutProportions()[1], (index) {
                        widget.pickerModel.setMiddleIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      })
                    : null,
              ),
              Text(
                widget.pickerModel.rightDivider(),
                style: theme.itemStyle ??
                    HelperThemeData.textTheme.bodyText1!
                        .copyWith(color: HelperColors.black),
              ),
              Container(
                child: widget.pickerModel.layoutProportions()[2] > 0
                    ? _renderColumnView(
                        ValueKey(widget.pickerModel.currentMiddleIndex() * 100 +
                            widget.pickerModel.currentLeftIndex()),
                        theme,
                        widget.pickerModel.rightStringAtIndex,
                        rightScrollCtrl,
                        widget.pickerModel.layoutProportions()[2], (index) {
                        widget.pickerModel.setRightIndex(index);
                      }, (index) {
                        setState(() {
                          refreshScrollOffset();
                          _notifyDateChanged();
                        });
                      })
                    : null,
              ),
            ],
          ),
        ),
        Positioned.fill(
          top: theme.containerHeight / 2 - 24,
          bottom: theme.containerHeight / 2 - 24,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  width: theme.innerBorderWidth, color: theme.innerBorderColor),
              borderRadius: BorderRadius.circular(theme.innerBorderRadius),
            ),
          ),
        )
      ],
    );
  }
}
