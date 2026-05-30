import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/surah_model.dart';

class SurahTile extends StatelessWidget {
  final SurahModel surah;
  final VoidCallback onPlay;

  const SurahTile({
    super.key,
    required this.surah,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            surah.number.toString(),
          ),
        ),
        title: Text(
          surah.englishName,
        ),
        subtitle: Text(
          surah.arabicName,
        ),
        trailing: IconButton(
          icon: Obx(()=> Icon(surah.isPlaying.value ? Icons.pause : Icons.play_arrow)),
          onPressed: onPlay,
        ),
      ),
    );
  }
}