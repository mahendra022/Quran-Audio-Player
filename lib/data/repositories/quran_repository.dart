import '../models/surah_model.dart';
import '../services/quran_service.dart';

class QuranRepository {
  final QuranService service;

  QuranRepository(this.service);

  Future<List<SurahModel>> fetchSurahs() async {
    final response = await service.fetchSurahs();

    return response
        .map<SurahModel>(
          (e) => SurahModel.fromJson(e),
        )
        .toList();
  }

  String getAudioUrl(int surahNumber) {
    return service.getAudioUrl(surahNumber);
  }
}