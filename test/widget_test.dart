// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:final_pro/Screens/LogIn/LogIn.dart';
import 'package:final_pro/Screens/homepage/tabview/tabview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:final_pro/main.dart';
import '../lib/Helper/Share_Pref.dart';
import '../lib/Screens/page_view.dart';
import '../lib/Screens/splash.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    WidgetsFlutterBinding.ensureInitialized();
    await Sharepref.init();
    var p_view = Sharepref.getdata(key: "p_view");
    var UID = Sharepref.getdata(key: "UID");
    Widget S_page;
  if (p_view == null) {
    S_page = PageViewScreen();
  } else {
    if (UID == null) {
      S_page = MainSplashScreen(LogInSrc());
    } else {
      S_page = MainSplashScreen(tabview());
    }
    // S_page =SignUpSrc();
  }
    await tester.pumpWidget(MyApp(
      Start_Screen: S_page,
    ));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
