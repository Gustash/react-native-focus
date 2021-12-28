# react-native-focus

Get iOS Focus status information in React Native

## WIP

This package is still a WIP and not ready for production use!

## Installation

```sh
npm install react-native-focus
```

or


```sh
yarn add react-native-focus
```

## Linking

This package auto-links to your main Target. You **need** to create an `Intent Extension` to use the focus status listener.

Follow [these instructions](./CREATE_INTENTS_EXTENSION.md) to get that setup.

Run `pod install` on your `ios/` folder.

## Usage

```js
import { multiply } from "react-native-focus";

// ...

const result = await multiply(3, 7);
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## TODO

### Extension

Info.plist -> INShareFocusStatusIntent
Needs `react-native-focus/Extension` pod in Podfile target

```objc
- (void)handleShareFocusStatus:(nonnull INShareFocusStatusIntent *)intent
                    completion:(nonnull void (^)(INShareFocusStatusIntentResponse * _Nonnull))completion {
  [FocusStatusIntentHandler handleShareFocusStatus:intent completion:completion];
}
```

### App

Info.plist -> NSFocusStatusUsageDescription

Needs Notification permissions
Needs Communication Notifications entitlement

### Workspace

Need to implement dynamic app groups

## License

GNU GPLv3
