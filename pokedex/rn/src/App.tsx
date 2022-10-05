import React from 'react';
import { StatusBar } from 'react-native';
import RootNavigator from './navigations/index';

const App = (): JSX.Element => (
  <>
    <StatusBar barStyle="light-content" />
    <RootNavigator />
  </>
);

export default App;
