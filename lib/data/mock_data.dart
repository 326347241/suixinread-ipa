import 'package:flutter/material.dart';
import 'package:suixin_read/models/book.dart';
import 'package:suixin_read/theme/app_theme.dart';

/// 静态数据 —— 与高保真原型 data.js 保持一一对应
class MockData {
  static const List<Book> books = [
    Book(id: 1, name: '神雕游侠', author: '必读居',
      cover: [AppTheme.brandBlue, AppTheme.brandPurple], progress: 68,
      badge: '连载', category: '小说',
      description: '一个大学生重生到异界，变成杨过，历经江湖风雨的传奇。从精尽人亡到易筋伐髓，一代游侠的成长之路就此展开。',
      tags: ['穿越', '武侠', '爽文'], words: '328.6万字'),
    Book(id: 2, name: '诡秘之主', author: '爱潜水的乌贼',
      cover: [Color(0xFF2B3A67), Color(0xFF5B7FB5)], progress: 34,
      badge: '完结', category: '小说',
      description: '蒸汽与机械的浪潮中，谁能触及非凡的真相。二十二途径，三百条序列，诡秘世界的神秘面纱缓缓揭开。',
      tags: ['玄幻', '克苏鲁', '蒸汽朋克'], words: '446.5万字'),
    Book(id: 3, name: '三体全集', author: '刘慈欣',
      cover: [Color(0xFF0F2027), Color(0xFF2C5364)], progress: 100,
      badge: '完结', category: '小说',
      description: '宇宙社会学、黑暗森林法则、降维打击——人类文明与三体文明的生死博弈。',
      tags: ['科幻', '硬科幻', '雨果奖'], words: '88万字'),
    Book(id: 4, name: '斗破苍穹', author: '天蚕土豆',
      cover: [Color(0xFF7B2FF7), Color(0xFFF107A3)], progress: 12,
      badge: '完结', category: '小说',
      description: '三十年河东，三十年河西，莫欺少年穷。废柴少年萧炎踏上炼药师与斗气修炼的巅峰之路。',
      tags: ['玄幻', '热血', '异火'], words: '620万字'),
    Book(id: 5, name: '红楼梦', author: '曹雪芹',
      cover: [Color(0xFFC31432), Color(0xFF240B36)], progress: 45,
      badge: '完结', category: '小说',
      description: '满纸荒唐言，一把辛酸泪。四大家族的兴衰沉浮，中国古典文学的巅峰之作。',
      tags: ['古典', '名著', '四大名著'], words: '96万字'),
    Book(id: 6, name: '盗墓笔记', author: '南派三叔',
      cover: [Color(0xFF134E5E), Color(0xFF71B280)], progress: 0,
      badge: '完结', category: '小说',
      description: '五十年前的一场盗墓事故，五十年后的七星鲁王宫。吴邪与张起灵揭开千年古墓的重重谜团。',
      tags: ['盗墓', '悬疑', '探险'], words: '145万字'),
    Book(id: 7, name: '时光代理人', author: 'bilibili',
      cover: [Color(0xFFF7971E), Color(0xFFFFD200)], progress: 22,
      badge: '漫画', category: '漫画',
      description: '经营着时光照相馆的程小时和陆光，拥有进入照片穿越时空的能力。',
      tags: ['漫画', '悬疑', '治愈'], words: '182话'),
    Book(id: 8, name: '一人之下', author: '米二',
      cover: [Color(0xFFE52D27), Color(0xFFB31217)], progress: 0,
      badge: '漫画', category: '漫画',
      description: '异人世界波澜壮阔，哪都通快递公司的临时工张楚岚卷入异人界的纷争。',
      tags: ['漫画', '国漫', '异人'], words: '620话'),
    Book(id: 9, name: '有声西游记', author: '佚名',
      cover: [Color(0xFFF2994A), Color(0xFFF2C94C)], progress: 15,
      badge: '音频', category: '音频',
      description: '经典名著有声演绎，唐僧师徒四人西天取经的传奇故事。',
      tags: ['有声书', '经典'], words: '104集'),
  ];

  static const List<Chapter> chapters = [
    Chapter(title: '第001章 精尽人亡', paragraphs: [
      '“为什么天气就是这么的闷热，让人连复习的欲望都没有了，”',
      '他慵懒地靠在椅子上，咬着笔尖，看着时钟，已经是夜晚十一点。',
      '这里是S大学，我们的主人公李庭是S大学大二的一名学生。',
      '李庭翻阅着课本，就觉得越是用心看就越是看不懂，就像念无字天书一样。',
      '“还是外面的空气清新呀，”李庭不禁感慨道。',
      '走出宿舍楼，李庭就信步走在幽静的操场上，夏夜的风打在他的脸上。',
    ]),
    Chapter(title: '第002章 重生为杨过', paragraphs: [
      '一道刺目的白光闪过，李庭只觉得天旋地转。',
      '等他再次睁开眼睛时，发现自己正躺在一处陌生的山谷之中。',
      '杨过！这个名字如同惊雷一般在他的脑海中炸响。',
      '“既然上天给了我重来一次的机会，这一世，我绝不会再让悲剧重演。”',
    ]),
    Chapter(title: '第003章 烈焰红唇', paragraphs: [
      '山谷中就在这时传来一阵清脆的脚步声，杨过警觉地躲到了一块巨石后面。',
      '来人身姿曼妙，一袭红衣在山风中猎猎作响，正是那小龙女。',
      '杨过的心跳不由得加快了几分。',
      '“我一定要改变命运，让这一世的我们不再分离。”他在心中暗暗发誓。',
    ]),
    Chapter(title: '第004章 冰魄银针', paragraphs: [
      '寒光一闪，一枚细若牛毛的银针破空而来，直射杨过面门。',
      '杨过凭着体内涌现的奇异本能，身子一侧，堪堪避过这一击。',
      '“谁？”一个冰冷的声音传来，带着几分讶异。',
      '江湖险恶，从此刻起，他真正感受到了这个世界的残酷。',
    ]),
  ];

  static const List<AiModel> aiModels = [
    AiModel(name: 'DeepSeek V3', provider: 'deepseek', color: Color(0xFF4D6BFE), icon: 'D'),
    AiModel(name: 'GPT-6 Astra', provider: 'openai', color: Color(0xFF10A37F), icon: 'G'),
    AiModel(name: 'Claude', provider: 'claude', color: Color(0xFFD97757), icon: 'C'),
    AiModel(name: 'Gemini', provider: 'gemini', color: Color(0xFF4285F4), icon: '✦'),
    AiModel(name: '通义千问', provider: 'qwen', color: Color(0xFFFF6A00), icon: '通'),
    AiModel(name: '智谱 GLM', provider: 'zhipu', color: Color(0xFF3859FF), icon: '智'),
    AiModel(name: 'Kimi', provider: 'moonshot', color: Color(0xFF1A1A1A), icon: 'K'),
    AiModel(name: '豆包', provider: 'doubao', color: Color(0xFF3370FF), icon: '豆'),
    AiModel(name: 'MiniMax', provider: 'minimax', color: Color(0xFFFF3B6B), icon: 'M'),
    AiModel(name: '硅基流动', provider: 'siliconflow', color: Color(0xFF7C3AED), icon: '硅'),
    AiModel(name: 'Groq', provider: 'groq', color: Color(0xFFF55036), icon: 'G'),
    AiModel(name: 'Azure OpenAI', provider: 'azure', color: Color(0xFF0078D4), icon: 'A'),
    AiModel(name: 'MiMo', provider: 'mimo', color: Color(0xFF8B5CF6), icon: '米'),
  ];

  static const List<String> hotCategories = [
    '玄幻奇幻', '武侠仙侠', '都市言情', '科幻未来',
    '悬疑推理', '历史军事', '游戏竞技', '动漫同人',
  ];
}
