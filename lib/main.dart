import 'package:flutter/material.dart';
import 'package:openhab_flutter/pages/loading/loading_page.dart';
import 'package:openhab_flutter/routes/routes.dart';
import 'package:openhab_flutter/services/items_service.dart';
import 'package:openhab_flutter/services/setupServer_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SetupServerService()),
          ChangeNotifierProvider(create: (_) => ItemsService()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OpenHab Distribuidos',
          // navigatorKey: navigatorKey,
          home: LoadingPage(),
          // initialRoute: 'loading1',
          routes: appRoutes,
          // theme: ThemeData(primaryColor: Color.fromARGB(255, 230, 74, 20)),
          theme: ThemeData(primaryColor: Color.fromARGB(255, 251, 123, 74)),
        ));
  }
}
