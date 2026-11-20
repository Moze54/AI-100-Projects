import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 健康记录主页（静态复刻）。
class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '健康记录'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 今日概览
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          icon: Icons.monitor_weight_outlined,
                          color: const Color(0xFF4A87F8),
                          bg: const Color(0xFFE3EEFF),
                          label: '体重',
                          value: '52.5',
                          unit: 'kg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MetricCard(
                          icon: Icons.favorite_rounded,
                          color: const Color(0xFFF5484E),
                          bg: const Color(0xFFFFE9E9),
                          label: '血压',
                          value: '118/76',
                          unit: 'mmHg',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _MetricCard(
                          icon: Icons.bedtime_rounded,
                          color: const Color(0xFF9C6BFF),
                          bg: const Color(0xFFEFE9FF),
                          label: '睡眠',
                          value: '7.5',
                          unit: '小时',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _MetricCard(
                          icon: Icons.directions_run_rounded,
                          color: const Color(0xFF3DBB7A),
                          bg: const Color(0xFFE3F6EC),
                          label: '运动',
                          value: '32',
                          unit: '分钟',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 体重趋势
                  GlassCard(
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.trending_up_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '体重趋势 · 近 7 天',
                          trailing: '全部',
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 132,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              for (final pair in const [
                                ('一', 52.8),
                                ('二', 53.1),
                                ('三', 52.6),
                                ('四', 52.9),
                                ('五', 52.4),
                                ('六', 52.5),
                                ('日', 52.5),
                              ])
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 16,
                                        height: 18 + (pair.$2 - 52.0) * 70,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.gradBlue,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(6),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        pair.$1,
                                        style: const TextStyle(
                                          fontSize: 9,
                                          height: 1.0,
                                          color: AppColors.textLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 健康模块入口
                  GlassCard(
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.medical_services_outlined,
                            color: Color(0xFFF5484E),
                            background: Color(0xFFFFE9E9),
                          ),
                          title: '健康模块',
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Expanded(
                              child: _ModuleItem(
                                  label: '生理周期',
                                  icon: Icons.cyclone_rounded,
                                  color: Color(0xFFFF8FB0)),
                            ),
                            Expanded(
                              child: _ModuleItem(
                                  label: '用药提醒',
                                  icon: Icons.medication_rounded,
                                  color: Color(0xFF4A87F8)),
                            ),
                            Expanded(
                              child: _ModuleItem(
                                  label: '体检报告',
                                  icon: Icons.receipt_long_rounded,
                                  color: Color(0xFF9C6BFF)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: const [
                            Expanded(
                              child: _ModuleItem(
                                  label: '疫苗记录',
                                  icon: Icons.vaccines_rounded,
                                  color: Color(0xFF3DBB7A)),
                            ),
                            Expanded(
                              child: _ModuleItem(
                                  label: '复查安排',
                                  icon: Icons.event_available_rounded,
                                  color: Color(0xFFFF9D42)),
                            ),
                            Expanded(
                              child: _ModuleItem(
                                  label: '健康报告',
                                  icon: Icons.folder_shared_rounded,
                                  color: Color(0xFF2FB8A8)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SubPageBottomBar(
            child: GradientPillButton(
              label: '记一笔健康数据',
              icon: Icons.add_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bg;
  final String label;
  final String value;
  final String unit;

  const _MetricCard({
    required this.icon,
    required this.color,
    required this.bg,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 16,
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      unit,
                      style: const TextStyle(
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
    );
  }
}

class _ModuleItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ModuleItem({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(height: 7),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            height: 1.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF44507A),
          ),
        ),
      ],
    );
  }
}
