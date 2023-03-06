import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group("Music App Integration Test", () {
    FlutterDriver? driver;

    // setup by connecting to flutter before running tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
      await driver
          ?.waitUntilFirstFrameRasterized(); // make sure app fully initialized before starting the tests
    });

    // teardown by closing connection to flutter after all tests completed
    tearDownAll(() {
      if (driver != null) {
        driver?.close();
      }
    });

    // test cases
    const homePageTitle = "Music App";
    const homePageDefaultText = "No Albums added yet";
    const searchHintText = "Search for albums";
    const searchInputText = "Yan-Zi Sun";
    const searchResultArtistName = "Sun Yan-Zi";
    const searchAlbumTopAlbumsTitle = '$searchResultArtistName Top Albums';

    final SerializableFinder homePageFinder = find.byType('HomePage');
    final SerializableFinder homePageAndAlbumDetailPageTitleFinder =
        find.text(homePageTitle);
    final SerializableFinder homePageDefaultTextFinder =
        find.text(homePageDefaultText);
    final SerializableFinder searchIconFinder =
        find.byType('AppbarSearchButton');
    final SerializableFinder searchPageFinder = find.byType('SearchPage');
    final SerializableFinder likeButtonFinder = find.byType('FavoriteButton');
    final SerializableFinder searchInputBoxFinder = find.byType('TextField');
    final SerializableFinder topAlbumPageFinder = find.byType('TopAlbumPage');
    final SerializableFinder topAlbumTitleFinder =
        find.text(searchAlbumTopAlbumsTitle);
    final SerializableFinder albumsWidgetFinder = find.byType('AlbumsWidget');
    final SerializableFinder specificAlbumFinder = find.descendant(
        of: albumsWidgetFinder,
        matching: find.text('The moment'),
        firstMatchOnly: true);
    final SerializableFinder likeButtonOfFirstAlbumFinder = find.descendant(
        of: albumsWidgetFinder,
        matching: likeButtonFinder,
        firstMatchOnly: true);
    final SerializableFinder albumDetailPageFinder =
        find.byType('AlbumDetailsPage');

    test("check driver status", () async {
      Health? health = await driver?.checkHealth();
      print(health?.status);
    });

    test("check homepage display", () async {
      expect(await driver?.getText(homePageAndAlbumDetailPageTitleFinder),
          homePageTitle);
      if (await driver?.getText(homePageDefaultTextFinder) != null) {
        expect(await driver?.getText(homePageDefaultTextFinder),
            homePageDefaultText);
      } else {
        expect(
            await driver?.getWidgetDiagnostics(albumsWidgetFinder), isNotEmpty);
      }
    });

    test("check redirection to search page", () async {
      await driver?.tap(searchIconFinder);
      await driver?.waitFor(find.text(searchHintText));
      expect(await driver?.getWidgetDiagnostics(searchPageFinder), isNotEmpty);
      expect(await driver?.getText(find.text(searchHintText)), searchHintText);
      expect(
          await driver?.getWidgetDiagnostics(searchInputBoxFinder), isNotEmpty);
    });

    test("check search with empty string", () async {
      await driver?.tap(searchInputBoxFinder);
      await driver?.enterText("");
      await driver?.tap(searchIconFinder);
      await driver?.waitUntilNoTransientCallbacks();
    });

    test("check search with specific artist name", () async {
      await driver?.tap(searchInputBoxFinder);
      await driver?.enterText(searchInputText);
      await driver?.tap(searchIconFinder);
      await driver?.waitUntilNoTransientCallbacks();
      await driver?.waitFor(find.text(searchResultArtistName));
      expect(
          await driver?.getWidgetDiagnostics(find.text(searchResultArtistName)),
          isNotEmpty);
    });

    test("check redirection to top album page", () async {
      await driver?.tap(find.text(searchResultArtistName));
      await driver?.waitForAbsent(find.text(searchInputText));
      expect(
          await driver?.getWidgetDiagnostics(topAlbumPageFinder), isNotEmpty);
      expect(await driver?.getText(topAlbumTitleFinder),
          searchAlbumTopAlbumsTitle);
    });

    test("check like album", () async {
      await driver?.waitFor(likeButtonOfFirstAlbumFinder);
      await driver?.tap(likeButtonOfFirstAlbumFinder);
    });

    test("check album detailed page", () async {
      await driver?.waitFor(specificAlbumFinder);
      await driver?.tap(specificAlbumFinder);
      expect(await driver?.getWidgetDiagnostics(albumDetailPageFinder),
          isNotEmpty);
      expect(await driver?.getText(homePageAndAlbumDetailPageTitleFinder),
          homePageTitle);
    });

    test("check back to top album page", () async {
      await driver?.tap(find.pageBack());
      await driver?.waitForAbsent(albumDetailPageFinder);
      expect(
          await driver?.getWidgetDiagnostics(topAlbumPageFinder), isNotEmpty);
    });

    test("check back to search page", () async {
      await driver?.tap(find.pageBack());
      await driver?.waitForAbsent(topAlbumPageFinder);
      expect(await driver?.getWidgetDiagnostics(searchPageFinder), isNotEmpty);
    });

    test("check back to homepage", () async {
      await driver?.tap(find.pageBack());
      await driver?.waitForAbsent(searchPageFinder);
      expect(await driver?.getWidgetDiagnostics(homePageFinder), isNotEmpty);
      expect(await driver?.getText(homePageAndAlbumDetailPageTitleFinder),
          homePageTitle);
      expect(await driver?.getWidgetDiagnostics(albumsWidgetFinder),
          isNotEmpty); // will throw err if multiple widget found
    });

    test("check unlike album", () async {
      await driver?.waitFor(likeButtonOfFirstAlbumFinder);
      await driver?.tap(likeButtonOfFirstAlbumFinder);
    });
  });
}
