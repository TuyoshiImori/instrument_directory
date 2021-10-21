import 'package:flutter/material.dart';
import 'package:instrument_directory/bottom_tab.dart';
import 'package:instrument_directory/theme.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
            return MaterialApp(
              theme: notifier.darkTheme ? dark : light,
              debugShowCheckedModeBanner: false,
              home: BottomTab(),
            );
          }
      ),
    );
  }
}