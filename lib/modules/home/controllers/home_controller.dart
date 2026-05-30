import 'dart:async';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/surah_model.dart';
import '../../../data/repositories/quran_repository.dart';
import '../../../data/services/quran_service.dart';

class HomeController extends GetxController {
  HomeController({
    AudioPlayer? audioPlayer,
  }) : audioPlayer =
      audioPlayer ?? AudioPlayer();


  Timer? _debounce;

  final AudioPlayer audioPlayer;
  final QuranRepository _repository = QuranRepository(QuranService());
  final RxBool isLoading = false.obs;
  final RxBool isPlaying = false.obs;
  final RxBool readyPlaying = false.obs;

  final RxList<SurahModel> surahs = <SurahModel>[].obs;
  final RxList<SurahModel> filteredSurahs = <SurahModel>[].obs;
  final RxString errorMessage = ''.obs;

  final Rx<Duration> currentPosition = Duration.zero.obs;
  final Rx<Duration> totalDuration = Duration.zero.obs;


  @override
  void onInit() {
    super.onInit();

    fetchSurahs();

    audioPlayer.positionStream.listen((position) {
      currentPosition.value = position;
    });

    audioPlayer.durationStream.listen((duration) {
      totalDuration.value =
          duration ?? Duration.zero;
    });

    audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  @override
  void onClose() {
    _debounce?.cancel();
    audioPlayer.dispose();
    super.onClose();
  }

  void searchSurah(String query) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 400),
          () {
        if (query.isEmpty) {
          filteredSurahs.assignAll(surahs);
          return;
        }

        final filtered = surahs.where((surah) {
          return surah.englishName
              .toLowerCase()
              .contains(query.toLowerCase());
        }).toList();

        filteredSurahs.assignAll(filtered);
      },
    );
  }

  Future fetchSurahs() async {
    try {
      isLoading.value = true;

      final result =
          await _repository.fetchSurahs();

      surahs.assignAll(result);

      filteredSurahs.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future playSurah(int surahNumber) async {
    try {
      final url =
          _repository.getAudioUrl(surahNumber);

      await audioPlayer.setUrl(url);

      readyPlaying.value = true;
      await audioPlayer.play();

    } catch (e) {
      Get.snackbar(
        'Playback Error',
        e.toString(),
      );
    }
  }

  Future pauseAudio() async {
    await audioPlayer.pause();
  }

  Future resumeAudio() async {
    await audioPlayer.play();
  }

  Future seekAudio(double value) async {
    await audioPlayer.seek(
      Duration(seconds: value.toInt()),
    );
  }

}