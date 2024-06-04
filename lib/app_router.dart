import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic/cubit/character_cubit.dart';
import 'package:rickandmorty/data/repo/charactersrepo.dart';
import 'package:rickandmorty/data/web_services/character_web_ser.dart';
import 'package:rickandmorty/presentation/screens/character_screen.dart';
import 'package:rickandmorty/presentation/screens/home_screen.dart';

import 'constants/strings.dart';
import 'presentation/screens/character_details_screen.dart';

class AppRouter {
  late CharacterRepo characterRepo;
  late CharacterCubit characterCubit;

  AppRouter() {
    characterRepo = CharacterRepo(CharacterWebSer());
    characterCubit = CharacterCubit(characterRepo);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => characterCubit,
            child: const HomeScreen(),
          ),
        );
      case '/character':
        return MaterialPageRoute(
          builder: (_) => const CharacterScreen(),
        );
      case '/character details':
        return MaterialPageRoute(
            builder: (_) => const CharacterDetailsScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
