import { NativeModules, Platform, NativeEventEmitter } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-focus' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const Focus = NativeModules.Focus
  ? NativeModules.Focus
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );
const Emitter = new NativeEventEmitter(Focus);

export enum AuthorizationStatus {
  NotDetermined = 0,
  Restricted = 1,
  Denied = 2,
  Authorized = 3,
}

export function requestAuthorization(): Promise<AuthorizationStatus> {
  return Focus.requestAuthorization();
}

export function getCurrentFocusStatus(): boolean {
  return Focus.getCurrentFocusStatus();
}

type RemoveListener = () => void;
export type FocusStatusChangedCallback = (isFocused: boolean) => void;
export function addFocusStatusChangeListener(
  callback: FocusStatusChangedCallback
): RemoveListener {
  const subscription = Emitter.addListener('status', callback);

  return () => {
    subscription.remove();
  };
}
