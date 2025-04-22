import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/chapter_model.dart';
import 'package:scary_teacher2/models/character_model.dart';
import 'package:scary_teacher2/models/costume_model.dart';
import 'package:scary_teacher2/models/hedden_secret_model.dart';
import 'package:scary_teacher2/models/reward_model.dart';
import 'package:scary_teacher2/models/weapons_model.dart';
import 'package:scary_teacher2/screens/chapters_screen.dart';
import 'package:scary_teacher2/screens/characters_screen.dart';
import 'package:scary_teacher2/screens/costume_screen.dart';
import 'package:scary_teacher2/screens/getstarted_screen.dart';
import 'package:scary_teacher2/screens/hedden_secret_screen.dart';
import 'package:scary_teacher2/screens/rewards_screen.dart';
import 'package:scary_teacher2/screens/weapons_screen.dart';

class HomeController extends GetxController {
  RxInt selectedIndex = (-1).obs;
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();

  var characterList = <CharacterModel>[].obs;
  var weaponsList = <WeaponsModel>[].obs;
  var chapterList = <ChaptersModel>[].obs;
  var heddensecretList = <HeddensecretModel>[].obs;
  var rewardList = <RewardModel>[].obs;
  var costumeList = <CostumeModel>[].obs;

  final box = GetStorage();
  var favoriteCharacters = <String>[].obs;

  bool isNotificationOn = true;

  @override
  void onInit() {
    super.onInit();
    loadCharacters();
    loadWeapons();
    loadChapters();
    loadheddendata();
    loadRewardData();
    loadCostumeData();
    loadFavorites();
  }

  void onItemTap(int index) {
    selectedIndex.value = index;
    final screenData = items[index]['screen'];
    Get.to(screenData);
  }

  // ..................onboarding Screen.............

  final List<Map<String, String>> onboardingData = [
    {
      'image': ImageConstant.appOnboarding1Logo,
      'title': 'Meet the Cast!',
      'description':
          'Discover the mischievous teacher and her tricky students. Each character has unique skills—use them wisely!',
    },
    {
      'image': ImageConstant.appOnboarding2Logo,
      'title': 'Gadgets & Traps!',
      'description':
          'From slingshots to stink bombs, explore fun weapons to prank the scary teacher. Choose the best tool for the job!',
    },
    {
      'image': ImageConstant.appOnboarding3Logo,
      'title': 'Dress to Trick!',
      'description':
          'Unlock crazy costumes to disguise yourself. Blend in or stand out-your choice, your prank!',
    },
  ];

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      pageController.animateToPage(
        currentIndex.value + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.off(() => const GetStartedScreen());
    }
  }

  // ..............Setting Screen......................

  final List<Map<String, dynamic>> settingsOptions = [
    {
      'icon': ImageConstant.appNotifications,
      'title': 'Notifications',
      'isToggle': true,
    },
    {
      'icon': ImageConstant.appFavorite,
      'title': 'Favorites',
    },
    {
      'icon': ImageConstant.appShare,
      'title': 'Share Us',
    },
    {
      'icon': ImageConstant.appRate,
      'title': 'Rate Us',
    },
    {
      'icon': ImageConstant.appPrivacy,
      'title': 'Privacy Policy',
    }
  ];

  // ................Home Screen Data...................

  final List<Map<String, dynamic>> items = [
    {
      'image': ImageConstant.appCharacter,
      'title': 'Characters',
      'screen': () => CharactersScreen(),
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

// ..............Rewards screen..................

  Future<void> loadRewardData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/rewards.json');
      final List<dynamic> data = json.decode(response);

      rewardList.value =
          data.map((json) => RewardModel.fromJson(json)).toList();
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error loading JSON: $e');
    }
  }

//   ................Costume screen.................

  Future<void> loadCostumeData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/costumes.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);

      costumeList.value =
          data.map((json) => CostumeModel.fromJson(json)).toList();
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

  void toggleFavoriteCostume(CostumeModel costumeFav) {
    Map<String, dynamic> favoriteItem = {
      "name": costumeFav.name,
      "image": costumeFav.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == costumeFav.name);

    if (index != -1) {
      favorites.removeAt(index);
      favoriteCharacters.remove(costumeFav.name);
    } else {
      favorites.add(favoriteItem);
      favoriteCharacters.add(costumeFav.name!);
    }
    box.write('favorites', favorites);
    log('Favorites Data -> $favorites');
  }
}
