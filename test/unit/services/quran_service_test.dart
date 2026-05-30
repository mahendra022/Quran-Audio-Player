import 'package:flutter_test/flutter_test.dart';

import 'package:quran_audio_player/data/services/quran_service.dart';

void main() {
  late QuranService service;

  setUp(() {
    service = QuranService();
  });

  test(
    'audio url should be generated correctly',
    () {
      final url = service.getAudioUrl(1);

      expect(
        url.contains('1.mp3'),
        true,
      );
    },
  );
}