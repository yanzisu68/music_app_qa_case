import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Music App Integration Test", () {
    FlutterDriver? driver;

    // setup - connect to flutter before running tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver?.waitUntilFirstFrameRasterized(); // make sure app fully initialized before starting the tests
    });

    // teardown - close connection to flutter after all tests completed
    tearDownAll(() {
      if (driver != null) {
        driver?.close();
      }
    });

    // test cases
    const homePageTitle = "Music App";
    const homePageDefaultText = "No Albums added yet";
    const searchHintText = "Search for albums";
    const errorSearchResult = "Somthin wrong happens!";

    final SerializableFinder searchIconFinder = find.byType('AppbarSearchButton');

    test("check default homepage display", () async {
      expect(await driver?.getText(find.text(homePageTitle)), homePageTitle);
      expect(await driver?.getText(find.text(homePageDefaultText)), homePageDefaultText);
    });


    test("check search page", () async {
      await driver?.tap(searchIconFinder);
      await driver?.waitFor(find.text(searchHintText));
      expect(await driver?.getText(find.text(searchHintText)), searchHintText);
    });

    test("check empty search", () async {
      await driver?.tap(searchIconFinder);
      await driver?.waitFor(find.text(searchHintText));
      await driver?.tap(find.byType('TextField'));
      await driver?.enterText("");
      // await driver?.waitForAbsent(find.text(errorSearchResult));
      await driver?.tap(searchIconFinder);
      // await driver?.waitFor(find.text(errorSearchResult));
      await driver?.waitUntilNoTransientCallbacks();
      expect(await driver?.getText(find.text(errorSearchResult)), errorSearchResult);
    });

    test("check search by album", () async {
      // await Future.delayed(const Duration(seconds: 2));
      await driver?.tap(searchIconFinder);
      await driver?.waitFor(find.text(searchHintText));
      await driver?.tap(find.byType('TextField'));
      await driver?.enterText("Selena");
      await driver?.tap(searchIconFinder);
      await driver?.waitUntilNoTransientCallbacks();
    });

    test("check like album", () async {
      await driver?.tap(searchIconFinder);
      await driver?.waitFor(find.text(searchHintText));
      await driver?.tap(find.byType('TextField'));
      await driver?.enterText("Selena");
      await driver?.tap(searchIconFinder);
      await driver?.waitUntilNoTransientCallbacks();
      // able to find album list
      // scroll album
      // click like button for several album
      // back to homepage to assert the liked album count
      await driver?.tap(find.byType('Column'));
    });

    test("check unlike album", () async {

    });

    test("check album detailed page", () async {

    });
  });
}
