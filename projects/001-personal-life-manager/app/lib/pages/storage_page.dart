import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 云空间管理页（静态复刻）。
class StoragePage extends StatelessWidget {
  const StoragePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_profile.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '云空间'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 容量环卡
                  GlassCard(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 92,
                          height: 92,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 92,
                                height: 92,
                                child: CustomPaint(
                                  painter: _StorageRingPainter(percent: 0.128),
                                ),
                              ),
                              Column(
                                children: const [
                                  Text(
                                    '12.8%',
                                    style: TextStyle(
                                      fontSize: 17,
                                      height: 1.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.navy,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    '已使用',
                                    style: TextStyle(
                                      fontSize: 10,
                                      height: 1.0,
                                      color: AppColors.textSub,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '128 MB / 10 GB',
                                style: TextStyle(
                                  fontSize: 15,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '订阅容量 10 GB · 有效期至 2027-01-01',
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 1.3,
                                  color: AppColors.textSub,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  gradient: AppColors.gradBlue,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text(
                                  '升级容量',
                                  style: TextStyle(
                                    fontSize: 12,
                                    height: 1.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 空间占用明细
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.pie_chart_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '空间占用',
                          trailing: '',
                        ),
                        const SizedBox(height: 6),
                        _UsageRow(
                            label: '图片',
                            size: '64 MB',
                            percent: 0.5,
                            color: const Color(0xFF4A87F8)),
                        _UsageRow(
                            label: '文件',
                            size: '40 MB',
                            percent: 0.31,
                            color: const Color(0xFF9C6BFF)),
                        _UsageRow(
                            label: '健康记录',
                            size: '14 MB',
                            percent: 0.11,
                            color: const Color(0xFFF5484E)),
                        _UsageRow(
                            label: '其他',
                            size: '10 MB',
                            percent: 0.08,
                            color: const Color(0xFF99A3B9)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 同步范围
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.cloud_sync_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '同步范围',
                          trailing: '',
                        ),
                        const _SwitchRow(label: '总同步开关', on: true),
                        _SwitchRow(label: '图片', on: true),
                        _SwitchRow(label: '健康记录', on: false),
                        _SwitchRow(label: '保险箱（加密同步）', on: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 订单
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        _ActionRow(
                            icon: Icons.receipt_long_rounded,
                            label: '订单与购买记录',
                            trailing: '2 笔订单'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _ActionRow(
                            icon: Icons.history_rounded,
                            label: '历史版本占用',
                            trailing: '86 MB'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageRingPainter extends CustomPainter {
  final double percent;
  _StorageRingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    final track = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFDCE9FB);
    canvas.drawCircle(center, radius, track);
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
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
  bool shouldRepaint(covariant _StorageRingPainter old) =>
      old.percent != percent;
}

class _UsageRow extends StatelessWidget {
  final String label;
  final String size;
  final double percent;
  final Color color;

  const _UsageRow({
    required this.label,
    required this.size,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.0,
                  color: AppColors.navy,
                ),
              ),
              const Spacer(),
              Text(
                size,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSub,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: SizedBox(
              height: 5,
              child: Stack(
                children: [
                  Container(color: AppColors.divider),
                  FractionallySizedBox(
                    widthFactor: percent,
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool on;

  const _SwitchRow({required this.label, required this.on});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              height: 1.0,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 22,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: on ? const Color(0xFF6FA3FE) : const Color(0xFFC9D4EA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Align(
              alignment: on ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String trailing;

  const _ActionRow({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 11),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              height: 1.0,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          Text(
            trailing,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right_rounded,
              size: 18, color: AppColors.chevron),
        ],
      ),
    );
  }
}
