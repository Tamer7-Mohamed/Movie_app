// characters_repository.dart

import 'package:movie/data/models/Characters.dart';
import '../services/characters_web_sarvices.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  // تعديل الدالة لتقبل رقم الصفحة كمتغير
  Future<List<Character>> getAllCharacters(int page) async {
    final characters = await charactersWebServices.getAllCharacters(page);
    return characters;
  }
}
