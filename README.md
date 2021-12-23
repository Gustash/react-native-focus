# react-native-focus

Get iOS Focus status information in React Native

## Installation

```sh
npm install react-native-focus
```

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
