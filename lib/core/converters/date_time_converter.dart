import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, int> {
  const DateTimeConverter();
  @override
  DateTime fromJson(int json) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(json);
    return dateTime;
  }

  @override
  int toJson(DateTime? dateTime) {
    if (dateTime != null) {
      return dateTime.millisecondsSinceEpoch;
    }
    return 0;
  }
}
