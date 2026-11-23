import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final _groups = const [
    [
      ( Icons.workspace_premium, '会员中心', AppTheme.ink2, '未开通'),
      ( Icons.auto_awesome, 'AI 套餐', Color(0xFF8B5CF6), ''),
      ( Icons.cloud_outlined, '云同步', Color(0xFF3B82F6), '测试版'),
    ],
    [
      ( Icons.palette_outlined, '主题中心', Color(0xFFEC4899), '8 套'),
      ( Icons.brightness_6_outlined, '外观', Color(0xFF6366F1), '跟随系统'),
      ( Icons.apps_outlined, '悬浮导航栏', Color(0xFF14B8A6), '已开启'),
    ],
    [
      ( Icons.library_books_outlined, '书库与阅读数据', Color(0xFF8B5CF6), ''),
      ( Icons.view_agenda_outlined, '书源管理', Color(0xFF10B981), '12 个'),
      ( Icons.download_outlined, '下载管理', Color(0xFF0EA5E9), ''),
    ],
    [
      ( Icons.settings_outlined, '设置', Color(0xFF64748B), ''),
      ( Icons.help_outline, '帮助与反馈', Color(0xFF64748B), ''),
      ( Icons.info_outline, '关于随心所阅', Color(0xFF64748B), 'v3.1.520'),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      body: ListView(
        padding: const EdgeInsets.only(bottom: 110),
        children: [
          _head(),
          _vipBanner(context),
          ..._groups.map((g) => _group(g, context)),
        ],
      ),
    );
  }

  Widget _head() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 66, 20, 22),
      decoration: const BoxDecoration(
        gradient: AppTheme.brandGradient,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(children: [
        Row(children: [
          Container(width: 56, height: 56, decoration: BoxDecoration(
            color: Colors.white.withOpacity(.25), borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(.5))),
            child: const Icon(CupertinoIcons.person_fill, color: Colors.white, size: 30)),
          const SizedBox(width: 14),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('热爱阅读的你', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
            SizedBox(height: 5),
            Text('已加入 128 天 · ID 882301', style: TextStyle(color: Colors.white70, fontSize: 11)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(color: Colors.white.withOpacity(.95), borderRadius: BorderRadius.circular(18)),
            child: const Text('开通会员', style: TextStyle(color: AppTheme.brandPurple, fontSize: 11, fontWeight: FontWeight.w800))),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          _stat('9', '书架藏书'), _stat('326', '阅读小时'), _stat('48', '读书笔记'),
        ]),
      ]),
    );
  }

  Widget _stat(String n, String label) {
    return Expanded(child: Column(children: [
      Text(n, style: const TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
      const SizedBox(height: 3),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    ]));
  }

  Widget _vipBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => _toast(context, '会员中心'),
      child: Container(
        margin: const EdgeInsets.fromLTRB(18, 16, 18, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF2A2D3A), Color(0xFF454A5C)]),
          borderRadius: BorderRadius.circular(18), boxShadow: [AppTheme.cardShadow]),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFF5D9A0), Color(0xFFD4A24C)]),
            borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.workspace_premium, color: Color(0xFF3A2A10), size: 22)),
          const SizedBox(width: 12),
          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('开卷会员 · 解锁全部权益', style: TextStyle(color: Color(0xFFFFE9BF), fontSize: 13, fontWeight: FontWeight.w700)),
            SizedBox(height: 3),
            Text('云同步 · 主题市场 · AI 增强', style: TextStyle(color: Colors.white54, fontSize: 10)),
          ])),
          const Icon(CupertinoIcons.chevron_right, color: Color(0xFFFFE9BF), size: 18),
        ]),
      ),
    );
  }

  Widget _group(List<dynamic> items, BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 16, 18, 0),
      decoration: BoxDecoration(color: AppTheme.card, borderRadius: BorderRadius.circular(18), boxShadow: [AppTheme.cardShadow]),
      child: Column(children: items.map((it) => GestureDetector(
        onTap: () => _toast(context, it.$2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppTheme.line, width: .5))),
          child: Row(children: [
            Container(width: 34, height: 34, decoration: BoxDecoration(
              gradient: LinearGradient(colors: [it.$3, it.$3.withOpacity(.7)]), borderRadius: BorderRadius.circular(11)),
              child: Icon(it.$1, color: Colors.white, size: 19)),
            const SizedBox(width: 13),
            Expanded(child: Text(it.$2, style: const TextStyle(fontSize: 13, fontWeight: FontWeight(650)))),
            Text(it.$4, style: const TextStyle(fontSize: 11, color: AppTheme.ink3)),
            const SizedBox(width: 6),
            const Icon(CupertinoIcons.chevron_right, color: AppTheme.ink3, size: 16),
          ]),
        ),
      )).toList()),
    );
  }

  void _toast(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), duration: const Duration(milliseconds: 800)));
  }
}
