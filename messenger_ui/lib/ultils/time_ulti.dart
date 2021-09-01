
int getTimeOnline({DateTime? time}) {
  DateTime now = DateTime.now().toLocal();
  int minute = now.difference(time!).inMinutes;
  if (minute > 60) {
    int hours = now.difference(time).inHours;
    if (hours > 23) {
      int days = now.difference(time).inDays;
      return days;
    }
    return hours;
  }
  return minute;
}


String getTimeOnlineString({DateTime? time}) {
  DateTime now = DateTime.now().toLocal();
  int minute = now.difference(time!).inMinutes;
  if (minute > 60) {
    int hours = now.difference(time).inHours;
    if (hours > 23) {
      int days = now.difference(time).inDays;
      return "$days ago";
    }
    return "$hours hour ago";
  }
  return "$minute minutes ago";
}