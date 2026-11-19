import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'add_record_page.dart' as add_mod;
import 'detail_page.dart' as detail_mod;
import 'health_page.dart' as health_mod;
import 'search_page.dart' as search_mod;
import 'vault_page.dart' as vault_mod;

/// 首页：今日概览 + 快捷入口 + 最近记录。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 175),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              subtitle: '记录生活 · 收藏美好',
              onSearchTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const search_mod.SearchPage()),
              ),
            ),
            const SizedBox(height: 132),
            const _TodayCard(),
            const SizedBox(height: 12),
            _QuickGrid(
              onVaultTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const vault_mod.VaultPage()),
              ),
            ),
            const SizedBox(height: 12),
            const _RecentCard(),
          ],
        ),
      ),
    );
  }
}

/// "今日 · 周二 4月29日"概览卡片。
class _TodayCard extends StatelessWidget {
  const _TodayCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Row(
            children: [
              const ChipIcon(
                icon: Icons.calendar_month_rounded,
                color: AppColors.primary,
                background: Color(0xFFE3EEFF),
              ),
              const SizedBox(width: 8),
              const Text(
                '今日 · 周二 4月29日',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const Spacer(),
              const Text(
                '查看全部',
                style: TextStyle(fontSize: 13, color: AppColors.textSub),
              ),
              const Icon(Icons.chevron_right_rounded,
                  size: 18, color: AppColors.chevron),
            ],
          ),
          const SizedBox(height: 16),
          // FittedBox 自适应缩放：窄屏（360dp）不溢出，宽屏保持原比例。
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 74,
                  child: _StatNumber(
                      value: '3',
                      label: '待办事项',
                      dotColor: Color(0xFF5B9BF8)),
                ),
                const _VerticalDivider(),
                const SizedBox(
                  width: 74,
                  child: _StatNumber(
                      value: '1',
                      label: '纪念日',
                      dotColor: Color(0xFFFF8FB0)),
                ),
                const _VerticalDivider(),
                const SizedBox(
                  width: 162,
                  child: Row(
                    children: [
                      _CloudProgress(percent: 0.28),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '28%',
                            style: TextStyle(
                              fontSize: 24,
                              height: 1.0,
                              fontWeight: FontWeight.w800,
                              color: AppColors.navy,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '云空间',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.0,
                              color: AppColors.textSub,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '(42GB / 150GB)',
                            style: TextStyle(
                              fontSize: 10,
                              height: 1.0,
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 大数字统计（待办 / 纪念日）。
class _StatNumber extends StatelessWidget {
  final String value;
  final String label;
  final Color dotColor;

  const _StatNumber({
    required this.value,
    required this.label,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 30,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotColor,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.0,
                  color: AppColors.textSub,
                ),
              ),
            ],
          ),
        ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white.withValues(alpha: 0.9),
    );
  }
}

/// 云空间进度环。
class _CloudProgress extends StatelessWidget {
  final double percent;

  const _CloudProgress({required this.percent});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(56, 56),
            painter: _RingPainter(percent: percent),
          ),
          Container(
            width: 26,
            height: 26,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.gradBlue,
            ),
            child: const Icon(Icons.cloud_rounded, size: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent;

  _RingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFD9E6FB);
    canvas.drawCircle(center, radius, track);

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: [Color(0xFF6BA4FF), Color(0xFF3D7BF5)],
        transform: GradientRotation(-math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percent,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.percent != percent;
}

/// 2x2 快捷入口。
class _QuickGrid extends StatelessWidget {
  final VoidCallback? onVaultTap;
  const _QuickGrid({super.key, this.onVaultTap});

  @override
  Widget build(BuildContext context) {
    const items = [
      (
        title: '新增记录',
        subtitle: '记录重要的事',
        icon: Icons.add_rounded,
        gradient: AppColors.gradBlue,
      ),
      (
        title: '上传文件',
        subtitle: '保存重要文件',
        icon: Icons.folder_rounded,
        gradient: AppColors.gradPurple,
      ),
      (
        title: '保险箱',
        subtitle: '加密私密内容',
        icon: Icons.shield_rounded,
        gradient: AppColors.gradTeal,
      ),
      (
        title: '健康记录',
        subtitle: '关注身体健康',
        icon: Icons.favorite_rounded,
        gradient: AppColors.gradOrange,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.35,
      padding: EdgeInsets.zero,
      children: [
        for (var idx = 0; idx < items.length; idx++)
          GestureDetector(
            onTap: switch (idx) {
              0 || 1 => () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const add_mod.AddRecordPage()),
                  ),
              2 => onVaultTap,
              3 => () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const health_mod.HealthPage()),
                  ),
              _ => null,
            },
            child: GlassCard(
              padding:
                  const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              child: Row(
                children: [
                  GradientIconBox(
                      icon: items[idx].icon,
                      gradient: items[idx].gradient,
                      size: 34,
                      iconSize: 17),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          items[idx].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          items[idx].subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.0,
                            color: AppColors.textSub,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      size: 16, color: AppColors.chevron),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// "最近记录"卡片。
class _RecentCard extends StatelessWidget {
  const _RecentCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.schedule_rounded,
              color: AppColors.primary,
              background: Color(0xFFE3EEFF),
            ),
            title: '最近记录',
            trailing: '更多',
          ),
          const SizedBox(height: 4),
          RecordTile(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const detail_mod.DetailPage()),
              ),
            thumbAsset: 'assets/images/thumb_sea.png',
            title: '旅行照片',
            subtitle: '今天 09:12 · 图片',
            titleIcon: Icon(Icons.image_rounded,
                size: 14, color: AppColors.primary),
          ),
          _TileDivider(),
          RecordTile(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const detail_mod.DetailPage()),
              ),
            thumbAsset: 'assets/images/thumb_doc.png',
            title: '租房合同',
            subtitle: '昨天 21:30 · 文件',
            titleIcon: Icon(Icons.description_rounded,
                size: 14, color: AppColors.primary),
          ),
          _TileDivider(),
          RecordTile(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const detail_mod.DetailPage()),
              ),
            thumbAsset: 'assets/images/thumb_cat.png',
            title: '小猫的疫苗记录',
            subtitle: '4月27日 · 生活',
            titleIcon: Icon(Icons.favorite_rounded,
                size: 14, color: AppColors.red),
          ),
        ],
      ),
    );
  }
}

class _TileDivider extends StatelessWidget {
  const _TileDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.7,
      margin: const EdgeInsets.only(left: 82, right: 4),
      color: AppColors.divider,
    );
  }
}
