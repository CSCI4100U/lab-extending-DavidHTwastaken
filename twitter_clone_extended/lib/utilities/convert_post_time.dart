import 'package:intl/intl.dart';

String convertPostTime(DateTime postTime, DateTime current){
  Duration diff = current.difference(postTime);
  if(diff.inDays >= 365){
    return DateFormat('MMM d, yyyy').format(postTime);
  }
  if(diff.inHours >= 24){
    return DateFormat('MMMd').format(postTime).toString();
  }
  if(diff.inHours >= 1){
    return '${diff.inHours}h';
  }
  if(diff.inMinutes >= 1){
    return '${diff.inMinutes}m';
  }
  return '${diff.inSeconds}s';
}