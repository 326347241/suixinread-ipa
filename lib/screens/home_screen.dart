import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/data/mock_data.dart';
import 'package:suixin_read/models/book.dart';
import 'package:suixin_read/theme/app_theme.dart';
import 'package:suixin_read/widgets/common.dart';
import 'package:suixin_read/screens/main_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final book = MockData.books.first;
    final opener = ReaderOpener.of(context);
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 52), // 状态栏
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('随心所阅', style: TextStyle(fontSize: 22, fontWeight: FontWeight(850), letterSpacing: -.6)),
              ),
              const SizedBox(height: 12),
              _continueHero(book, () => opener?.open()),
              _quickGrid(context),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 8),
                child: Text('为你推荐', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ]),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.5),
              delegate: SliverChildBuilderDelegate((c, i) {
                final b = MockData.books[i + 1];
                return _recommendCard(b);
              }, childCount: 4),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 110)),
        ],
      ),
    );
  }

  Widget _continueHero(Book book, VoidCallback onRead) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      height: 168,
      decoration: BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [BoxShadow(color: AppTheme.brandPurple.withOpacity(.28), blurRadius: 30, offset: const Offset(0, 12))],
      ),
      child: Stack(children: [
        Positioned(right: -40, top: -60, child: Container(width: 180, height: 180,
          decoration: const BoxDecoration(color: Color(0x21FFFFFF), shape: BoxShape.circle))),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('下午好，书友', style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600)),
            const Text('继续阅读', style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w800)),
            const Spacer(),
            GestureDetector(
              onTap: onRead,
              child: Row(children: [
                Container(width: 42, height: 56, decoration: BoxDecoration(
                  gradient: book.coverGradient, borderRadius: BorderRadius.circular(6))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(book.name, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  const Text('第001章 · 已读 68%', style: TextStyle(color: Colors.white70, fontSize: 11)),
                  const SizedBox(height: 6),
                  ClipRRect(borderRadius: BorderRadius.circular(2), child: const LinearProgressIndicator(
                    value: .68, color: Colors.white, backgroundColor: Colors.white38, minHeight: 3)),
                ])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.95), borderRadius: BorderRadius.circular(20)),
                  child: const Text('阅读', style: TextStyle(color: AppTheme.accent, fontSize: 11, fontWeight: FontWeight.w800))),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _quickGrid(BuildContext context) {
    const items = [
      (Icons.search_rounded, '搜索', AppTheme.brandBlue),
      (Icons.view_agenda_outlined, '书源', AppTheme.brandPurple),
      (Icons.file_download_outlined, '导入', AppTheme.brandPink),
      (Icons.settings_outlined, '设置', Color(0xFFF59E0B)),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items.map((e) => GestureDetector(
          onTap: () => _quickAction(context, e.$2),
          child: Column(children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [e.$3, e.$3.withOpacity(.7)]),
              borderRadius: BorderRadius.circular(16)),
              child: Icon(e.$1, color: Colors.white, size: 24)),
            const SizedBox(height: 7),
            Text(e.$2, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.ink2)),
          ]),
        )).toList()),
    );
  }

  void _quickAction(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$name'), duration: const Duration(milliseconds: 800)));
  }

  Widget _recommendCard(Book b) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [b.cover[0].withOpacity(.13), b.cover[1].withOpacity(.09)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [AppTheme.cardShadow],
      ),
      child: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(b.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(b.author, style: const TextStyle(fontSize: 11, color: AppTheme.ink3)),
        ]),
        Positioned(right: 0, bottom: -6, child: Icon(Icons.auto_stories, size: 52, color: b.cover[0].withOpacity(.2))),
      ]),
    );
  }
}
