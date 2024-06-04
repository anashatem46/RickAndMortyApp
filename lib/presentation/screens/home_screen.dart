import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/business_logic/cubit/character_cubit.dart';
import 'package:rickandmorty/constants/colors.dart';

import '../../data/models/characters.dart';
import '../widgets/character_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Character>? allCharacters;

  @override
  void initState() {
    super.initState();
        BlocProvider.of<CharacterCubit>(context).fetchAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLodingIndicator();
      }
    });
  }

  Widget showLodingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myMainGreen,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
        child: Column(children: [buildCharacterList()]));
  }

  Widget buildCharacterList() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: allCharacters!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(
          character: allCharacters![index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rick and Morty Characters',
              style: TextStyle(color: MyColors.myMainGreen),),
        ),
        body: buildBlocWidget(),
        bottomNavigationBar:
            BottomNavigationBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
        ], selectedItemColor: MyColors.myBlue));
  }
}
