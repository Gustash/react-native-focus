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

## Handle Intent

To handle the intent you first need to tell iOS that your extension handles the `INShareFocusStatusIntent`.

To do so, open your Extension's `Info.plist` and add `INShareFocusStatusIntent` to `NSExtension -> NSExtensionAttributes -> IntentsSupported`.

Open `IntentHandler.h` and change the interface to the following:

```objc
// IntentHandler.h

@interface IntentHandler : INExtension <INShareFocusStatusIntentHandling>
```

Open `IntentHandler.m` and add the following code:

```objc
// IntentHandler.m

#import <react-native-focus/FocusStatusIntentHandler.h>

// (...)

@interface IntentHandler (FocusStatus) <INShareFocusStatusIntentHandling>

@end

@implementation IntentHandler (FocusStatus)

- (void)handleShareFocusStatus:(INShareFocusStatusIntent *)intent
                    completion:(void (^)(INShareFocusStatusIntentResponse * _Nonnull))completion
{
  [FocusStatusIntentHandler handleShareFocusStatus:intent completion:completion];
}
```

## TODO: Document App Groups

## Warning

**Your JS listener will only be called if the app is open.**

It is recommended you handle any important business logic natively in the Extension.

If you have important logic that needs to happen as soon as the Focus Status changes, you should handle so in Obj-C/Swift.

Instead, use the JS listener for any front-end only interactions that need to happen (e.g. telling the user they currently have Focus active and might not receive notifications).