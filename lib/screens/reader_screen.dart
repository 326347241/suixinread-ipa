import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/data/mock_data.dart';
import 'package:suixin_read/theme/app_theme.dart';

/// 阅读器 —— 核心界面，含正文、工具栏、目录抽屉、阅读设置面板
class ReaderScreen extends StatefulWidget {
  final VoidCallback onClose;
  const ReaderScreen({super.key, required this.onClose});
  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  int _chapter = 0;
  int _paper = 0;
  double _fontSize = 18;
  double _lineHeight = 1.95;
  String _effect = '仿真翻页';
  String _settingsTab = '字体';
  bool _toolbar = false;
  bool _catalog = false;
  bool _settings = false;

  PaperPreset get paper => AppTheme.papers[_paper];
  Chapter get chapter => MockData.chapters[_chapter];

  void _toggleToolbar() => setState(() => _toolbar = !_toolbar);
  void _changeChapter(int d) => setState(() => _chapter = (_chapter + d).clamp(0, MockData.chapters.length - 1).toInt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: paper.background,
      body: Stack(children: [
        // 正文
        Positioned.fill(
          child: GestureDetector(
            onTap: _toggleToolbar,
            onDoubleTap: _toggleToolbar,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 60),
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(chapter.title, style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: paper.textColor)),
                  const SizedBox(height: 22),
                  ...chapter.paragraphs.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(p, textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: _fontSize, height: _lineHeight, color: paper.textColor, letterSpacing: .5)),
                  )),
                ]),
              ),
            ),
          ),
        ),
        // 顶部工具栏
        AnimatedPositioned(
          duration: const Duration(milliseconds: 280),
          top: _toolbar ? 0 : -120, left: 0, right: 0,
          child: _topBar(),
        ),
        // 底部工具栏
        AnimatedPositioned(
          duration: const Duration(milliseconds: 280),
          bottom: _toolbar ? 0 : -200, left: 0, right: 0,
          child: _bottomBar(),
        ),
        // 进度胶囊
        if (!_toolbar && !_settings)
          Positioned(bottom: 54, left: 0, right: 0, child: Center(child: GestureDetector(
            onTap: () => setState(() => _settings = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(color: Colors.black.withOpacity(.7), borderRadius: BorderRadius.circular(16)),
              child: Text('${chapter.title} · 68%  ›', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
            ),
          ))),
        // 阅读设置面板
        if (_settings) _settingsPanel(),
        // 目录抽屉
        if (_catalog) _catalogDrawer(),
      ]),
    );
  }

  Widget _topBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 54, 16, 12),
      decoration: BoxDecoration(
        color: paper.background.withOpacity(.97),
        border: Border(bottom: BorderSide(color: paper.textColor.withOpacity(.08), width: .5)),
      ),
      child: Row(children: [
        GestureDetector(onTap: widget.onClose,
          child: Icon(CupertinoIcons.back, size: 24, color: paper.textColor)),
        const SizedBox(width: 12),
        Expanded(child: Text('神雕游侠', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: paper.textColor))),
        GestureDetector(onTap: () => setState(() => _catalog = true),
          child: Icon(Icons.list, size: 22, color: paper.textColor)),
        const SizedBox(width: 14),
        GestureDetector(onTap: () => setState(() => _settings = true),
          child: Icon(Icons.more_horiz, size: 22, color: paper.textColor)),
      ]),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
      decoration: BoxDecoration(
        color: paper.background.withOpacity(.97),
        border: Border(top: BorderSide(color: paper.textColor.withOpacity(.08), width: .5)),
      ),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(chapter.title, style: TextStyle(fontSize: 11, color: paper.textColor.withOpacity(.7))),
          Text('68% · 第 ${_chapter + 1}/${MockData.chapters.length} 章',
            style: TextStyle(fontSize: 11, color: paper.textColor.withOpacity(.7))),
        ]),
        const SizedBox(height: 8),
        ClipRRect(borderRadius: BorderRadius.circular(3), child: LinearProgressIndicator(
          value: .68, color: AppTheme.accent, backgroundColor: paper.textColor.withOpacity(.15), minHeight: 4)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _action(Icons.list, '目录', () => setState(() => _catalog = true)),
          _action(CupertinoIcons.back, '上一章', () => _changeChapter(-1)),
          _action(Icons.font_download, '设置', () => setState(() => _settings = true)),
          _action(CupertinoIcons.forward, '下一章', () => _changeChapter(1)),
          _action(Icons.bookmark_border, '书签', () => _toast('已添加书签')),
        ]),
      ]),
    );
  }

  Widget _action(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Column(children: [
      Icon(icon, size: 22, color: paper.textColor.withOpacity(.85)),
      const SizedBox(height: 5),
      Text(label, style: TextStyle(fontSize: 10, color: paper.textColor.withOpacity(.85))),
    ]));
  }

  Widget _settingsPanel() {
    return Positioned(
      left: 0, right: 0, bottom: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 40),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 40, offset: Offset(0, -10))]),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 36, height: 4, decoration: BoxDecoration(color: const Color(0xFFD5D7E0), borderRadius: BorderRadius.circular(3))),
          const SizedBox(height: 16),
          Row(children: ['字体', '背景', '翻页'].map((t) => GestureDetector(
            onTap: () => setState(() => _settingsTab = t),
            child: Container(margin: const EdgeInsets.only(right: 18), padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(
                color: t == _settingsTab ? AppTheme.accent : Colors.transparent, width: 2))),
              child: Text(t, style: TextStyle(fontSize: 13, fontWeight: FontWeight(650),
                color: t == _settingsTab ? AppTheme.accent : AppTheme.ink3))),
          )).toList()),
          const SizedBox(height: 16),
          _settingsContent(),
          const SizedBox(height: 8),
          GestureDetector(onTap: () => setState(() => _settings = false),
            child: Container(width: double.infinity, height: 40,
              decoration: BoxDecoration(color: AppTheme.accent.withOpacity(.1), borderRadius: BorderRadius.circular(12)),
              child: const Center(child: Text('完成', style: TextStyle(color: AppTheme.accent, fontWeight: FontWeight.w700)))),
          ),
        ]),
      ),
    );
  }

  Widget _settingsContent() {
    if (_settingsTab == '字体') return Column(children: [
      _stepper('字号', _fontSize.toStringAsFixed(1), () => setState(() => _fontSize = (_fontSize - 1).clamp(12, 30).toDouble()),
        () => setState(() => _fontSize = (_fontSize + 1).clamp(12, 30).toDouble())),
      _stepper('行距', _lineHeight.toStringAsFixed(2), () => setState(() => _lineHeight = (_lineHeight - .01).clamp(1.2, 2.6).toDouble()),
        () => setState(() => _lineHeight = (_lineHeight + .01).clamp(1.2, 2.6).toDouble())),
      const SizedBox(height: 4),
      const Row(children: [SizedBox(width: 44, child: Text('字体', style: TextStyle(fontSize: 12, color: AppTheme.ink2))),
        Text('系统字体 · 思源宋体 · 鸿蒙字体', style: TextStyle(fontSize: 12))]),
    ]);
    if (_settingsTab == '背景') return Column(children: [
      Row(children: [
        const SizedBox(width: 44, child: Text('主题', style: TextStyle(fontSize: 12, color: AppTheme.ink2))),
        ...AppTheme.papers.asMap().entries.map((e) => GestureDetector(
          onTap: () => setState(() => _paper = e.key),
          child: Container(margin: const EdgeInsets.only(right: 8), width: 30, height: 30,
            decoration: BoxDecoration(color: e.value.background,
              border: Border.all(color: _paper == e.key ? AppTheme.accent : Colors.grey.shade300, width: 2),
              borderRadius: BorderRadius.circular(10))),
        )),
      ]),
    ]);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('翻页方式', style: TextStyle(fontSize: 12, color: AppTheme.ink2)),
      const SizedBox(height: 10),
      Wrap(spacing: 8, runSpacing: 8, children: AppTheme.pageEffects.map((e) => GestureDetector(
        onTap: () => setState(() => _effect = e),
        child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(color: e == _effect ? AppTheme.accent : const Color(0xFFF4F5F9),
            borderRadius: BorderRadius.circular(10)),
          child: Text(e, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
            color: e == _effect ? Colors.white : AppTheme.ink2))),
      )).toList()),
    ]);
  }

  Widget _stepper(String label, String value, VoidCallback minus, VoidCallback plus) {
    return Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [
      SizedBox(width: 44, child: Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.ink2))),
      Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(color: const Color(0xFFF4F5F9), borderRadius: BorderRadius.circular(12)),
        child: Row(children: [
          GestureDetector(onTap: minus, child: _stepBtn(Icons.remove)),
          Expanded(child: Center(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w700)))),
          GestureDetector(onTap: plus, child: _stepBtn(Icons.add)),
        ]))),
    ]));
  }

  Widget _stepBtn(IconData icon) {
    return Container(width: 26, height: 26, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Icon(icon, size: 16, color: AppTheme.accent));
  }

  Widget _catalogDrawer() {
    return Positioned(
      top: 0, bottom: 0, right: 0, width: 320,
      child: Container(
        padding: const EdgeInsets.only(top: 54),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 40, offset: Offset(-10, 0))]),
        child: Column(children: [
          Padding(padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('目录', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
              GestureDetector(onTap: () => setState(() => _catalog = false),
                child: const Icon(Icons.close, size: 22)),
            ])),
          Row(children: ['目录', '书签', '笔记'].map((t) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(t, style: const TextStyle(fontSize: 13, color: AppTheme.ink2)),
          )).toList()),
          const Divider(),
          Expanded(child: ListView.builder(
            itemCount: MockData.chapters.length,
            itemBuilder: (c, i) => GestureDetector(
              onTap: () => setState(() { _chapter = i; _catalog = false; }),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                decoration: BoxDecoration(color: i == _chapter ? AppTheme.accent.withOpacity(.05) : null,
                  border: Border(bottom: BorderSide(color: AppTheme.line, width: .5))),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(MockData.chapters[i].title, style: TextStyle(fontSize: 12.5,
                    fontWeight: i == _chapter ? FontWeight(750) : FontWeight.w400,
                    color: i == _chapter ? AppTheme.accent : AppTheme.ink)),
                  if (i == _chapter) const Text('在读', style: TextStyle(fontSize: 9, color: AppTheme.brandPink)),
                ]),
              ),
            ),
          )),
        ]),
      ),
    );
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(milliseconds: 800)));
  }
}
