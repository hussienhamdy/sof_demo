import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sof_demo/core/constants.dart';
import 'package:sof_demo/core/routes.dart';
import 'package:sof_demo/features/users/presentation/screens/users_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider
      .getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox(bookmarkedUsersBoxName);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SOF Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: TextTheme(
              headlineLarge: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.white),
              bodyMedium: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              bodySmall: TextStyle(
                fontSize: 12.sp,
                color: Colors.blueGrey[400],
              ),
              labelSmall: TextStyle(
                fontSize: 10.sp,
                color: Colors.blueGrey[400],
              ),
            ),
          ),
          onGenerateRoute: (RouteSettings settings) =>
              Routes().onGenerateRoute(settings),
          home: UsersScreen(),
        );
      },
    );
  }
}
