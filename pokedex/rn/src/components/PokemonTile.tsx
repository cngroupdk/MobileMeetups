import React from 'react';
import { Image, StyleSheet, Text, TouchableOpacity, View } from 'react-native';
import { Pokemon } from '../types/pokemon';

type PokemnTitleProps = {
  data: Pokemon;
  onPress: (data: Pokemon) => void;
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    minWidth: 180,
    maxWidth: 180,
    height: 80,
    flexDirection: 'row',
    padding: 10,
    margin: 5,
    backgroundColor: '#E6E7EB',
    borderRadius: 10,
  },
  content: {
    flex: 2,
    alignSelf: 'flex-start',
  },
  label: {
    textTransform: 'capitalize',
    fontSize: 16,
    fontWeight: '700',
    color: 'black',
    marginBottom: 2,
  },
  numberContainer: {
    width: 20,
    borderRadius: 10,
    backgroundColor: '#D3D3D3',
    alignItems: 'center',
    justifyContent: 'center',
  },
  number: {
    fontSize: 10,
    fontWeight: '700',
  },
  imageContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'flex-end',
  },
  image: {
    width: 60,
    height: 60,
  },
});

function PokemonTile({ data, onPress }: PokemnTitleProps) {
  const { id, name, sprites } = data;

  return (
    <TouchableOpacity onPress={() => onPress(data)} style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.label}>{name}</Text>
        <View style={styles.numberContainer}>
          <Text style={styles.number}>{id}</Text>
        </View>
      </View>
      <View style={styles.imageContainer}>
        <Image source={{ uri: sprites.front_default }} style={styles.image} />
      </View>
    </TouchableOpacity>
  );
}

export default PokemonTile;
