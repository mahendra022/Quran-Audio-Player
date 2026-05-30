import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/duration_formatter.dart';
import '../controllers/home_controller.dart';

class PlayerSection extends GetView<HomeController> {
  const PlayerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final current =
            controller.currentPosition.value;

        final total =
            controller.totalDuration.value;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
          child: Column(
            children: [
              Slider(
                min: 0,
                max: total.inSeconds == 0
                    ? 1
                    : total.inSeconds.toDouble(),
                value: current.inSeconds
                    .clamp(
                      0,
                      total.inSeconds,
                    )
                    .toDouble(),
                onChanged: controller.seekAudio,
              ),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(current),
                  ),
                  Text(
                    formatDuration(total),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 36,
                    icon: Icon(
                      controller.isPlaying.value
                          ? Icons.pause_circle
                          : Icons.play_circle,
                    ),
                    onPressed: () {
                      if (controller
                          .isPlaying.value) {
                        controller.pauseAudio();
                      } else {
                        controller.resumeAudio();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}