import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/data/mock_data.dart';
import 'package:suixin_read/theme/app_theme.dart';
import 'package:suixin_read/widgets/common.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _cat = '全部';
  final _cats = ['全部', '小说', '漫画', '音频', '视频', '本地'];

  @override
  Widget build(BuildContext context) {
    final shown = _cat == '全部'
        ? MockData.books
        : MockData.books.where((b) => b.category == _cat).toList();
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 52),
        GlassTopBar(title: '书库', actions: [
          CircleIconButton(icon: CupertinoIcons.search, onTap: () {}),
          const SizedBox(width: 8),
          CircleIconButton(icon: CupertinoIcons.add, onTap: () {}),
        ]),
        SizedBox(
          height: 52,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            scrollDirection: Axis.horizontal,
            itemCount: _cats.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (c, i) => GestureDetector(
              onTap: () => setState(() => _cat = _cats[i]),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _cat == _cats[i] ? AppTheme.accent : const Color(0x177882AA),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_cats[i], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                  color: _cat == _cats[i] ? Colors.white : AppTheme.ink2)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('$_cat · ${shown.length} 本', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.ink2)),
            const Row(children: [Icon(Icons.sort, size: 18, color: AppTheme.ink3), SizedBox(width: 14),
              Icon(Icons.grid_view, size: 18, color: AppTheme.ink3)]),
          ]),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 20, crossAxisSpacing: 14, childAspectRatio: .71),
            itemCount: shown.length,
            itemBuilder: (c, i) => _bookCard(shown[i]),
          ),
        ),
      ]),
    );
  }

  Widget _bookCard(book) {
    return GestureDetector(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('打开《${book.name}》'), duration: const Duration(milliseconds: 800))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(gradient: book.coverGradient, borderRadius: BorderRadius.circular(9),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 16, offset: const Offset(0, 6))]),
              child: Center(child: Padding(padding: const EdgeInsets.all(8),
                child: Text(book.name, textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 1)))),
            ),
            Positioned(top: 6, right: 6, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(8)),
              child: Text(book.badge, style: const TextStyle(color: Colors.white, fontSize: 9)))),
            Positioned(left: 0, right: 0, bottom: 0, child: ClipRRect(
              child: LinearProgressIndicator(value: book.progress / 100, color: AppTheme.brandPink,
                backgroundColor: Colors.white54, minHeight: 3))),
          ]),
        ),
        const SizedBox(height: 7),
        Text(book.name, maxLines: 2, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight(650))),
        Text(book.author, maxLines: 1, style: const TextStyle(fontSize: 10, color: AppTheme.ink3)),
      ]),
    );
  }
}
