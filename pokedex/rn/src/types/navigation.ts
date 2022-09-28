import { Stat, Sprites } from './pokemon';

export type RootStackParamList = {
  Pokemon: undefined;
  Detail: {
    base_experience: number;
    height: number;
    weight: number;
    stats: Stat[];
    name: string;
    sprites: Sprites;
  };
};
