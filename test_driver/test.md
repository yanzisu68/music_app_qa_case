# Integration Test

 ### Run App
 - Using Android studio to open project
 - Double click to open `lib/main.dart` , select simulator to run App. Automatically open Xcode simulator to open App in ios simulator
 ---
 ### Check App main function
	 - Homepage
		 - click seach icon > redirect to search page
	 - Search Page
		 - search with input text
		 - display search result in block
		 - click specific card > redirect to top album page of specific artist
	- Top Album Page
		- click specific album card > redirect to Album Detail Page
		- click like button > add album into like list
		- click like button again > remove album from like list
		- click some album cannot be added > toast err msg
	- Album Detail Page
		- display detailed info for this album
	- click page back button > redirect to last page
---
 ### Write Integration Test
- Setup by adding the `flutter_driver` to your `pubspec.yaml` 
	```
	dev_dependencies:
       flutter_driver:
         sdk: flutter
	```
- create `test_driver`folder under project root path
	- first create `app.dart` file to call run app main func
	- then create `app_test.dart` file to write tests
---
### Troubleshooting
|Nr.|Issue| Root Cause |Fix Action |
|--|--|--|--|
| 1 | package outdated |  |get the latest package by run `flutter package get`|
| 2 | Nullable local variable must assigned before used |  |`FlutterDriver? driver;`|
| 3 | Flutter Driver crashing when main has async operations |The problem is the app may not be fully initialized since the awaited call could still be in flight. |resolved by adding `await driver?.waitUntilFirstFrameRasterized();` right after connect|
| 4 | API 400 error but actually same cURL works in postman |auto-generated code will pass extra header value in request header → which leads to 400 bad request error  |change to use `dio().get()` to send out request.|
| 5 | assert getWidgetDiagnostics throw err |when multiple widgets can be found for same finder condition, will throw error. Example: `expect(await driver?.getWidgetDiagnostics(albumsWidgetFinder), isNotEmpty);`|can only use for 1 widget case|
| 6 | how to go back to previous page when without back button ||use `await driver.tap(find.pageBack());`|
| 7 | how to get one of the elements if the finder matched more than one |flutter driver limitation, cannot support to get first, lat, and any index of element like flutter_test in widget test|using `descendant` to find the first element. Example: `final SerializableFinder likeButtonOfFirstAlbumFinder = find.descendant( of: albumsWidgetFinder, matching: likeButtonFinder, firstMatchOnly: true);`|
| 6 |Fultter_test package throw err|`import 'package:flutter_test/flutter_test.dart';` cannot be used for integration test, only valid for widget test|should use this package `import 'package:test/test.dart';` |
| 7 | How to calculate widget count?||pending check|
| 7 | How to test flutter toast msg?||pending check|


