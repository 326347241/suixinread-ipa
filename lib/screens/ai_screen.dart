import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suixin_read/data/mock_data.dart';
import 'package:suixin_read/models/book.dart';
import 'package:suixin_read/theme/app_theme.dart';

class AIScreen extends StatefulWidget {
  final bool fullScreen;
  final VoidCallback? onClose;
  const AIScreen({super.key, this.fullScreen = false, this.onClose});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> {
  final _controller = TextEditingController();
  final List<AiMessage> _messages = [];
  AiModel _model = MockData.aiModels.first;

  static const _suggestions = ['推荐几本好看的玄幻小说', '帮我分析这本书的主题', '整理我的阅读笔记', '修复失效的书源'];

  void _send([String? text]) {
    final q = (text ?? _controller.text).trim();
    if (q.isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(AiMessage(isUser: true, text: q));
      String reply;
      Book? card;
      if (q.contains('推荐') || q.contains('小说')) {
        reply = '根据你的阅读偏好（武侠、玄幻、穿越），为你推荐以下几本：';
        card = MockData.books[1];
      } else if (q.contains('分析')) {
        reply = '《神雕游侠》以经典武侠世界为背景，讲述现代人重生后的成长与抉择。融合了穿越、武侠与言情元素，前 5 章完成世界观建立与主角能力觉醒，属于典型的爽文开篇节奏。';
      } else {
        reply = '我理解你的问题：「$q」。作为阅读助手，我可以帮你推荐书籍、分析阅读内容、整理笔记和诊断书源问题。';
      }
      _messages.add(AiMessage(isUser: false, text: reply, recommendCard: card));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F2FF),
      body: Column(children: [
        const SizedBox(height: 52),
        _header(),
        Expanded(
          child: _messages.isEmpty ? _greeting() : ListView.builder(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 20),
            itemCount: _messages.length,
            itemBuilder: (c, i) => _bubble(_messages[i]),
          ),
        ),
        _composer(),
      ]),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          if (widget.fullScreen && widget.onClose != null)
            GestureDetector(onTap: widget.onClose, child: const Padding(
              padding: EdgeInsets.only(right: 12), child: Icon(CupertinoIcons.back, size: 24))),
          GestureDetector(
            onTap: () => _showModelPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [AppTheme.cardShadow]),
              child: Row(children: [
                Container(width: 26, height: 26, decoration: BoxDecoration(color: _model.color, borderRadius: BorderRadius.circular(9)),
                  child: Center(child: Text(_model.icon, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)))),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(_model.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight(750))),
                  Text('${_model.provider} · 在线', style: const TextStyle(fontSize: 10, color: AppTheme.ink3)),
                ]),
                const Icon(CupertinoIcons.chevron_right, size: 14),
              ]),
            ),
          ),
        ]),
        GestureDetector(onTap: () => setState(() => _messages.clear()),
          child: Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13), boxShadow: [AppTheme.cardShadow]),
            child: const Icon(CupertinoIcons.add, color: AppTheme.accent, size: 20))),
      ]),
    );
  }

  Widget _greeting() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(gradient: AppTheme.brandGradient, borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: AppTheme.brandPurple.withOpacity(.3), blurRadius: 24, offset: const Offset(0, 10))]),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 34)),
          const SizedBox(height: 14),
          const Text('你好，我是阅读助手', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Text('基于 ${_model.name} 驱动\n可以帮你荐书、分析阅读、修复书源',
            textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: AppTheme.ink3, height: 1.6)),
          const SizedBox(height: 18),
          Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center,
            children: _suggestions.map((s) => GestureDetector(
              onTap: () => _send(s),
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: AppTheme.accent.withOpacity(.08), borderRadius: BorderRadius.circular(14)),
                child: Text(s, style: const TextStyle(fontSize: 11, color: AppTheme.accent, fontWeight: FontWeight.w600))),
            )).toList()),
        ]),
      ),
    );
  }

  Widget _bubble(AiMessage m) {
    return Padding(padding: const EdgeInsets.only(bottom: 18), child: Row(
      mainAxisAlignment: m.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!m.isUser) _avatar(m),
        const SizedBox(width: 10),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: m.isUser ? AppTheme.accent : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16), topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(m.isUser ? 16 : 5), bottomRight: Radius.circular(m.isUser ? 5 : 16)),
              boxShadow: [AppTheme.cardShadow],
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.text, style: TextStyle(fontSize: 12.5, height: 1.7, color: m.isUser ? Colors.white : AppTheme.ink)),
              if (m.recommendCard != null) _recommendCard(m.recommendCard!),
            ]),
          ),
        ),
        if (m.isUser) _avatar(m),
      ],
    ));
  }

  Widget _avatar(AiMessage m) {
    return Container(width: 30, height: 30, decoration: BoxDecoration(
      gradient: m.isUser ? const LinearGradient(colors: [Color(0xFF94A3B8), Color(0xFF64748B)]) : AppTheme.brandGradient,
      borderRadius: BorderRadius.circular(10)),
      child: Center(child: Text(m.isUser ? '我' : '✦', style: const TextStyle(color: Colors.white, fontSize: 12))));
  }

  Widget _recommendCard(Book b) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFFF0F3FF), Color(0xFFFAF0F6)]),
        borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(width: 40, height: 54, decoration: BoxDecoration(gradient: b.coverGradient, borderRadius: BorderRadius.circular(5))),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(b.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          const SizedBox(height: 3),
          Text('${b.author} · ${b.category}', style: const TextStyle(fontSize: 10, color: AppTheme.ink3)),
        ]),
      ]),
    );
  }

  Widget _composer() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 34),
      decoration: BoxDecoration(color: AppTheme.glass, border: Border(top: BorderSide(color: AppTheme.line, width: .5))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: const Color(0x1A7882AA), borderRadius: BorderRadius.circular(12)),
          child: const Icon(CupertinoIcons.add, color: AppTheme.ink2, size: 20)),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 90),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), boxShadow: [AppTheme.cardShadow]),
            child: TextField(controller: _controller, maxLines: null,
              onSubmitted: (_) => _send(),
              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                border: InputBorder.none, hintText: '输入消息，与阅读助手对话…', hintStyle: TextStyle(fontSize: 12.5))),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(onTap: () => _send(),
          child: Container(width: 36, height: 36, decoration: BoxDecoration(gradient: AppTheme.brandGradient, borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: AppTheme.brandPurple.withOpacity(.35), blurRadius: 14, offset: const Offset(0, 5))]),
            child: const Icon(Icons.send, color: Colors.white, size: 18))),
      ]),
    );
  }

  void _showModelPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (c) => Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('选择 AI 模型', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          ...MockData.aiModels.map((m) => ListTile(
            leading: CircleAvatar(backgroundColor: m.color, child: Text(m.icon, style: const TextStyle(color: Colors.white))),
            title: Text(m.name, style: const TextStyle(fontSize: 13)),
            subtitle: Text(m.provider, style: const TextStyle(fontSize: 11)),
            trailing: m.name == _model.name ? const Icon(Icons.check, color: AppTheme.accent) : null,
            onTap: () { setState(() => _model = m); Navigator.pop(c); },
          )),
        ]),
      ),
    );
  }
}
