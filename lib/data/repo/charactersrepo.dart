import 'dart:developer';

import 'package:rickandmorty/data/models/characters.dart';
import 'package:rickandmorty/data/web_services/character_web_ser.dart';

class CharacterRepo {
  final CharacterWebSer characterWebSer;

  CharacterRepo(this.characterWebSer);

  Future<List<Character>> getCharactersInRepo() async {
    final characters = await characterWebSer.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
