# Create Intent Extension

## App Setup

Before your extension can handle the relevant intent, it needs a couple of pre-requisites.

1. Your app needs the `Communication Notifications` capability. You can add it in the `Signing & Capabilities` of your app's target.

2. Notifications permission. You'll need to use another package to request the user's permission to send notifications. We recommend [@react-native-community/push-notification-ios](https://github.com/react-native-push-notification/ios).

3. Focus permission. You can request this permission using `requestAuthorization()`.

## Create Intents Extension target

To create an Intent Extension, open your project's `.xcworkspace` in Xcode.

Go to `File -> New -> Target... -> Intents Extension`

Create your Share Extension (preferably in Objective-C, otherwise you'll need to create a Bridging Header).

## Install required Cocoapods

Open your project's `Podfile` and add the following:

```ruby
target '<YOUR_EXTENSION_TARGET_NAME>' do
    pod 'react-native-focus/Extension', :path => '../..'
end
```

Run `pod install` on the `ios/` folder.

## Handle Focus Status Intent

Open your Extension's `Info.plist` and add the following:

```plist
<key>NSExtension</key>
<dict>
    <key>NSExtensionAttributes</key>
    <dict>
        <key>IntentsRestrictedWhileLocked</key>
        <array/>
        <key>IntentsSupported</key>
        <array>
            <string>INShareFocusStatusIntent</string>
        </array>
    </dict>
    <key>NSExtensionPointIdentifier</key>
    <string>com.apple.intents-service</string>
    <key>NSExtensionPrincipalClass</key>
    <string>IntentHandler</string>
</dict>
```

**Without this your Extension won't be alerted about Focus Status changes, therefore the JS listener will not work as well.**

## App Group Setup

For the Extension to be able to relay events to your app, you need to add an App Group to your App and Extension targets.

To do so, open your App Target Settings > Signing & Capabilities > + Capability > App Groups.

Then add a new App Group with the following format: `group.<YOUR_BUNDLE_ID>.RNFocus` (e.g. `group.com.example.reactnativefocus.RNFocus`).

**Repeat this step for your Extension!**

## Handle Intent

To handle the intent you first need to tell iOS that your extension handles the `INShareFocusStatusIntent`.

To do so, open your Extension's `Info.plist` and add `INShareFocusStatusIntent` to `NSExtension -> NSExtensionAttributes -> IntentsSupported`.

Open `IntentHandler.m` and add the following code:

```objc
// IntentHandler.m

#import <react-native-focus/FocusStatusIntentHandler.h>

// (...)

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    (...)

    if ([intent isKindOfClass:[INShareFocusStatusIntent class]]) {
        return [[FocusStatusIntentHandler alloc] init];
    }

    (...)
}
```

## Warning

**Your JS listener will only be called if the app is open.**

It is recommended you handle any important business logic natively in the Extension.

If you have important logic that needs to happen as soon as the Focus Status changes, you should handle so in Obj-C/Swift.

Instead, use the JS listener for any front-end only interactions that need to happen (e.g. telling the user they currently have Focus active and might not receive notifications).
