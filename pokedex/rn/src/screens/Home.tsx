import React, { useEffect, useState } from 'react';
import {
  ActivityIndicator,
  SafeAreaView,
  ScrollView,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import PokemonTile from '../components/PokemonTile';
import api from '../services/api';
import { Pokemon } from '../types/pokemon';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { RootStackParamList } from '../types/navigation';
import Search from '../components/Search';

type HomeScreenProps = NativeStackScreenProps<RootStackParamList, 'Pokemon'>;

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'flex-start',
  },
  searchInputContainer: {
    justifyContent: 'center',
    paddingHorizontal: 20,
    paddingVertical: 10,
  },
  input: {
    backgroundColor: 'white',
    borderRadius: 10,
    paddingHorizontal: 15,
    height: 40,
  },
});

function HomeScreen({ navigation }: HomeScreenProps) {
  const [pokemonList, setPokemonList] = useState<Pokemon[]>([]);
  const [searchPhrase, setSearchPhrase] = useState('');

  useEffect(() => {
    const fetchPokemonDetailedItem = async (pokemonName: string) => {
      const { data } = await api.get(pokemonName);

      return data;
    };

    const fetchPokemonRawList = async () => {
      await api
        .get('/?offset=0&limit=50')
        .then(({ data }) => {
          const results = data.results;
          const promisesArray = results.map(({ name }: Pick<Pokemon, 'name'>) =>
            fetchPokemonDetailedItem(name).then(response => response),
          );

          return Promise.all(promisesArray);
        })
        .then(data => setPokemonList(data));
    };

    fetchPokemonRawList();
  }, []);

  const handleItemPress = (data: Pokemon) => {
    navigation.navigate('Detail', data);
  };

  const getFilteredPokemonList = () =>
    pokemonList?.filter(pokemon => {
      const pokemonName = pokemon.name.toLowerCase();
      const trimedSearchPhrase = searchPhrase
        .toLowerCase()
        .trim()
        .replace(/\s/g, '');

      if (pokemonName.includes(trimedSearchPhrase)) {
        return pokemon;
      }
    });

  const pokemonFilteredList =
    searchPhrase && searchPhrase.length > 2
      ? getFilteredPokemonList()
      : pokemonList;

  return (
    <SafeAreaView>
      <ScrollView>
        <Search searchPhrase={searchPhrase} setSearchPhrase={setSearchPhrase} />
        <View style={styles.container}>
          {!pokemonFilteredList.length && (
            <View>
              <ActivityIndicator size="small" color="green" />
            </View>
          )}
          {pokemonFilteredList?.map(pokemon => {
            return (
              <PokemonTile
                key={pokemon?.id}
                data={pokemon}
                onPress={handleItemPress}
              />
            );
          })}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
}

export default HomeScreen;
