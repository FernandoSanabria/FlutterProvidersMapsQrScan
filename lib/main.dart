import 'package:enero4ejemplo1/src/page/google_map.dart';
import 'package:enero4ejemplo1/src/page/home.dart';
import 'package:enero4ejemplo1/src/provider/provider_status.dart';
import 'package:enero4ejemplo1/src/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // DatabaseService.databaseService.initializeDatabase();
   DatabaseService.databaseService.getData('map');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ProviderStatus(),
        ),
        // ChangeNotifierProvider(
        //   create: (BuildContext context) => 
        //   )
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => Home(),
        'map': (BuildContext context) => MapSample()
      },
    )
    );
  }
}