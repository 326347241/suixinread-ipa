import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/data/mock_data.dart';
import 'package:suixin_read/theme/app_theme.dart';
import 'package:suixin_read/widgets/common.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 110),
        children: [
          const SizedBox(height: 52),
          GlassTopBar(title: '发现', actions: [
            CircleIconButton(icon: Icons.view_agenda_outlined, onTap: () {}),
          ]),
          _hero(),
          _sourceStatus(),
          const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text('分类浏览', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
          _categories(),
          const Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text('热门榜单', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
          _rankings(),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 0),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(gradient: AppTheme.brandGradient, borderRadius: BorderRadius.circular(20)),
      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('探索精彩内容', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
        SizedBox(height: 6),
        Text('聚合 12 个书源 · 每日更新海量好书', style: TextStyle(color: Colors.white70, fontSize: 11)),
        SizedBox(height: 14),
        SearchBar(),
      ]),
    );
  }

  Widget _sourceStatus() {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 14, 18, 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(16), boxShadow: [AppTheme.cardShadow]),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF34D399), Color(0xFF10B981)]),
          borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.check, color: Colors.white, size: 22)),
        const SizedBox(width: 12),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('书源状态正常', style: TextStyle(fontSize: 13, fontWeight: FontWeight(750))),
          SizedBox(height: 3),
          Text('12 个书源可用 · 上次检查 2 分钟前', style: TextStyle(fontSize: 11, color: AppTheme.ink3)),
        ])),
        const Icon(CupertinoIcons.chevron_right, color: AppTheme.ink3, size: 16),
      ]),
    );
  }

  Widget _categories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, mainAxisSpacing: 16, crossAxisSpacing: 12, childAspectRatio: .9),
        itemCount: MockData.hotCategories.length,
        itemBuilder: (c, i) {
          final cat = MockData.hotCategories[i];
          final colors = [AppTheme.brandPurple, Colors.red, Colors.pink, Colors.blue,
            Colors.cyan, Colors.orange, Colors.green, Colors.deepPurple];
          return Column(children: [
            Container(width: 50, height: 50,
              decoration: BoxDecoration(gradient: LinearGradient(colors: [colors[i], colors[i].withOpacity(.7)]),
                borderRadius: BorderRadius.circular(16)),
              child: Center(child: Text(cat.substring(0, 1), style: const TextStyle(color: Colors.white, fontSize: 22)))),
            const SizedBox(height: 7),
            Text(cat, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.ink2)),
          ]);
        },
      ),
    );
  }

  Widget _rankings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(18), boxShadow: [AppTheme.cardShadow]),
      child: Column(
        children: List.generate(5, (i) {
          final rankColors = [AppTheme.brandBlue, AppTheme.brandPurple, AppTheme.brandPink];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(border: i < 4 ? Border(bottom: BorderSide(color: AppTheme.line, width: .5)) : null),
            child: Row(children: [
              SizedBox(width: 22, child: Text('${i + 1}', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic,
                  color: i < 3 ? rankColors[i] : AppTheme.ink3))),
              const SizedBox(width: 12),
              Container(width: 38, height: 50, decoration: BoxDecoration(
                gradient: MockData.books[i].coverGradient, borderRadius: BorderRadius.circular(5))),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(MockData.books[i].name, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('${MockData.books[i].author} · ${MockData.books[i].tags.first}',
                  style: const TextStyle(fontSize: 10, color: AppTheme.ink3)),
              ])),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.brandPink.withOpacity(.1), borderRadius: BorderRadius.circular(8)),
                child: const Text('382万', style: TextStyle(fontSize: 10, color: AppTheme.brandPink, fontWeight: FontWeight.w700))),
            ]),
          );
        }),
      ),
    );
  }
}

/// 顶栏内的搜索条
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(color: Colors.white.withOpacity(.95), borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(children: const [
        Icon(CupertinoIcons.search, color: AppTheme.ink3, size: 16),
        SizedBox(width: 8),
        Text('搜索书名、作者、书源…', style: TextStyle(color: AppTheme.ink3, fontSize: 12)),
      ]),
    );
  }
}
