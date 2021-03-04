import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greatmovie/Controllers/MoviesProvider.dart';
import 'package:greatmovie/Controllers/connectivityProvider.dart';
import 'package:greatmovie/splash.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(new MyApp());

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieProvider>(create: (_) => MovieProvider()),
        ChangeNotifierProvider<ConnectivityProvider>(
            create: (_) => ConnectivityProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        )),
        home: Splash(),
      ),
    );
  }
}
