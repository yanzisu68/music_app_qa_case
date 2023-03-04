import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Music App Test", () {
    FlutterDriver? driver;

    // setup
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // teardown
    tearDownAll(() {
      if (driver != null) {
        driver?.close();
      }
    });

    // test case
    test("search by musician name", () async {
      expect(await driver?.getText(find.byValueKey('input')), "0");
    });
  });
}
