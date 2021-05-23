import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'components/LiveDotaMatches.dart';
import 'components/SearchSteamUser.dart';

void main() {
  // Google Fonts License => Nunito Sans
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Dota 2 Indonesia',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFE0E0E0),
        defaultTextColor: Color(0xFF171A21),
        lightSource: LightSource.topLeft,
        depth: 10,
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF171A21),
        defaultTextColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NeumorphicAppBar(
          title: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image.network(
                'https://i.ibb.co/nbmr1v4/Png-Item-1489752.png',
                width: 35,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Dota 2 Indonesia 🇮🇩',
                style:
                    TextStyle(color: NeumorphicTheme.defaultTextColor(context)),
              )
            ],
          ),
          actions: <Widget>[
            NeumorphicButton(
              child: NeumorphicTheme.isUsingDark(context)
                  ? Icon(Icons.wb_sunny, size: 30, color: Colors.white)
                  : Icon(Icons.brightness_2, size: 30),
              onPressed: () {
                NeumorphicTheme.of(context).themeMode =
                    NeumorphicTheme.isUsingDark(context)
                        ? ThemeMode.light
                        : ThemeMode.dark;
              },
            ),
          ],
        ),
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: SingleChildScrollView(
          child: ResponsiveGridRow(children: [
            ResponsiveGridCol(
              lg: 12,
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 50,
                alignment: Alignment(0, 0),
                child: Neumorphic(
                  child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Text('Recent Indonesian Pro Player Matches',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  NeumorphicTheme.defaultTextColor(context)))),
                ),
              ),
            ),
            ResponsiveGridCol(
              lg: 12,
              child: Container(
                // width: 120,
                height: 260,
                alignment: Alignment(0, 0),
                child: LiveDotaMatches(),
              ),
            ),
            ResponsiveGridCol(
              lg: 12,
              child: Container(
                  margin: EdgeInsets.only(bottom: 20, top: 20),
                  height: 270,
                  alignment: Alignment(0, 0),
                  child: SearchSteamUser()),
            ),
          ]),
        ));
  }

  Color _iconsColor(BuildContext context) {
    final theme = NeumorphicTheme.of(context);
    if (theme.isUsingDark) {
      return theme.current.accentColor;
    } else {
      return null;
    }
  }

  Color _textColor(BuildContext context) {
    if (NeumorphicTheme.isUsingDark(context)) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
