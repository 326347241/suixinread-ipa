import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/theme/app_theme.dart';
import 'package:suixin_read/screens/main_shell.dart';

/// 随心所阅 · 应用入口
/// 复刻自 com.niki.xxread v3.1.520
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SuixinApp());
}

class SuixinApp extends StatelessWidget {
  const SuixinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: '随心所阅',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        primaryColor: AppTheme.brandBlue,
        scaffoldBackgroundColor: AppTheme.bg,
        brightness: Brightness.light,
        textTheme: const CupertinoTextThemeData(
          primaryColor: AppTheme.ink,
          textStyle: TextStyle(
            fontFamily: '.SF Pro Text',
            color: AppTheme.ink,
            fontSize: 14,
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}
