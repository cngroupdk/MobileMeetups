import React, { Dispatch, SetStateAction } from 'react';
import { StyleSheet, TextInput, View } from 'react-native';

type SearchProps = {
  searchPhrase: string;
  setSearchPhrase: Dispatch<SetStateAction<string>>;
};

const styles = StyleSheet.create({
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

function Search({ searchPhrase, setSearchPhrase }: SearchProps) {
  return (
    <View style={styles.searchInputContainer}>
      <TextInput
        style={styles.input}
        placeholder="Search"
        value={searchPhrase}
        onChangeText={setSearchPhrase}
      />
    </View>
  );
}

export default Search;
