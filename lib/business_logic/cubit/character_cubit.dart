import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/data/models/characters.dart';
import 'package:rickandmorty/data/repo/charactersrepo.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepo characterRepo;
  List<Character> characters = [];

  CharacterCubit(this.characterRepo) : super(CharacterInitial());

  List<Character> fetchAllCharacters() {
    characterRepo.getCharactersInRepo().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
}
