// characters_web_sarvices.dart

import 'package:dio/dio.dart';
import 'package:movie/data/models/Characters.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api/',
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  // تعديل الدالة لتقبل رقم الصفحة كمتغير
  Future<List<Character>> getAllCharacters(int page) async {
    try {
      Response response = await dio.get('character?page=$page');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['results'];
        return data.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }
}
