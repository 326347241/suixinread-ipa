import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/screens/home_screen.dart';
import 'package:suixin_read/screens/library_screen.dart';
import 'package:suixin_read/screens/discover_screen.dart';
import 'package:suixin_read/screens/ai_screen.dart';
import 'package:suixin_read/screens/profile_screen.dart';
import 'package:suixin_read/screens/reader_screen.dart';
import 'package:suixin_read/theme/app_theme.dart';

/// 主框架：底部 Tab + 悬浮导航胶囊 + 全屏页面路由
class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _tab = 0;
  String? _fullScreen; // 'reader' / 'ai' / 'detail' ...

  final _pages = const [
    HomeScreen(), LibraryScreen(), DiscoverScreen(), ProfileScreen(),
  ];

  void openReader() => setState(() => _fullScreen = 'reader');
  void openAI() => setState(() => _fullScreen = 'ai');

  @override
  Widget build(BuildContext context) {
    if (_fullScreen == 'reader') {
      return ReaderScreen(onClose: () => setState(() => _fullScreen = null));
    }
    if (_fullScreen == 'ai') {
      return AIScreen(fullScreen: true, onClose: () => setState(() => _fullScreen = null));
    }

    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Stack(
        children: [
          ReaderOpener(open: openReader, child: IndexedStack(index: _tab, children: _pages)),
          // 悬浮导航胶囊
          Positioned(
            right: 14, bottom: 96,
            child: Column(children: [
              _floatButton(CupertinoIcons.search, AppTheme.glass, AppTheme.accent,
                  () => setState(() => _tab = 1)),
              const SizedBox(height: 8),
              _floatButton(Icons.auto_awesome, AppTheme.brandBlue, Colors.white, openAI),
            ]),
          ),
          // 底部标签栏
          Positioned(left: 0, right: 0, bottom: 0, child: _tabBar()),
        ],
      ),
    );
  }

  Widget _floatButton(IconData icon, Color bg, Color fg, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48, height: 48,
        decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppTheme.brandPurple.withOpacity(.35), blurRadius: 22, offset: const Offset(0, 8))],
          border: Border.all(color: Colors.white.withOpacity(.5), width: 2),
        ),
        child: Icon(icon, color: fg, size: 23),
      ),
    );
  }

  Widget _tabBar() {
    const tabs = [
      (Icons.home_rounded, '首页'),
      (Icons.library_books_rounded, '书库'),
      (Icons.explore_rounded, '发现'),
      (Icons.person_rounded, '我的'),
    ];
    return Container(
      height: 82,
      padding: const EdgeInsets.only(bottom: 20, top: 8),
      decoration: BoxDecoration(
        color: AppTheme.glass,
        border: Border(top: BorderSide(color: AppTheme.line, width: .5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (i) {
          final active = i == _tab;
          return GestureDetector(
            onTap: () => setState(() => _tab = i),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(tabs[i].$1, size: 25, color: active ? AppTheme.accent : AppTheme.ink3),
              const SizedBox(height: 3),
              Text(tabs[i].$2, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                color: active ? AppTheme.accent : AppTheme.ink3)),
            ]),
          );
        }),
      ),
    );
  }
}

/// 供子页面打开阅读器的全局回调（简化版：通过 inherited 传递）
class ReaderOpener extends InheritedWidget {
  final VoidCallback open;
  const ReaderOpener({super.key, required this.open, required super.child});
  static ReaderOpener? of(BuildContext c) => c.dependOnInheritedWidgetOfExactType<ReaderOpener>();
  @override
  bool updateShouldNotify(ReaderOpener old) => open != old.open;
}
