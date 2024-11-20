import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:philantropic_offering_app/pho/pho_botom.dart';
import 'package:philantropic_offering_app/pho/pho_color.dart';
import 'package:philantropic_offering_app/service/hive/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Philanthropic Offering',
        theme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            backgroundColor: PHOColor.splash,
            iconTheme: IconThemeData(
              color: PHOColor.splash,
            ),
          ),
          scaffoldBackgroundColor: PHOColor.splash,
          fontFamily: 'Inter',
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          splashFactory: NoSplash.splashFactory,
        ),
        home: const PHOBotBar(),
      ),
    );
  }
}
