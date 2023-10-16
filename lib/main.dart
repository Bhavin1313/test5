import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test4/providers/platformprovider.dart';
import 'package:test4/providers/theamprovider.dart';
import 'package:test4/screens/onetime.dart';
import 'package:test4/screens/splesh.dart';
import 'package:test4/screens/spleshios.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();

  bool isVisitOnce = preferences.getBool("visited") ?? false;
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<PlatformProvider>(
          create: (context) => PlatformProvider(),
        ),
        ListenableProvider<Themeprovider>(
          create: (context) => Themeprovider(),
        ),
      ],
      builder: (context, child) => (Provider.of<PlatformProvider>(context)
                  .changePlatform
                  .isios ==
              false)
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData.light(
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark(
                useMaterial3: true,
              ),
              themeMode:
                  (Provider.of<Themeprovider>(context).theme.isdark == false)
                      ? ThemeMode.light
                      : ThemeMode.dark,
              initialRoute: (isVisitOnce == true) ? 'splesh' : '/',
              routes: {
                '/': (context) => const One_Time_Intro_Page(),
                'splesh': (context) => Splash(),
              },
            )
          : CupertinoApp(
              debugShowCheckedModeBanner: false,
              theme: MaterialBasedCupertinoThemeData(
                materialTheme:
                    (Provider.of<Themeprovider>(context).theme.isdark == false)
                        ? ThemeData(
                            brightness: Brightness.light,
                          )
                        : ThemeData(
                            brightness: Brightness.dark,
                          ),
              ),
              routes: {
                '/': (context) => SplashIos(),
              },
            ),
    ),
  );
}
