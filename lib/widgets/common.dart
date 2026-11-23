import 'package:flutter/material.dart';
import 'package:suixin_read/theme/app_theme.dart';

/// 通用：玻璃顶栏
class GlassTopBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final Widget? leading;
  const GlassTopBar({
    super.key, required this.title, this.actions = const [], this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.glass,
        border: Border(bottom: BorderSide(color: AppTheme.line, width: .5)),
      ),
      child: Row(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: Text(title, style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800, letterSpacing: -.5)),
          ),
          ...actions,
        ],
      ),
    );
  }
}

/// 通用：圆形图标按钮
class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final Color? color;
  const CircleIconButton({super.key, required this.icon, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: color ?? const Color(0x1A7882AA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, size: 20, color: AppTheme.ink),
      ),
    );
  }
}

/// 通用：渐变按钮
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final double? width, height;
  const GradientButton({
    super.key, required this.text, this.onTap, this.width, this.height = 44,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity, height: height,
        decoration: BoxDecoration(
          gradient: AppTheme.brandGradient,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(
            color: AppTheme.brandPurple.withOpacity(.3), blurRadius: 16, offset: const Offset(0, 6))],
        ),
        child: Center(child: Text(text, style: const TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight(750)))),
      ),
    );
  }
}
