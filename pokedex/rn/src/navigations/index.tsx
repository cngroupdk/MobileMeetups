import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import HomeScreen from '../screens/Home';

function RootNavigator() {
  const {Navigator, Screen} = createNativeStackNavigator();

  return (
    <NavigationContainer>
      <Navigator initialRouteName="Pokemon">
        <Screen
          name="Pokemon"
          options={{
            headerLargeTitle: true,
          }}
          component={HomeScreen}
        />
      </Navigator>
    </NavigationContainer>
  );
}

export default RootNavigator;
