import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_note/controllers/notes_controller.dart';
import 'package:keep_note/controllers/text_style_controller.dart';
import 'package:keep_note/screens/main_screen.dart';

import 'controllers/main_screen_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  Get.put(NotesController(), permanent: true);
  Get.put(TextStyleController(), permanent: true);
  Get.put(MainScreenController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(),
    );
  }
}

