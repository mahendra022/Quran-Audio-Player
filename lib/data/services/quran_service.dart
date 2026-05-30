import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';

class QuranService {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchSurahs() async {
    final response = await _dio.get(
      '${ApiConstants.baseUrl}/surah',
    );

    return response.data['data'];
  }

  String getAudioUrl(int surahNumber) {
    return '${ApiConstants.audioBaseUrl}$surahNumber.mp3';
  }
}