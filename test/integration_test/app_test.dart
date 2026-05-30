import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:quran_audio_player/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding
      .ensureInitialized();

  testWidgets(
    'app launches successfully',
        (tester) async {
      await tester.pumpWidget(
        const QuranApp(),
      );

      await tester.pumpAndSettle();

      expect(
        find.text(
          'Quran Audio Player',
        ),
        findsOneWidget,
      );
    },
  );
}