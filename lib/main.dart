import 'package:country_code_picker/country_localizations.dart';
import 'package:ez/constant/constant.dart';
import 'package:ez/screens/view/newUI/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'constant/push_notification_service.dart';

const iOSLocalizedLabels = false;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  SharedPreferences.getInstance().then(
    (prefs) async {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "SOD",
          //  supportedLocales: [
          //         const Locale('en'),
          //         const Locale('ar'),
          //         const Locale('es'),
          //         const Locale('de'),
          //         const Locale('fr'),
          //         const Locale('el'),
          //         const Locale('et'),
          //         const Locale('nb'),
          //         const Locale('nn'),
          //         const Locale('pl'),
          //         const Locale('pt'),
          //         const Locale('ru'),
          //         const Locale('hi'),
          //         const Locale('ne'),
          //         const Locale('uk'),
          //         const Locale('hr'),
          //         const Locale('tr'),
          //         const Locale('lv'),
          //         const Locale('lt'),
          //         const Locale('ku'),
          //         const Locale('nl'),
          //         const Locale.fromSubtags(
          //             languageCode: 'zh',
          //             scriptCode: 'Hans'), // Generic Simplified Chinese 'zh_Hans'
          //         const Locale.fromSubtags(
          //             languageCode: 'zh',
          //             scriptCode: 'Hant'), // Generic traditional Chinese 'zh_Hant'
          //       ],
          //       localizationsDelegates: [
          //         CountryLocalizations.delegate,
          //         GlobalMaterialLocalizations.delegate,
          //         GlobalCupertinoLocalizations.delegate,
          //         GlobalWidgetsLocalizations.delegate,
          //       ],
          theme: new ThemeData(
              accentColor: Colors.black,
              primaryColor: Colors.black,
              primaryColorDark: Colors.black),
          home: SplashPage(),
          routes: <String, WidgetBuilder>{
            App_Screen: (BuildContext context) => AppScreen(prefs),
          },
        ),
      );
    },
  );
}
