
class DateUtil {
  ///时间戳格式化  yyyy-MM-dd HH-mm-ss
  String dateFormat(int dateTime) {

    return DateTime.fromMicrosecondsSinceEpoch(dateTime).toString();
  }
}
