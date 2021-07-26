
String tener_fecha(){

  var nowTime = DateTime.now();
  String striDeyWeek = "";
  if (nowTime.weekday == 0) {
    striDeyWeek = "Sun";
  } else if (nowTime.weekday == 1) {
    striDeyWeek = "Mon";
  } else if (nowTime.weekday == 2) {
    striDeyWeek = "Tue";
  } else if (nowTime.weekday == 3) {
    striDeyWeek = "Wed";
  } else if (nowTime.weekday == 4) {
    striDeyWeek = "Thu";
  } else if (nowTime.weekday == 5) {
    striDeyWeek = "Fri";
  } else if (nowTime.weekday == 6) {
    striDeyWeek = "Sat";
  } else if (nowTime.weekday == 7) {
    striDeyWeek = "Sun";
  }

  String striMonth = "";
  if (nowTime.month == 0) {
    striMonth = "Jan";
  } else if (nowTime.month == 1) {
    striMonth = "Feb";
  } else if (nowTime.month == 2) {
    striMonth = "Mar";
  } else if (nowTime.month == 3) {
    striMonth = "Apr";
  } else if (nowTime.month == 4) {
    striMonth = "May";
  } else if (nowTime.month == 5) {
    striMonth = "Jun";
  } else if (nowTime.month == 6) {
    striMonth = "Jul";
  } else if (nowTime.month == 7) {
    striMonth = "Aug";
  } else if (nowTime.month == 8) {
    striMonth = "Sep";
  } else if (nowTime.month == 9) {
    striMonth = "Oct";
  } else if (nowTime.month == 10) {
    striMonth = "Nov";
  } else if (nowTime.month == 11) {
    striMonth = "Dec";
  }

  String hoy_day = "   " +
      striDeyWeek +
      " " +
      nowTime.day.toString() +
      " " +
      striMonth +
      "   "; //+ " " + now_time.hour.toString() + ":" + now_time.minute.toString();

  return hoy_day;
}