import 'dart:math';

import 'package:helper_design/helper_design.dart';

//interface for picker data model
abstract class BasePickerModel {
  //a getter method for left column data, return null to end list
  String? leftStringAtIndex(int index);

  //a getter method for middle column data, return null to end list
  String? middleStringAtIndex(int index);

  //a getter method for right column data, return null to end list
  String? rightStringAtIndex(int index);

  //set selected left index
  void setLeftIndex(int index);

  //set selected middle index
  void setMiddleIndex(int index);

  //set selected right index
  void setRightIndex(int index);

  //return current left index
  int currentLeftIndex();

  //return current middle index
  int currentMiddleIndex();

  //return current right index
  int currentRightIndex();

  //return final time
  DateTime? finalTime();

  //return left divider string
  String leftDivider();

  //return right divider string
  String rightDivider();

  //layout proportions for 3 columns
  List<int> layoutProportions();
}

//a base class for picker data model
class CommonPickerModel extends BasePickerModel {
  late List<String> leftList;
  late List<String> middleList;
  late List<String> rightList;
  late DateTime currentTime;
  late int _currentLeftIndex;
  late int _currentMiddleIndex;
  late int _currentRightIndex;

  late LocaleType locale;

  CommonPickerModel({LocaleType? locale})
      : this.locale = locale ?? LocaleType.id;

  @override
  String? leftStringAtIndex(int index) {
    return null;
  }

  @override
  String? middleStringAtIndex(int index) {
    return null;
  }

  @override
  String? rightStringAtIndex(int index) {
    return null;
  }

  @override
  int currentLeftIndex() {
    return _currentLeftIndex;
  }

  @override
  int currentMiddleIndex() {
    return _currentMiddleIndex;
  }

  @override
  int currentRightIndex() {
    return _currentRightIndex;
  }

  @override
  void setLeftIndex(int index) {
    _currentLeftIndex = index;
  }

  @override
  void setMiddleIndex(int index) {
    _currentMiddleIndex = index;
  }

  @override
  void setRightIndex(int index) {
    _currentRightIndex = index;
  }

  @override
  String leftDivider() {
    return "";
  }

  @override
  String rightDivider() {
    return "";
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  DateTime? finalTime() {
    return null;
  }
}

// a date&time picker model
class DateTimePickerModel extends CommonPickerModel {
  DateTime? maxTime;
  DateTime? minTime;

  DateTimePickerModel(
      {DateTime? currentTime,
      DateTime? maxTime,
      DateTime? minTime,
      LocaleType? locale})
      : super(locale: locale) {
    if (currentTime != null) {
      this.currentTime = currentTime;
      if (maxTime != null &&
          (currentTime.isBefore(maxTime) ||
              currentTime.isAtSameMomentAs(maxTime))) {
        this.maxTime = maxTime;
      }
      if (minTime != null &&
          (currentTime.isAfter(minTime) ||
              currentTime.isAtSameMomentAs(minTime))) {
        this.minTime = minTime;
      }
    } else {
      this.maxTime = maxTime;
      this.minTime = minTime;
      var now = DateTime.now();
      if (this.minTime != null && this.minTime!.isAfter(now)) {
        this.currentTime = this.minTime!;
      } else if (this.maxTime != null && this.maxTime!.isBefore(now)) {
        this.currentTime = this.maxTime!;
      } else {
        this.currentTime = now;
      }
    }

    if (this.minTime != null &&
        this.maxTime != null &&
        this.maxTime!.isBefore(this.minTime!)) {
      // invalid
      this.minTime = null;
      this.maxTime = null;
    }

    _currentLeftIndex = 0;
    _currentMiddleIndex = this.currentTime.hour;
    _currentRightIndex = this.currentTime.minute;
    if (this.minTime != null && isAtSameDay(this.minTime!, this.currentTime)) {
      _currentMiddleIndex = this.currentTime.hour - this.minTime!.hour;
      if (_currentMiddleIndex == 0) {
        _currentRightIndex = this.currentTime.minute - this.minTime!.minute;
      }
    }
  }

  bool isAtSameDay(DateTime? day1, DateTime? day2) {
    return day1 != null &&
        day2 != null &&
        day1.difference(day2).inDays == 0 &&
        day1.day == day2.day;
  }

  @override
  void setLeftIndex(int index) {
    super.setLeftIndex(index);
    DateTime time = currentTime.add(Duration(days: index));
    if (isAtSameDay(minTime, time)) {
      var index = min(24 - minTime!.hour - 1, _currentMiddleIndex);
      this.setMiddleIndex(index);
    } else if (isAtSameDay(maxTime, time)) {
      var index = min(maxTime!.hour, _currentMiddleIndex);
      this.setMiddleIndex(index);
    }
  }

  @override
  void setMiddleIndex(int index) {
    super.setMiddleIndex(index);
    DateTime time = currentTime.add(Duration(days: _currentLeftIndex));
    if (isAtSameDay(minTime, time) && index == 0) {
      var maxIndex = 60 - minTime!.minute - 1;
      if (_currentRightIndex > maxIndex) {
        _currentRightIndex = maxIndex;
      }
    } else if (isAtSameDay(maxTime, time) &&
        _currentMiddleIndex == maxTime!.hour) {
      var maxIndex = maxTime!.minute;
      if (_currentRightIndex > maxIndex) {
        _currentRightIndex = maxIndex;
      }
    }
  }

  @override
  String? leftStringAtIndex(int index) {
    DateTime time = currentTime.add(Duration(days: index));
    if (minTime != null &&
        time.isBefore(minTime!) &&
        !isAtSameDay(minTime!, time)) {
      return null;
    } else if (maxTime != null &&
        time.isAfter(maxTime!) &&
        !isAtSameDay(maxTime, time)) {
      return null;
    }
    return formatDate(time, [ymdw], locale);
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      DateTime time = currentTime.add(Duration(days: _currentLeftIndex));
      if (isAtSameDay(minTime, time)) {
        if (index >= 0 && index < 24 - minTime!.hour) {
          return digits(minTime!.hour + index, 2);
        } else {
          return null;
        }
      } else if (isAtSameDay(maxTime, time)) {
        if (index >= 0 && index <= maxTime!.hour) {
          return digits(index, 2);
        } else {
          return null;
        }
      }
      return digits(index, 2);
    }

    return null;
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      DateTime time = currentTime.add(Duration(days: _currentLeftIndex));
      if (isAtSameDay(minTime, time) && _currentMiddleIndex == 0) {
        if (index >= 0 && index < 60 - minTime!.minute) {
          return digits(minTime!.minute + index, 2);
        } else {
          return null;
        }
      } else if (isAtSameDay(maxTime, time) &&
          _currentMiddleIndex >= maxTime!.hour) {
        if (index >= 0 && index <= maxTime!.minute) {
          return digits(index, 2);
        } else {
          return null;
        }
      }
      return digits(index, 2);
    }

    return null;
  }

  @override
  DateTime finalTime() {
    DateTime time = currentTime.add(Duration(days: _currentLeftIndex));
    var hour = _currentMiddleIndex;
    var minute = _currentRightIndex;
    if (isAtSameDay(minTime, time)) {
      hour += minTime!.hour;
      if (minTime!.hour == hour) {
        minute += minTime!.minute;
      }
    }

    return currentTime.isUtc
        ? DateTime.utc(time.year, time.month, time.day, hour, minute)
        : DateTime(time.year, time.month, time.day, hour, minute);
  }

  @override
  List<int> layoutProportions() {
    return [1, 1, 1];
  }

  @override
  String rightDivider() {
    return ':';
  }
}
