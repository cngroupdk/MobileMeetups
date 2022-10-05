import { NativeStackScreenProps } from '@react-navigation/native-stack';

import React from 'react';
import {
  Image,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { RootStackParamList } from '../types/navigation';

type DetailScreenProps = NativeStackScreenProps<RootStackParamList, 'Detail'>;

function DetailScreen({ route }: DetailScreenProps) {
  const { base_experience, height, weight, stats, sprites } = route.params;

  const statList = [
    {
      base_stat: base_experience,
      stat: { name: 'base experience' },
    },
    {
      base_stat: weight,
      stat: { name: 'weight' },
    },
    {
      base_stat: height,
      stat: { name: 'height' },
    },
    ...stats,
  ];

  return (
    <SafeAreaView>
      <ScrollView>
        <View style={styles.container}>
          <View style={styles.imageContainer}>
            <Image
              source={{ uri: sprites.front_default }}
              style={styles.image}
            />
          </View>
          <View style={styles.statContainer}>
            {statList?.map(({ base_stat, stat }) => (
              <View style={styles.stat} key={stat.name}>
                <Text style={styles.label}>{stat.name}</Text>
                <Text style={styles.value}>{base_stat}</Text>
              </View>
            ))}
          </View>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    height: '100%',
  },
  imageContainer: {
    flex: 1,
    backgroundColor: 'green',
    height: 250,
    marginBottom: 10,
    justifyContent: 'center',
    alignItems: 'center',
  },
  image: {
    width: 260,
    height: 260,
  },
  statContainer: {
    flex: 1,
    paddingHorizontal: 25,
  },
  stat: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    margin: 5,
  },
  label: {
    fontSize: 16,
    fontWeight: '700',
    color: 'gray',
    textTransform: 'capitalize',
  },
  value: {
    fontWeight: '700',
    color: 'black',
  },
});

export default DetailScreen;
