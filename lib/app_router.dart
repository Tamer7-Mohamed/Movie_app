import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Presentation/screens/CharactersScreenDetails.dart';
import 'Presentation/screens/characters_screen.dart';
import 'business_logic/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data/models/Characters.dart';
import 'data/repository/characters_repository.dart';
import 'data/services/characters_web_sarvices.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (_) => CharactersScreenDetails(character: character),
        );
    }
    return null;
  }
}
