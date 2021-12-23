import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import {
  requestAuthorization,
  AuthorizationStatus,
  addFocusStatusChangeListener,
  getCurrentFocusStatus,
} from 'react-native-focus';

export default function App() {
  const [authorization, setAuthorization] = React.useState<
    AuthorizationStatus | undefined
  >();
  const [focused, setFocused] = React.useState<boolean | undefined>(
    getCurrentFocusStatus()
  );

  const authorizationText = React.useMemo(() => {
    switch (authorization) {
      case AuthorizationStatus.Authorized:
        return 'Authorized';
      case AuthorizationStatus.Denied:
        return 'Denied';
      case AuthorizationStatus.NotDetermined:
        return 'Not Determined';
      case AuthorizationStatus.Restricted:
        return 'Restricted';
    }
  }, [authorization]);

  React.useEffect(() => {
    requestAuthorization().then(setAuthorization);
  }, []);
  React.useEffect(() => {
    const unsubscribe = addFocusStatusChangeListener(setFocused);

    return () => {
      unsubscribe();
    };
  }, []);

  return (
    <View style={styles.container}>
      <Text>Authorization: {authorizationText}</Text>
      <Text>Status: {focused ? 'Focused' : 'Not Focused'}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
