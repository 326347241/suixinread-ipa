import 'package:flutter/material.dart';

/// 全局主题配色 —— 逆向自 IPA 蓝粉渐变视觉体系
class AppTheme {
  static const Color brandBlue = Color(0xFF4A7DFF);
  static const Color brandPurple = Color(0xFF8B5CF6);
  static const Color brandPink = Color(0xFFFF5C9D);
  static const Color accent = Color(0xFF6C63FF);

  static const Color ink = Color(0xFF1A1C23);
  static const Color ink2 = Color(0xFF5B6072);
  static const Color ink3 = Color(0xFF9AA0B4);
  static const Color bg = Color(0xFFF6F7FB);
  static const Color card = Color(0xFFFFFFFF);
  static const Color line = Color(0x12141C28);
  static const Color glass = Color(0xB8FFFFFF);

  static const LinearGradient brandGradient = LinearGradient(
    colors: [brandBlue, brandPurple, brandPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static BoxShadow cardShadow = BoxShadow(
    color: const Color(0x141E285A),
    blurRadius: 30,
    offset: const Offset(0, 8),
  );

  /// 8 套内置主题（对应 IPA assets/skins 中的 8 组 collections）
  static const List<ThemePreset> themes = [
    ThemePreset('tidal', '潮汐', 'Tidal', 0xFFA8CBCC, 0xFF7FB3C9, 0xFF4A7DFF),
    ThemePreset('botanical', '植物', 'Botanical', 0xFFE1E6D7, 0xFFB8CC9E, 0xFF7CA05E),
    ThemePreset('celestial', '星海', 'Celestial', 0xFFDBD3EB, 0xFFA99BD6, 0xFF6C63FF),
    ThemePreset('cyber_neon', '赛博霓虹', 'Cyber Neon', 0xFFDEE5F6, 0xFF8B7FE8, 0xFFFF5C9D),
    ThemePreset('ink_wash', '水墨丹青', 'Ink Wash', 0xFFD0D1C8, 0xFF8A9A94, 0xFF475556),
    ThemePreset('bauhaus', '包豪斯', 'Bauhaus', 0xFFE2D8CF, 0xFFD98B5F, 0xFFDD663F),
    ThemePreset('monet_garden', '莫奈花园', 'Monet', 0xFFE4E9E4, 0xFFA8C4B4, 0xFF88A599),
    ThemePreset('retro_film', '复古胶片', 'Retro Film', 0xFFEBDCC3, 0xFFD9B98A, 0xFFC89B62),
  ];

  /// 阅读器纸张
  static const List<PaperPreset> papers = [
    PaperPreset('默认', 0xFFF4EFE2, 0xFF3A3226),
    PaperPreset('羊皮纸', 0xFFEFE4CF, 0xFF4A3D2A),
    PaperPreset('护眼绿', 0xFFDCEAD9, 0xFF2F4230),
    PaperPreset('淡蓝', 0xFFE3EDF5, 0xFF2C3D4D),
    PaperPreset('夜间', 0xFF1C1A18, 0xFFC9C2B4),
  ];

  /// 翻页动效（「流韵意境」系列）
  static const List<String> pageEffects = [
    '仿真翻页', '无效果', '左右平移', '上下滚动', '上下翻页',
    '水墨洇染', '思想的涟漪', '破冰融霜', '竹简百叶', '风起沙散', '折扇扫光', '透光显影',
  ];
}

class ThemePreset {
  final String id, name, en;
  final int c1, c2, c3;
  const ThemePreset(this.id, this.name, this.en, this.c1, this.c2, this.c3);
  Color get color1 => Color(c1);
  Color get color2 => Color(c2);
  Color get color3 => Color(c3);
}

class PaperPreset {
  final String name;
  final int bg, ink;
  const PaperPreset(this.name, this.bg, this.ink);
  Color get background => Color(bg);
  Color get textColor => Color(ink);
}
