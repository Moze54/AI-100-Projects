import 'dart:ui' show ImageFilter;

import 'package:material_ui/material_ui.dart';

/// 设计稿基准逻辑宽度（设计图 852px = 426dp @2x）。
const double kDesignWidth = 426;

/// 按屏幕宽计算设计稿缩放系数：360dp 设备约 0.845。
double designScaleOf(BuildContext context) {
  final w = MediaQuery.sizeOf(context).width;
  return (w / kDesignWidth).clamp(0.80, 1.20);
}

/// 页面缩放包装：内容按 426dp 设计稿宽度布局，再整体等比缩放适配屏幕，
/// 使任意宽度的设备都呈现与设计图一致的比例。
class DesignScaled extends StatelessWidget {
  final Widget child;

  const DesignScaled({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final scale = designScaleOf(context);
      // 缩放放在 OverflowBox 内层：命中测试时 OverflowBox 检查的是自身尺寸，
    // 若缩放在外层，屏幕下部（设计坐标 y > 屏高/缩放）的点击会被丢弃。
    return OverflowBox(
      alignment: Alignment.topCenter,
      minWidth: kDesignWidth,
      maxWidth: kDesignWidth,
      minHeight: 0,
      maxHeight: constraints.maxHeight / scale,
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topCenter,
        child: SizedBox(width: kDesignWidth, child: child),
      ),
    );
    });
  }
}

/// 拾记全局色板（取色自设计图）。
class AppColors {
  AppColors._();

  /// 主文字深蓝
  static const Color navy = Color(0xFF1B2D55);

  /// 次级文字
  static const Color textSub = Color(0xFF8A94B8);

  /// 辅助/弱文字
  static const Color textLight = Color(0xFFA6AFC9);

  /// 主题蓝
  static const Color primary = Color(0xFF4A87F8);
  static const Color primaryDeep = Color(0xFF3D7BF5);
  static const Color primaryLight = Color(0xFF6BA4FF);

  static const Color pink = Color(0xFFFF8FB0);
  static const Color red = Color(0xFFF5484E);
  static const Color divider = Color(0xFFE3ECF9);
  static const Color chevron = Color(0xFFB9C4DE);
  static const Color navInactive = Color(0xFF99A3B9);

  /// 页面浅蓝底色（背景图加载前兜底）
  static const Color scaffold = Color(0xFFD9E7FE);

  static const LinearGradient gradBlue = LinearGradient(
    colors: [Color(0xFF6BA4FF), Color(0xFF3D7BF5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradPurple = LinearGradient(
    colors: [Color(0xFFB49BFF), Color(0xFF8F6BFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradTeal = LinearGradient(
    colors: [Color(0xFF57D0BE), Color(0xFF2FB8A8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradOrange = LinearGradient(
    colors: [Color(0xFFFFC46B), Color(0xFFFF9D42)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradGreen = LinearGradient(
    colors: [Color(0xFF74D89E), Color(0xFF3DBB7A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient gradGrey = LinearGradient(
    colors: [Color(0xFFD6DCE8), Color(0xFFB9C1D2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// 毛玻璃卡片：背景模糊 + 半透明白 + 细描边 + 柔和投影。
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final EdgeInsetsGeometry? margin;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.radius = 20,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(radius);
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(
            color: Color(0x12406BAE),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.66),
              borderRadius: borderRadius,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.72),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// 顶部右侧圆形毛玻璃图标按钮（搜索 / 设置 / 铃铛）。
class RoundGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showRedDot;

  const RoundGlassButton({
    super.key,
    required this.icon,
    this.onTap,
    this.showRedDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withValues(alpha: 0.6),
          border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 21, color: AppColors.navy),
            if (showRedDot)
              Positioned(
                top: 8,
                right: 9,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 彩色渐变圆角方块图标（快捷入口 / 分类图标）。
class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final Gradient gradient;
  final double size;
  final double iconSize;
  final double radius;

  const GradientIconBox({
    super.key,
    required this.icon,
    required this.gradient,
    this.size = 46,
    this.iconSize = 22,
    this.radius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.last.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: iconSize, color: Colors.white),
    );
  }
}

/// 彩色小圆角图标底（卡片标题左侧）。
class ChipIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color background;

  const ChipIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}

/// 卡片区块标题行：左侧图标 + 标题，右侧"更多 ›"。
class SectionHeader extends StatelessWidget {
  final ChipIcon icon;
  final String title;
  final String trailing;
  final VoidCallback? onTrailingTap;

  /// 紧凑模式：半宽卡片使用，缩小图标与文字防止窄屏溢出。
  final bool compact;

  const SectionHeader({
    super.key,
    required this.icon,
    required this.title,
    this.trailing = '更多',
    this.onTrailingTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Icon(icon.icon, size: 13, color: icon.color),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 1.0,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            trailing,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSub,
            ),
          ),
          const Icon(Icons.chevron_right_rounded,
              size: 14, color: AppColors.chevron),
        ],
      );
    }
    return Row(
      children: [
        icon,
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTrailingTap,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Text(
                trailing,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSub,
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  size: 16, color: AppColors.chevron),
            ],
          ),
        ),
      ],
    );
  }
}

/// "最近记录 / 最近浏览"列表条目。
class RecordTile extends StatelessWidget {
  final String thumbAsset;
  final String title;
  final String subtitle;
  final Widget? titleIcon;
  final VoidCallback? onTap;

  const RecordTile({
    super.key,
    required this.thumbAsset,
    required this.title,
    required this.subtitle,
    this.titleIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 72,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                thumbAsset,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      if (titleIcon != null) ...[
                        titleIcon!,
                        const SizedBox(width: 4),
                      ],
                      Flexible(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.more_horiz_rounded,
                size: 20, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

/// 蓝色渐变悬浮新增按钮。
class AddFab extends StatelessWidget {
  final VoidCallback? onTap;

  const AddFab({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.gradBlue,
          border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x553D7BF5),
              blurRadius: 16,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, size: 26, color: Colors.white),
      ),
    );
  }
}

/// 底部 4 Tab 毛玻璃导航栏。
class GlassNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;

  /// 设计稿缩放系数：宽度保持满屏，仅内容尺寸随缩放变化。
  final double scale;

  const GlassNavBar({
    super.key,
    required this.index,
    required this.onChanged,
    this.scale = 1.0,
  });

  static const List<({String label, IconData icon})> _items = [
    (label: '首页', icon: Icons.home_rounded),
    (label: '分类', icon: Icons.grid_view_rounded),
    (label: '日程', icon: Icons.calendar_month_rounded),
    (label: '我的', icon: Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    final s = scale;
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28 * s)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 62 * s + bottomSafe,
          padding: EdgeInsets.only(bottom: bottomSafe),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.9), width: 1),
            ),
          ),
          child: Row(
            children: [
              for (var i = 0; i < _items.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(i),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _items[i].icon,
                          size: 26 * s,
                          color: i == index
                              ? AppColors.primary
                              : AppColors.navInactive,
                        ),
                        SizedBox(height: 3 * s),
                        Text(
                          _items[i].label,
                          style: TextStyle(
                            fontSize: 12 * s,
                            height: 1.0,
                            fontWeight:
                                i == index ? FontWeight.w700 : FontWeight.w500,
                            color: i == index
                                ? AppColors.primary
                                : AppColors.navInactive,
                          ),
                        ),
                        SizedBox(height: 4 * s),
                        Container(
                          width: 20 * s,
                          height: 3 * s,
                          decoration: BoxDecoration(
                            color: i == index
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 页面顶部通用头部：logo + 标题 + 副标题 + 搜索/设置按钮。
class PageHeader extends StatelessWidget {
  final String subtitle;
  final VoidCallback? onSearchTap;

  const PageHeader({super.key, required this.subtitle, this.onSearchTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/logo.png',
            width: 38,
            height: 38,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '拾记',
              style: TextStyle(
                fontSize: 21,
                height: 1.0,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                height: 1.0,
                color: Color(0xFF6E7BA8),
              ),
            ),
          ],
        ),
        const Spacer(),
        RoundGlassButton(
          icon: Icons.search_rounded,
          onTap: onSearchTap,
        ),
        const SizedBox(width: 10),
        const RoundGlassButton(icon: Icons.settings_rounded),
      ],
    );
  }
}

/// 子页面通用骨架：全屏背景 + 设计稿缩放。
class SubPageScaffold extends StatelessWidget {
  final String background;
  final Widget child;

  const SubPageScaffold({
    super.key,
    required this.background,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return DesignScaled(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              background,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            SafeArea(bottom: false, child: child),
          ],
        ),
      ),
    );
  }
}

/// 子页面顶部导航：返回 + 居中标题 + 右侧动作。
class SubPageHeader extends StatelessWidget {
  final String title;
  final IconData? actionIcon;
  final VoidCallback? onActionTap;

  const SubPageHeader({
    super.key,
    required this.title,
    this.actionIcon,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundGlassButton(
          icon: Icons.arrow_back_rounded,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        Expanded(
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                height: 1.0,
                fontWeight: FontWeight.w800,
                color: AppColors.navy,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 44,
          child: actionIcon == null
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.centerRight,
                  child: RoundGlassButton(
                    icon: actionIcon!,
                    onTap: onActionTap,
                  ),
                ),
        ),
      ],
    );
  }
}

/// 底部毛玻璃操作条（子页面通用）。
class SubPageBottomBar extends StatelessWidget {
  final Widget child;

  const SubPageBottomBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bottomSafe = MediaQuery.paddingOf(context).bottom;
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.only(
              left: 20, right: 20, top: 12, bottom: 12 + bottomSafe),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(
                  color: Colors.white.withValues(alpha: 0.9), width: 1),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

/// 彩色渐变主按钮（胶囊）。
class GradientPillButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final double height;
  final double fontSize;

  const GradientPillButton({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.height = 48,
    this.fontSize = 15,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: AppColors.gradBlue,
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x443D7BF5),
              blurRadius: 14,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: fontSize + 4, color: Colors.white),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: fontSize,
                height: 1.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
