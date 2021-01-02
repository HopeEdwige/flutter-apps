import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/models/session.dart';
import 'package:weight_tracker/routes.dart';
import 'package:weight_tracker/util/theme_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => Session()),
      ],
      child: MaterialApp(
        routes: Routes.list,
        title: 'Weight Tracker',
        initialRoute: Routes.defaultRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Color.fromRGBO(138, 139, 150, 1)),
          ),
          cardColor: Color.fromRGBO(32, 33, 55, 1),
          backgroundColor: Color.fromRGBO(22, 24, 46, 1),
          scaffoldBackgroundColor: Color.fromRGBO(22, 24, 46, 1),
          primarySwatch: createMaterialColor(Color.fromRGBO(26, 255, 213, 1)),
        ),
      ),
    );
  }
}
