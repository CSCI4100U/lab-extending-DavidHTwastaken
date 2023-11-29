import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test', () {
    DateTime postTime = DateTime(2023, 11, 28, 7);
    convertPostTime(postTime);
  });
}
