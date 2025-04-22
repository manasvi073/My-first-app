import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/chapter_model.dart';
import 'package:scary_teacher2/models/character_model.dart';
import 'package:scary_teacher2/models/hedden_secret_model.dart';
import 'package:scary_teacher2/models/weapons_model.dart';
import 'package:scary_teacher2/screens/chapters_screen.dart';
import 'package:scary_teacher2/screens/characters_screen.dart';
import 'package:scary_teacher2/screens/costume_screen.dart';
import 'package:scary_teacher2/screens/hedden_secret_screen.dart';
import 'package:scary_teacher2/screens/rewards_screen.dart';
import 'package:scary_teacher2/screens/weapons_screen.dart';

class HomeController extends GetxController {
  // int? selectedIndex;
  RxInt selectedIndex = (-1).obs;

  var characterList = <CharacterModel>[].obs;
  var weaponsList = <WeaponsModel>[].obs;
  var chapterList = <ChaptersModel>[].obs;
  var heddensecretList=<HeddensecretModel>[].obs;

  final box = GetStorage();
  var favoriteCharacters = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCharacters();
    loadWeapons();
    loadChapters();
    loadheddendata();
    loadFavorites();
  }

  void onItemTap(int index) {
    selectedIndex.value = index;
    final screenData = items[index]['screen'];
    Get.to(screenData);
  }

  // ................Home Screen Data...................

  final List<Map<String, dynamic>> items = [
    {
      'image': ImageConstant.appCharacter,
      'title': 'Characters',
      'screen': () => const CharactersScreen(),
    },
    {
      'image': ImageConstant.appWeapons,
      'title': 'Weapons',
      'screen': () => const WeaponsScreen(),
    },
    {
      'title': 'Chapters',
      'image': ImageConstant.appChapters,
      'screen': () => const ChaptersScreen(),
    },
    {
      'title': 'Hidden Secrets',
      'image': ImageConstant.appHeddenSecrets,
      'screen': () => const HeddenSecretScreen(),
    },
    {
      'title': 'Rewards',
      'image': ImageConstant.appReward,
      'screen': () => const RewardsScreen(),
    },
    {
      'title': 'Costume',
      'image': ImageConstant.appCostume,
      'screen': () => const CostumeScreen(),
    },
  ];

  // ................Characters Screen...................

  Future<void> loadCharacters() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/character.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      characterList.value =
          data.map((json) => CharacterModel.fromJson(json)).toList();
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

  void loadFavorites() {
    List<dynamic>? storedFavorites = box.read<List<dynamic>>('favorites');
    if (storedFavorites != null) {
      favoriteCharacters.value = storedFavorites.map((e) {
        if (e is Map<String, dynamic>) {
          return e['name'] as String;
        } else if (e is String) {
          return e;
        }
        return '';
      }).toList();
    } else {
      favoriteCharacters.value = [];
    }
  }

  void toggleFavorite(CharacterModel character) {
    Map<String, dynamic> favoriteItem = {
      "name": character.name,
      "image": character.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == character.name);

    if (index != -1) {
      favorites.removeAt(index);
      favoriteCharacters.remove(character.name);
    } else {
      favorites.add(favoriteItem);
      favoriteCharacters.add(character.name!);
    }

    box.write('favorites', favorites);
    log('Favorites Data -> $favorites');
  }

  // ................Weapons Screen...................

  Future<void> loadWeapons() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/weapons.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);

      weaponsList.value =
          data.map((json) => WeaponsModel.fromJson(json)).toList();
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

  void toggleFavorites(WeaponsModel weaponFav) {
    Map<String, dynamic> favoriteItem = {
      "name": weaponFav.name,
      "image": weaponFav.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == weaponFav.name);

    if (index != -1) {
      favorites.removeAt(index);
      favoriteCharacters.remove(weaponFav.name);
    } else {
      favorites.add(favoriteItem);
      favoriteCharacters.add(weaponFav.name!);
    }

    box.write('favorites', favorites);
    log('Favorites Data -> $favorites');
  }

// ................chapters Screen...................

  Future<void> loadChapters() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/chapters.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);

      chapterList.value =
          data.map((json) => ChaptersModel.fromJson(json)).toList();
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

  void toggleFavoriteChapter(ChaptersModel chapter) {
    Map<String, dynamic> favoriteItem = {
      "name": chapter.name,
      "image": chapter.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == chapter.name);

    if (index != -1) {
      favorites.removeAt(index);
      favoriteCharacters.remove(chapter.name);
    } else {
      favorites.add(favoriteItem);
      favoriteCharacters.add(chapter.name!);
    }

    box.write('favorites', favorites);
    log('Favorites Data -> $favorites');
  }

//   ..............Hedden secret screen....................

  Future<void> loadheddendata() async {
    try {
      final String response =
      await rootBundle.loadString('assets/json/hedden_secrets.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);

        heddensecretList.value =
            data.map((json) => HeddensecretModel.fromJson(json)).toList();

    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

}
