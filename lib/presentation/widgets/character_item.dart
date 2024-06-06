import 'package:flutter/material.dart';
import 'package:rickandmorty/constants/colors.dart';
import 'package:rickandmorty/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: Container(
        margin: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),

          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(4),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/character details', arguments: character);
            },
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(
                  character.name,
                  style: const TextStyle(color: MyColors.myYellow, fontSize: 20),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              child: Image.network(character.image, fit: BoxFit.cover),
            ),
          )),
    );
  }
}
