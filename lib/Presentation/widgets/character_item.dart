import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/Characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({Key? key, required this.character}) : super(key: key);
  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
            arguments: character),
        child: GridTile(
          header: Center(
            child: Text(
              character.id.toString(),
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          footer: Hero(
            tag: Text(
              character.id.toString(),
              style: const TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                character.name,
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          child: Container(
            color: MyColors.myGrey,
            child: character.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/ph.jpeg',
                    image: character.image,
                  )
                : const Icon(Icons.image_aspect_ratio_outlined),
          ),
        ),
      ),
    );
  }
}
