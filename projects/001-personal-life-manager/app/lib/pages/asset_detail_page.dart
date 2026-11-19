import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 资产详情页（静态复刻：小轿车示例）。
class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '资产详情',
              actionIcon: Icons.more_horiz_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 概览卡
                  GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: AppColors.gradBlue,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.directions_car_rounded,
                              size: 28, color: Colors.white),
                        ),
                        const SizedBox(width: 13),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '小轿车 · 大众迈腾',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '车辆 · 购入 2022-06',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.0,
                                  color: AppColors.textSub,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: const [
                                  _MiniTag(label: '保修中', color: Color(0xFF3DBB7A)),
                                  SizedBox(width: 6),
                                  _MiniTag(label: '常用', color: AppColors.primary),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 提醒横幅
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFE3E0), Color(0xFFFFD1CC)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.7), width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.alarm_rounded,
                            size: 19, color: AppColors.red),
                        const SizedBox(width: 9),
                        const Text(
                          '年检截止 ',
                          style: TextStyle(
                              fontSize: 13,
                              height: 1.0,
                              color: Color(0xFF9A5550)),
                        ),
                        const Text(
                          '12-15',
                          style: TextStyle(
                            fontSize: 17,
                            height: 1.0,
                            fontWeight: FontWeight.w800,
                            color: AppColors.red,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Text(
                            '设提醒',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 基本信息
                  const _InfoCard(title: '基本信息', rows: [
                    ('品牌型号', '大众 迈腾 330TSI'),
                    ('车牌号', '京A·***12'),
                    ('购买日期', '2022-06-18'),
                    ('购买价格', '¥21.9 万'),
                  ]),
                  const SizedBox(height: 12),
                  // 关键日期
                  const _InfoCard(title: '保险与年检', rows: [
                    ('交强险到期', '2026-06-18'),
                    ('商业险到期', '2026-06-18'),
                    ('下次年检', '2026-12-15'),
                    ('下次保养', '12000 km / 2026-03'),
                  ]),
                  const SizedBox(height: 12),
                  // 维护历史
                  GlassCard(
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.build_circle_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '维护历史',
                          trailing: '全部',
                        ),
                        const SizedBox(height: 10),
                        const _MaintRow(
                            date: '2025-06-20',
                            title: '常规保养',
                            cost: '¥680',
                            note: '更换机油机滤'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _MaintRow(
                            date: '2025-03-15',
                            title: '更换雨刮',
                            cost: '¥120',
                            note: '前窗一对'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _MaintRow(
                            date: '2024-12-18',
                            title: '年检',
                            cost: '¥300',
                            note: '检测站：京朝分所'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SubPageBottomBar(
            child: Row(
              children: [
                Expanded(
                  child: GradientPillButton(
                    label: '添加维护记录',
                    icon: Icons.add_rounded,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3EEFF),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.8), width: 1),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open_rounded,
                            size: 17, color: AppColors.primary),
                        SizedBox(width: 7),
                        Text(
                          '关联文件',
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.0,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
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

class _MiniTag extends StatelessWidget {
  final String label;
  final Color color;
  const _MiniTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          height: 1.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<(String, String)> rows;

  const _InfoCard({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 4),
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Container(height: 0.7, color: AppColors.divider),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Text(
                    rows[i].$1,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      rows[i].$2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.navy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MaintRow extends StatelessWidget {
  final String date;
  final String title;
  final String cost;
  final String note;

  const _MaintRow({
    required this.date,
    required this.title,
    required this.cost,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFF9D42),
                ),
              ),
              Container(
                width: 2,
                height: 26,
                color: const Color(0xFFFFE3CC),
              ),
            ],
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      cost,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$date · $note',
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: AppColors.textSub,
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
