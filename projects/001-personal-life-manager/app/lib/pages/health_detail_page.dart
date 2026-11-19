import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 血压记录详情页（含添加表单 + 历史）。
class HealthDetailPage extends StatelessWidget {
  const HealthDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_detail.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(title: '血压记录'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 添加表单
                  GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.favorite_rounded,
                            color: Color(0xFFF5484E),
                            background: Color(0xFFFFE9E9),
                          ),
                          title: '添加血压记录',
                          trailing: '',
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _ValueBox(label: '收缩压', value: '118'),
                            ),
                            const SizedBox(width: 10),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 14),
                              child: Text(
                                '/',
                                style: TextStyle(
                                    fontSize: 20, color: AppColors.textSub),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _ValueBox(label: '舒张压', value: '76'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Icon(Icons.schedule_rounded,
                                size: 15, color: AppColors.textSub),
                            const SizedBox(width: 8),
                            const Text(
                              '记录时间',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.0,
                                color: AppColors.textSub,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                '今天 09:30',
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.navy,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.notes_rounded,
                                size: 15, color: AppColors.textSub),
                            const SizedBox(width: 8),
                            const Text(
                              '备注',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.0,
                                color: AppColors.textSub,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '晨起测量，状态良好',
                              style: TextStyle(
                                fontSize: 13,
                                height: 1.0,
                                color: AppColors.navy.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        GradientPillButton(
                          label: '保存记录',
                          icon: Icons.check_rounded,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 历史记录
                  GlassCard(
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.history_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '历史记录',
                          trailing: '全部',
                        ),
                        const SizedBox(height: 6),
                        const _HistoryRow(
                            date: '今天 09:30',
                            value: '118/76',
                            tag: '正常',
                            tagColor: Color(0xFF3DBB7A)),
                        Container(height: 0.7, color: AppColors.divider),
                        const _HistoryRow(
                            date: '昨天 08:10',
                            value: '122/80',
                            tag: '正常',
                            tagColor: Color(0xFF3DBB7A)),
                        Container(height: 0.7, color: AppColors.divider),
                        const _HistoryRow(
                            date: '11-17 08:05',
                            value: '130/88',
                            tag: '偏高',
                            tagColor: Color(0xFFFF9D42)),
                        Container(height: 0.7, color: AppColors.divider),
                        const _HistoryRow(
                            date: '11-16 09:00',
                            value: '121/78',
                            tag: '正常',
                            tagColor: Color(0xFF3DBB7A)),
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

class _ValueBox extends StatelessWidget {
  final String label;
  final String value;

  const _ValueBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.white.withValues(alpha: 0.9), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  final String date;
  final String value;
  final String tag;
  final Color tagColor;

  const _HistoryRow({
    required this.date,
    required this.value,
    required this.tag,
    required this.tagColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          const Icon(Icons.favorite_rounded,
              size: 14, color: Color(0xFFF5484E)),
          const SizedBox(width: 9),
          Text(
            date,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 11,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: tagColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
