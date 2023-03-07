# Installment Preparation Work

## System requirements

 - [ ] Flutter sdk
 - [ ] Xcode
 - [ ] CocoaPods
 - [ ] Android Studio
 - [ ] Android SDK
 - [ ] VSCode


 **1. Get flutter sdk for macOs**
 - download sdk from [here](https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.7.6-stable.zip)
 - unzip file under target path
	```
	unzip ~/Downloads/flutter_macos_3.7.6-stable.zip
	```
 - config path varuable
	```
	export PATH="$PATH:$HOME/flutter/bin"
	source ~/.bash_profile
	```
- verify flutter availability
	```
	 which flutter
	```
- run `flutter doctor` cmd to check other dependencies

## Troubleshooting
1. `File.create`overridden err
	> The method 'File.create' has fewer named arguments than those of overridden method 'File.create'.
	- Resolved by run `flutter pub upgrade`

2. Cocoapods not installed
	- Resolved by run `brew install cocoapods`

3. Android SDK install issue
	 - Resolved by conduct following steps
		 - Open Android Studio and click on '_more actions_' on the welcome screen.
		-   Click on '_SDK Manager_'
		-   In the '*Preferences' window go to the '*SDK Tools•' tab
		-   Select the '_Android SDK Command-line Tools (latest)_' checkbox.
		-   Click on '_Apply_'.
![enter image description here](https://i.stack.imgur.com/PQEmK.png)![enter image description here](https://i.stack.imgur.com/qI4lQ.png)
	 

Reference doc: 
https://docs.flutter.dev/get-started/install/macos#update-your-path
