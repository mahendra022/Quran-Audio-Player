import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../widgets/player_section.dart';
import '../widgets/surah_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quran Audio Player',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Surah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged:
                  controller.searchSurah,
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child:
                        CircularProgressIndicator(),
                  );
                }

                if (controller
                    .errorMessage
                    .value
                    .isNotEmpty) {
                  return Center(
                    child: Text(
                      controller
                          .errorMessage.value,
                    ),
                  );
                }

                if (controller
                    .filteredSurahs
                    .isEmpty) {
                  return const Center(
                    child: Text(
                      'No Surah Found',
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller
                      .filteredSurahs.length,
                  itemBuilder: (context, index) {
                    final surah = controller
                        .filteredSurahs[index];

                    return SurahTile(
                      surah: surah,
                      onPlay: () {
                        if(!surah.isPlaying.value){
                          controller
                              .surahs.forEach((e) => e.isPlaying.value = false);
                          surah.isPlaying.value = true;
                          controller.playSurah(
                            surah.number,
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Obx(() => controller.readyPlaying.value ? const PlayerSection() : const SizedBox.shrink()),
        ],
      ),
    );
  }
}