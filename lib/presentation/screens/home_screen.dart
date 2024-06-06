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
  List <Character>? searchedCharacters;
  bool isSearching = false;
  final  searchController = TextEditingController();


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
      itemCount: searchController.text.isEmpty ? allCharacters!.length : searchedCharacters!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(
          character: searchController.text.isEmpty? allCharacters![index]: searchedCharacters![index],
        );
      },
    );
  }


  Widget buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myMainGreen,
      decoration: const InputDecoration(
        hintText: 'Search for a character',
        hintStyle: TextStyle(color: MyColors.myMainGreen),
        border: InputBorder.none,

      ),
      onChanged: (searchedCharacter) {
        addSearchedCharactersToSearchedList(searchedCharacter);
      },
    );
  }


  void addSearchedCharactersToSearchedList(String searchedCharacter) {
    searchedCharacters = allCharacters!
        .where((character) =>
        character.name.toLowerCase().contains(searchedCharacter.toLowerCase()))
        .toList();
    setState(() {

    });
  }


  List <Widget> appBarAction( ) {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            searchController.clear();
            Navigator.pop(context);
            setState(() {
              isSearching = false;
            });
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [
         IconButton(
          onPressed: startSearching,
          icon: const Icon(Icons.search),
        ),
      ];
    }

  }

  void startSearching() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      isSearching = true;
    });
  }

void _stopSearching() {
    setState(() {
      searchController.clear();
      isSearching = false;
    });
}




Widget _buildAppBarTitle() {
    return const Text('Rick and Morty Characters',
        style: TextStyle(color: MyColors.myMainGreen));
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isSearching ? buildSearchField() : _buildAppBarTitle(),
          actions: appBarAction(),
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
