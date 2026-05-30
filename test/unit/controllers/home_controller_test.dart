import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:quran_audio_player/modules/home/controllers/home_controller.dart';

class MockAudioPlayer extends Mock
    implements AudioPlayer {}

void main() {
  late HomeController controller;
  late MockAudioPlayer audioPlayer;

  setUp(() {
    audioPlayer = MockAudioPlayer();

    controller = HomeController(
      audioPlayer: audioPlayer,
    );
  });

  tearDown(() {
    Get.reset();
  });

  group('HomeController', () {
    test(
      'initial state should be correct',
          () {
        expect(
          controller.isLoading.value,
          false,
        );

        expect(
          controller.filteredSurahs,
          isEmpty,
        );
      },
    );

    test(
      'pauseAudio should call pause',
          () async {
        when(
              () => audioPlayer.pause(),
        ).thenAnswer(
              (_) async {},
        );

        await controller.pauseAudio();

        verify(
              () => audioPlayer.pause(),
        ).called(1);
      },
    );

    test(
      'resumeAudio should call play',
          () async {
        when(
              () => audioPlayer.play(),
        ).thenAnswer(
              (_) async {},
        );

        await controller.resumeAudio();

        verify(
              () => audioPlayer.play(),
        ).called(1);
      },
    );
  });
}