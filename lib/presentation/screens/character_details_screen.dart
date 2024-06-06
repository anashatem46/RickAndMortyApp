import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/colors.dart';
import 'package:rickandmorty/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});

Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,

        title: Text(
          character.name,
          style: const TextStyle(
            color: MyColors.myYellow,
            fontSize: 20,
          ),
        ),
        background: Image.network(
          character.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       slivers: [
         buildSliverAppBar(),
       ]
     ));
  }
}


