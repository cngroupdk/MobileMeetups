import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import HomeScreen from '../screens/Home';
import DetailScreen from '../screens/Detail';
import { RootStackParamList } from '../types/navigation';

function RootNavigator() {
  const { Navigator, Screen } =
    createNativeStackNavigator<RootStackParamList>();

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
        <Screen
          name="Detail"
          options={({ route }) => {
            const name = route?.params.name;
            const firstCharacter = name.charAt(0).toUpperCase();
            const title = `${firstCharacter}${name.slice(1)}`;

            return {
              title,
              headerLargeTitle: true,
            };
          }}
          component={DetailScreen}
        />
      </Navigator>
    </NavigationContainer>
  );
}

export default RootNavigator;
