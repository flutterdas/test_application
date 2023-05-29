import 'modules/all_users/ui/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'core/services/services_locator.dart' as di;
Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Task Application',
      home: MainPage(),
    );
  }
}
