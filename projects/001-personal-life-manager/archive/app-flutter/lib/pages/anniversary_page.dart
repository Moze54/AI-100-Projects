import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 重要日期 / 生日与纪念日页（静态复刻）。
class AnniversaryPage extends StatelessWidget {
  const AnniversaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_home.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '重要日期',
              actionIcon: Icons.add_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 最近一个纪念日
                  GlassCard(
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.asset(
                            'assets/images/cake.png',
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '最近的纪念日',
                                style: TextStyle(
                                  fontSize: 11,
                                  height: 1.0,
                                  color: AppColors.textSub,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '小猫的生日',
                                style: TextStyle(
                                  fontSize: 17,
                                  height: 1.0,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.navy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    '5月25日 · 还有 ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.2,
                                      color: AppColors.textSub,
                                    ),
                                  ),
                                  Text(
                                    '26',
                                    style: TextStyle(
                                      fontSize: 20,
                                      height: 1.0,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.red,
                                    ),
                                  ),
                                  Text(
                                    ' 天',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.2,
                                      color: AppColors.textSub,
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
                  const SizedBox(height: 12),
                  // 全部日期
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.cake_rounded,
                            color: Color(0xFFFF8FB0),
                            background: Color(0xFFFFEAF2),
                          ),
                          title: '全部日期',
                          trailing: '按最近排序',
                        ),
                        const _DateRow(
                            name: '小猫的生日',
                            date: '5月25日',
                            repeat: '每年',
                            days: 26,
                            near: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DateRow(
                            name: '结婚纪念日',
                            date: '9月10日',
                            repeat: '每年',
                            days: 134,
                            near: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DateRow(
                            name: '爸爸的生日',
                            date: '11月2日',
                            repeat: '每年 · 农历十月初三',
                            days: 188,
                            near: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DateRow(
                            name: '认识一周年',
                            date: '12月20日',
                            repeat: '每年',
                            days: 245,
                            near: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 说明
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.85), width: 1),
                    ),
                    child: const Text(
                      '重要日期默认每年重复，可设置提前提醒（建议提前 1 天）；支持公历与农历，关联资料后可快速找到相关照片和文件。',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: AppColors.textSub,
                      ),
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

class _DateRow extends StatelessWidget {
  final String name;
  final String date;
  final String repeat;
  final int days;
  final bool near;

  const _DateRow({
    required this.name,
    required this.date,
    required this.repeat,
    required this.days,
    required this.near,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: near
                  ? const Color(0xFFFFEAF2)
                  : const Color(0xFFEFE9FF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              near ? Icons.cake_rounded : Icons.event_available_rounded,
              size: 17,
              color: near ? const Color(0xFFFF8FB0) : const Color(0xFF9C6BFF),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$date · $repeat',
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: near
                  ? const Color(0xFFFFEAF2)
                  : Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$days 天',
              style: TextStyle(
                fontSize: 12,
                height: 1.0,
                fontWeight: FontWeight.w700,
                color: near ? const Color(0xFFE8607C) : AppColors.textSub,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
