import 'package:get/get.dart';

class SurahModel {
  final int number;
  final String englishName;
  final String arabicName;
  final RxBool isPlaying;

  SurahModel({
    required this.number,
    required this.englishName,
    required this.arabicName,
  }) : isPlaying = false.obs;

  factory SurahModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return SurahModel(
      number: json['number'],
      englishName: json['englishName'],
      arabicName: json['name'],
    );
  }
}