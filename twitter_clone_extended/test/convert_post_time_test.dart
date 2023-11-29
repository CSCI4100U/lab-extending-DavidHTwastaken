import 'package:twitter_clone_extended/utilities/convert_post_time.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test', () {
    DateTime start = DateTime(2023,11,28,7,6,12);
    DateTime end = DateTime(2023, 11, 28, 7,6,13);
    String diff = convertPostTime(start,end);
    expect(diff, '1s');
  });
}
