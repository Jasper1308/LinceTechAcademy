import 'package:ap1/ep_provider/screens/preferences_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/app_preferences.dart';
import 'models/color_state.dart';
import 'models/video_state.dart';
import 'screens/list_screen.dart';
import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences().init();
  final videoState = VideoState();
  await videoState.listVideos();
  final colorState = ColorState();
  await colorState.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: videoState),
        ChangeNotifierProvider.value(value: colorState),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => ListVideos(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/preferences': (BuildContext context) => PreferencesScreen(),
      },
    );
  }
}
