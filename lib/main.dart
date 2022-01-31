import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticker/db/db_helber.dart';
import 'package:ticker/providers/date_provider.dart';
import 'package:ticker/services/theme_services.dart';
import 'package:ticker/ui/size_config.dart';
import 'package:ticker/ui/widgets/theme.dart';

import 'ui/screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelber.initDb();
  await GetStorage.init();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    print('theme mode ${Get.isDarkMode}');
    return ChangeNotifierProvider<DateProvider>(
      create: (context) => DateProvider(),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme:Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        home: const MyHomePage(),
      ),
    );
  }

}

