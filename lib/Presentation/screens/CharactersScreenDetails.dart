// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie/constants/my_colors.dart';
import '../../data/models/Characters.dart';

class CharactersScreenDetails extends StatelessWidget {
  const CharactersScreenDetails({Key? key, required this.character})
      : super(key: key);
  final Character character;
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: const TextStyle(
            color: MyColors.myWhite,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          //textAlign: TextAlign.start,
        ),
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget CharacterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
              text: value,
              style: const TextStyle(
                color: MyColors.myWhite,
                fontSize: 18,
              ))
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterInfo('Gender : ', character.gender),
                  buildDivider(303),
                  CharacterInfo('Status : ', character.status),
                  buildDivider(308),
                  CharacterInfo('Species : ', character.species),
                  buildDivider(295),
                  CharacterInfo('Location : ', character.location),
                  buildDivider(290),
                  character.type.isEmpty
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CharacterInfo('Type : ', character.type),
                            buildDivider(320)
                          ],
                        ),
                  CharacterInfo('Origin : ', character.origin),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 500,
            ),
          ])),
        ],
      ),
    );
  }
}
