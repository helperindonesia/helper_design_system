import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HBottomNavBar extends StatelessWidget {
  HBottomNavBar({
    Key? key,
    this.selectedIndex = 0,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 24,
    this.containerHeight = 64,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.easeInOut,
    this.textSelectedColor,
    this.textUnSelectedColor,
    this.selectedIconColor,
    this.unSelectedIconColor,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final Duration animationDuration;
  final List<HBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final Curve curve;
  final Color? textSelectedColor;
  final Color? textUnSelectedColor;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(32),
      elevation: 1.5,
      child: Container(
        height: containerHeight,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: backgroundColor ?? HelperColors.black,
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                item: item,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                backgroundColor: backgroundColor,
                itemCornerRadius: itemCornerRadius,
                animationDuration: animationDuration,
                curve: curve,
                textSelectedColor: textSelectedColor ?? HelperColors.white,
                textUnSelectedColor: textUnSelectedColor ?? HelperColors.black3,
                selectedIconColor: selectedIconColor ?? HelperColors.white,
                unSelectedIconColor: unSelectedIconColor ?? HelperColors.black3,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final HBottomNavBarItem item;
  final Color? backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;
  final Color? textSelectedColor;
  final Color? textUnSelectedColor;
  final Color? selectedIconColor;
  final Color? unSelectedIconColor;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.iconSize,
    this.curve = Curves.linear,
    this.textSelectedColor,
    this.textUnSelectedColor,
    this.selectedIconColor,
    this.unSelectedIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        height: 48,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected ? item.activeColor : item.inactiveColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            //TODO: Calculate Menu Count
            width: MediaQuery.of(context).size.width / 3 - 16,
            child: Stack(
              children: [
                !isSelected
                    ? Positioned(
                        right: 12,
                        child: (item.badgeCount != null && item.badgeCount != 0)
                            ? CircleAvatar(
                                child: Text(
                                  item.badgeCount.toString(),
                                  style: HelperThemeData.textTheme.caption!
                                      .copyWith(color: Colors.white),
                                ),
                                radius: 8,
                                backgroundColor: HelperColors.red,
                              )
                            : SizedBox())
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.fromLTRB(14, 12, 17, 12),
                  child: Row(
                    children: <Widget>[
                      IconTheme(
                        data: IconThemeData(
                            size: iconSize,
                            color: isSelected
                                ? selectedIconColor
                                : unSelectedIconColor),
                        child: item.icon,
                      ),
                      SizedBox(width: 4),
                      Text(
                        item.title,
                        style: HelperThemeData.textTheme.buttonText2!.copyWith(
                            color: isSelected
                                ? textSelectedColor
                                : textUnSelectedColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HBottomNavBarItem {
  HBottomNavBarItem({
    required this.icon,
    required this.title,
    this.activeColor = HelperColors.orange,
    this.textAlign,
    this.inactiveColor = Colors.transparent,
    this.badgeCount,
  });

  final Widget icon;
  final String title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign? textAlign;
  final int? badgeCount;
}
