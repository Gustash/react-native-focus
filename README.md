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

```ts
import { requestAuthorization, } from "react-native-focus";

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

## API

### `AuthorizationStatus`

```ts
enum AuthorizationStatus {
  NotDetermined = 0,
  Restricted = 1,
  Denied = 2,
  Authorized = 3,
}
```

### `requestAuthorization()`

Request the user for authorization to access the current focus status.

**Returns**

`Promise<AuthorizationStatus>` - The authorization status the user has chosen.

**Example**

```ts
import {requestAuthorization} from 'react-native-focus';

// ...

const status = await requestAuthorization();
```

### `getCurrentFocusStatus()`

Get the current focus status.

Needs to have called `requestAuthorization()` and received `AuthorizationStatus.Authorized`, first.

This will not be updated when the focus status changes. You should use this for initialization only. Refer to CHANGEME

**Returns**

`boolean` - Whether or not focus is currently enabled.

**Example**

```ts
import {getCurrentFocusStatus} from 'react-native-focus';

const isFocused = getCurrentFocusStatus();
```

### `addFocusStatusChangeListener(listener: (isFocused: boolean) => void)`

Registers a listener that will get called whenever the focus status has changed.

Needs to have called `requestAuthorization()` and received `AuthorizationStatus.Authorized`, first.

Needs the Intents Extension to have been setup. Refer to CHANGEME

**Arguments**

`listener` - The callback to call when focus status changes. Takes a `boolean` as an argument, with whether or not focus is enabled.

**Returns**

`() => void` - Callback to remove the the listener.

**Example**

```ts
import {addFocusStatusChangeListener} from 'react-native-focus';

const listener = (isFocused: boolean) => {
  console.log('Focus is:', isFocused ? 'Enabled' : 'Disabled');
};

const removeListener = addFocusStatusChangeListener(listener);

// When done with listener, or in clean-up.
removeListener();
```

### App

Info.plist -> NSFocusStatusUsageDescription

Needs Notification permissions
Needs Communication Notifications entitlement

### Workspace

Need to implement dynamic app groups

## License

GNU GPLv3
