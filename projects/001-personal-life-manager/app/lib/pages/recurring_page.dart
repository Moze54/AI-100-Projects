import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'todos_page.dart';

/// 周期任务页（静态复刻）。
class RecurringPage extends StatelessWidget {
  const RecurringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_schedule.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '周期任务',
              actionIcon: Icons.add_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 视图切换：待办 / 周期任务
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_) => const TodosPage()),
                            );
                          },
                          child: _ViewTab(label: '待办事项', count: 8, selected: false),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: _ViewTab(label: '周期任务', count: 5, selected: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 进行中
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.autorenew_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '进行中',
                          trailing: '',
                        ),
                        const _RecurRow(
                            title: '喂猫',
                            rule: '每天 08:00',
                            next: '明天 08:00',
                            streak: '连续 45 次',
                            paused: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _RecurRow(
                            title: '周报整理',
                            rule: '每周五 17:00',
                            next: '5月1日',
                            streak: '连续 8 次',
                            paused: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _RecurRow(
                            title: '给绿植浇水',
                            rule: '每 3 天',
                            next: '5月2日',
                            streak: '连续 21 次',
                            paused: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _RecurRow(
                            title: '房租缴纳',
                            rule: '每月 1 日',
                            next: '5月1日',
                            streak: '连续 14 次',
                            paused: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 已暂停
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.pause_circle_outline_rounded,
                            color: Color(0xFF99A3B9),
                            background: Color(0xFFEDF1F8),
                          ),
                          title: '已暂停',
                          trailing: '',
                        ),
                        const _RecurRow(
                            title: '整理车库',
                            rule: '每月第一个周末',
                            next: '已暂停 12 天',
                            streak: '累计 6 次',
                            paused: true),
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
                      '支持每天 / 每周 / 每月 / 每年及自定义间隔重复；编辑时可选择「仅本次」或「本次及后续」，已完成的执行记录保存在任务历史中。',
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

/// 顶部视图切换胶囊（与待办清单页同款）。
class _ViewTab extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;

  const _ViewTab({
    required this.label,
    required this.count,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.88)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Text(
        '$label · $count',
        style: TextStyle(
          fontSize: 13,
          height: 1.0,
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          color: selected ? AppColors.primary : AppColors.textSub,
        ),
      ),
    );
  }
}

class _RecurRow extends StatelessWidget {
  final String title;
  final String rule;
  final String next;
  final String streak;
  final bool paused;

  const _RecurRow({
    required this.title,
    required this.rule,
    required this.next,
    required this.streak,
    required this.paused,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: paused
                  ? const Color(0xFFEDF1F8)
                  : const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              paused ? Icons.pause_rounded : Icons.repeat_rounded,
              size: 17,
              color: paused ? const Color(0xFF99A3B9) : AppColors.primary,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3EEFF),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        rule,
                        style: const TextStyle(
                          fontSize: 10,
                          height: 1.0,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '下次 $next · $streak',
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
              color: paused
                  ? const Color(0xFFE3F6EC)
                  : const Color(0xFFEDF1F8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              paused ? '恢复' : '暂停',
              style: TextStyle(
                fontSize: 11,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: paused ? const Color(0xFF2E9E66) : AppColors.textSub,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
