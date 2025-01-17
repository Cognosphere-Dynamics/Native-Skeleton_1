import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'explore_screen.dart';
import 'main_screen.dart';
import 'feed_detail_screen.dart';
import 'place_detail_screen.dart';
import 'operator_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case '/main':
            return MaterialPageRoute(builder: (_) => MainScreen());
          case '/explore':
            return MaterialPageRoute(builder: (_) => ExploreScreen());
          case '/feedDetail':
            return MaterialPageRoute(builder: (_) => FeedDetailScreen());
          case '/placeDetail':
            return MaterialPageRoute(builder: (_) => PlaceDetailScreen());
          case '/operatorDetail':
            return MaterialPageRoute(builder: (_) => OperatorDetailScreen());
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(child: Text('404: Page Not Found')),
              ),
            );
        }
      },
    );
  }
}
