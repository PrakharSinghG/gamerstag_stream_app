import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme.dart';
import 'presentation/pages/edit_stream_page.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/add_stream_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live Streams',
      theme: AppTheme.darkTheme, 
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(
            name: '/addStream', page: () => AddStreamPage()), 
        GetPage(name: '/editStream', page: () => EditStreamPage()),
      ],
    );
  }
}
