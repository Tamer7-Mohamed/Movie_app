// ignore_for_file: library_private_types_in_public_api, prefer_final_fields, unused_field, unused_element, unnecessary_const, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/Characters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allcharacters = [];
  late List<Character> searchForCharacter = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allcharacters = state.characters;
          return buildLoadedListWidget();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount:
          _isSearching ? searchForCharacter.length : allcharacters.length,
      itemBuilder: (ctx, index) {
        final character =
            _isSearching ? searchForCharacter[index] : allcharacters[index];
        return CharacterItem(character: character);
      },
    );
  }

  Widget _buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        title: _isSearching ? BuildSearchField() : _buildAppBarTitle(),
        actions: _buildApparActoins(),
        centerTitle: true,
      ),
      body: buildBlocWidget(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            backgroundColor:
                MyColors.myYellow.withOpacity(0.5), // جعل اللون شفافًا
            elevation: 0,
            onPressed: () {
              _getBackPage();
            },
            tooltip: 'Back Page',
            child: const Icon(Icons.arrow_back),
          ),
          FloatingActionButton(
            backgroundColor:
                MyColors.myYellow.withOpacity(0.5), // جعل اللون شفافًا
            onPressed: () {
              _getNextPage();
            },
            tooltip: 'Next Page',
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget BuildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a Character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: addSearchedForItemToSearchedList,
    );
  }

  void addSearchedForItemToSearchedList(String searchedCharacter) {
    setState(() {
      searchForCharacter = allcharacters
          .where((character) =>
              character.name.toLowerCase().startsWith(searchedCharacter))
          .toList();
    });
  }

  void _ClearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  List<Widget> _buildApparActoins() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _ClearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void _getNextPage() {
    BlocProvider.of<CharactersCubit>(context).nextPage();
  }

  void _getBackPage() {
    BlocProvider.of<CharactersCubit>(context).backPage();
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _ClearSearch();
    setState(() {
      _isSearching = false;
    });
  }
}
