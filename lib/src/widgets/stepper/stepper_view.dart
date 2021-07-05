import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter/widgets.dart';
import 'package:helper_design/helper_design.dart';
import 'package:timelines/timelines.dart';

enum StepViewType { horizontal, vertical }

class Step {
  final Widget content;
  final Widget? indicatorIcon;
  final Color? indicatorColor;
  final Color? lineColor;
  final String? title;
  final Widget? action;

  Step({
    required this.content,
    this.indicatorIcon,
    this.indicatorColor,
    this.title,
    this.action,
    this.lineColor,
  });
}

class StepView extends StatefulWidget {
  const StepView({
    Key? key,
    this.currentStep = 0,
    required this.steps,
    this.stepViewType = StepViewType.vertical,
    this.physics,
  }) : super(key: key);

  final int currentStep;
  final List<Step> steps;
  final StepViewType stepViewType;
  final ScrollPhysics? physics;

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
        contentsBuilder: (_, index) => Container(
          margin: const EdgeInsets.only(left: 16, bottom: 16),
          child: widget.steps[index].content,
        ),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    assert(widget.steps[widget.currentStep].title != null);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.steps[widget.currentStep].title!,
          style: HelperThemeData.textTheme.headline5,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 14, bottom: 16),
          child: ProgressIndicator(
            percentage: 100 / widget.steps.length * (widget.currentStep + 1),
          ),
        ),
        Expanded(
          child: ListView(
            physics: widget.physics,
            children: [
              AnimatedSize(
                vsync: this,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                child: widget.steps[widget.currentStep].content,
              ),
            ],
          ),
        ),
        widget.steps[widget.currentStep].action ?? Container(),
      ],
    );
  }
}
