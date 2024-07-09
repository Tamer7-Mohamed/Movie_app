

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/Characters.dart';
import '../../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<Character> characters = [];
  int currentPage = 1;
  bool isFirstPage = true;
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    try {
      final List<Character> characters =
          await charactersRepository.getAllCharacters(currentPage);
      emit(CharactersLoaded(characters));
      this.characters = characters;
      isFirstPage = currentPage == 1;
    } catch (e) {
      print('Failed to load characters: $e');
    }
  }

  void backPage() {
    if (!isFirstPage) {
      currentPage--;
      getAllCharacters();
    }
  }

  void nextPage() {
    currentPage++;
    getAllCharacters();
  }
}
