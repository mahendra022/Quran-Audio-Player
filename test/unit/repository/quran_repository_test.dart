import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:quran_audio_player/data/repositories/quran_repository.dart';
import 'package:quran_audio_player/data/services/quran_service.dart';

class MockQuranService extends Mock
    implements QuranService {}

void main() {
  late QuranRepository repository;
  late MockQuranService service;

  setUp(() {
    service = MockQuranService();
    repository = QuranRepository(service);
  });

  test(
    'should return list of surahs',
    () async {
      when(() => service.fetchSurahs()).thenAnswer(
        (_) async => [
          {
            'number': 1,
            'englishName': 'Al-Fatihah',
            'name': 'الفاتحة',
          },
        ],
      );

      final result =
          await repository.fetchSurahs();

      expect(result.length, 1);

      expect(
        result.first.englishName,
        'Al-Fatihah',
      );
    },
  );
}