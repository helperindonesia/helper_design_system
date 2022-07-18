import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:helper_design/helper_design.dart';
import 'package:timelines/timelines.dart';

enum StepViewType { horizontal, vertical }

typedef StepViewBuilder = Step Function(int index);

class Step {
  final Widget content;
  final Widget? indicatorIcon;
  final Color? indicatorColor;
  final Color? lineColor;
  final String? title;
  final Widget? action;
  final Widget? bottomPanel;
  final EdgeInsetsGeometry? contentPadding;

  Step({
    required this.content,
    this.indicatorIcon,
    this.indicatorColor,
    this.title,
    this.action,
    this.lineColor,
    this.bottomPanel,
    this.contentPadding,
  });
}

class StepView extends StatefulWidget {
  const StepView({
    Key? key,
    this.currentStep = 0,
    required this.steps,
    this.stepViewType = StepViewType.vertical,
    this.lastConnector = false,
    this.lastConnectorColor,
  }) : super(key: key);

  final int currentStep;
  final List<Step> steps;
  final StepViewType stepViewType;
  final bool lastConnector;
  final Color? lastConnectorColor;

  factory StepView.builder({
    Key? key,
    required int itemCount,
    required StepViewBuilder builder,
    int currentStep = 0,
    StepViewType stepViewType = StepViewType.vertical,
  }) =>
      StepView(
        key: key,
        steps: List<Step>.generate(itemCount, builder),
        currentStep: currentStep,
        stepViewType: stepViewType,
      );

  @override
  _StepViewState createState() => _StepViewState();
}

class _StepViewState extends State<StepView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    switch (widget.stepViewType) {
      case StepViewType.horizontal:
        return _buildHorizontal(context);
      case StepViewType.vertical:
        return _buildVertical();
    }
  }

  Widget _buildVertical() {
    return FixedTimeline.tileBuilder(
      builder: TimelineTileBuilder.connected(
        indicatorPositionBuilder: (_, index) => 0.0,
        nodePositionBuilder: (_, index) => 0.0,
        itemCount: widget.steps.length,
        indicatorBuilder: (_, index) {
          return CircleAvatar(
            radius: 14,
            backgroundColor:
                widget.steps[index].indicatorColor ?? HelperColors.orange,
            child: widget.steps[index].indicatorIcon ??
                Text(
                  '${index + 1}',
                  style: HelperThemeData.textTheme.caption!
                      .copyWith(color: Colors.white),
                ),
          );
        },
        connectorBuilder: (_, index, type) => Connector.dashedLine(
          dash: 4,
          gap: 3,
          thickness: 0.75,
          color: widget.steps[index].lineColor ?? HelperColors.orange,
        ),
        lastConnectorBuilder: widget.lastConnector
            ? (_) => Connector.dashedLine(
                  dash: 4,
                  gap: 3,
                  thickness: 0.75,
                  color: widget.lastConnectorColor ?? HelperColors.orange,
                )
            : null,
        contentsBuilder: (_, index) => Container(
          padding: widget.steps[index].contentPadding ??
              const EdgeInsets.only(left: 16, bottom: 16),
          child: widget.steps[index].content,
        ),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    assert(widget.steps[widget.currentStep].title != null);

    final Widget column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            widget.steps[widget.currentStep].title!,
            style: HelperThemeData.textTheme.headline5,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ProgressIndicator(
            percentage: 100 / widget.steps.length * (widget.currentStep + 1),
          ),
        ),
        Expanded(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            child: widget.steps[widget.currentStep].content,
          ),
        ),
        widget.steps[widget.currentStep].action ?? Container(),
      ],
    );

    if (widget.steps[widget.currentStep].bottomPanel != null)
      return Stack(
        children: [
          column,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: widget.steps[widget.currentStep].bottomPanel!,
          ),
        ],
      );

    return column;
  }
}
