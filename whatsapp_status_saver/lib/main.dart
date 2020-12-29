import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/models/selection_model.dart';

import 'package:whatsapp_status_saver/screens/home_screen/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(App()),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  PermissionStatus _status;

  // check permissions
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _askPermission();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // check permissions when app is resumed
  // this is when permissions are changed in app settings outside of app
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _askPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // todo if status is PermissionStatus.permanentlyDenied, show button to open settings and change permissions.
      home: ChangeNotifierProvider(
        builder: (context) => SelectionModel(),
        child: _status == PermissionStatus.granted ? HomeScreen() : Container(),
      ),
      title: 'WhatsApp Status Saver',
      debugShowCheckedModeBanner: false,
    );
  }

  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      // check status has changed
      setState(() {
        print(status);
        _status = status; // update
      });
    } else {
      if (status != PermissionStatus.granted) {
        _askPermission();
      }
    }
  }

  void _askPermission() async {
    _onStatusRequested(await Permission.storage.request().isGranted);
  }

  void _onStatusRequested(isGranted) async {
    if (!isGranted) {
      openAppSettings(); // todo
    } else {
      _updateStatus(await Permission.storage.status);
    }
  }
}
