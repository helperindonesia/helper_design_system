enum LocaleType {
  en,
  id,
}

final _i18nModel = <LocaleType, Map<String, Object>>{
  LocaleType.en: {
    'today': 'Today',
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'monthLong': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ],
    'dayShort': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
    'dayLong': [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ],
    'am': 'AM',
    'pm': 'PM'
  },
  LocaleType.id: {
    'today': 'Hari Ini',
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ],
    'monthLong': [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ],
    'dayShort': ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'],
    'dayLong': ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'],
    'am': 'AM',
    'pm': 'PM'
  },
};

/// Get international object for [localeType]
Map<String, Object> i18nObjInLocale(LocaleType? localeType) =>
    _i18nModel[localeType] ?? _i18nModel[LocaleType.en] as Map<String, Object>;

/// Get international lookup for a [localeType], [key] and [index].
String i18nObjInLocaleLookup(LocaleType localeType, String key, int index) {
  final i18n = i18nObjInLocale(localeType);
  final i18nKey = i18n[key] as List<String>;
  return i18nKey[index];
}
