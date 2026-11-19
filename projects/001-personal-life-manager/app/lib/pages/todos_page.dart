import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'recurring_page.dart';

/// 待办清单页（静态复刻）。
class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_schedule.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '待办清单',
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
                          onTap: () {},
                          child: _ViewTab(label: '待办事项', count: 8, selected: true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const RecurringPage()),
                          ),
                          child: _ViewTab(label: '周期任务', count: 5, selected: false),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // 筛选
                  Row(
                    children: const [
                      _FilterChip(label: '全部 8', selected: true),
                      SizedBox(width: 8),
                      _FilterChip(label: '今天 3', selected: false),
                      SizedBox(width: 8),
                      _FilterChip(label: '本周 5', selected: false),
                      SizedBox(width: 8),
                      _FilterChip(label: '已逾期 1', selected: false),
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
                            icon: Icons.checklist_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '进行中',
                          trailing: '',
                        ),
                        const _TodoRow(
                            title: '缴纳物业费',
                            due: '已逾期 1 天',
                            overdue: true,
                            priority: '高',
                            priorityColor: Color(0xFFE8607C),
                            linked: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _TodoRow(
                            title: '整理房间',
                            due: '今天 20:00',
                            overdue: false,
                            priority: '中',
                            priorityColor: Color(0xFFFF9D42),
                            linked: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _TodoRow(
                            title: '购买生活用品',
                            due: '明天 10:00',
                            overdue: false,
                            priority: '低',
                            priorityColor: Color(0xFF3DBB7A),
                            linked: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _TodoRow(
                            title: '预约体检',
                            due: '周五 09:00',
                            overdue: false,
                            priority: '中',
                            priorityColor: Color(0xFFFF9D42),
                            linked: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 已完成
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.task_alt_rounded,
                            color: Color(0xFF3DBB7A),
                            background: Color(0xFFE3F6EC),
                          ),
                          title: '已完成',
                          trailing: '本周 4',
                        ),
                        const _DoneRow(title: '阅读一本好书', meta: '昨天 21:30 完成'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DoneRow(title: '给小猫剪指甲', meta: '昨天 09:12 完成'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _DoneRow(title: '修剪草坪', meta: '4月27日 15:40 完成'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '完成的待办保留在完成历史中，可随时查看与恢复',
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.0,
                        color: AppColors.textLight,
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

/// 顶部视图切换胶囊。
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

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChip({required this.label, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: selected
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: selected
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.8),
          width: selected ? 1.4 : 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          height: 1.0,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.primary : AppColors.textSub,
        ),
      ),
    );
  }
}

class _TodoRow extends StatelessWidget {
  final String title;
  final String due;
  final bool overdue;
  final String priority;
  final Color priorityColor;
  final bool linked;

  const _TodoRow({
    required this.title,
    required this.due,
    required this.overdue,
    required this.priority,
    required this.priorityColor,
    required this.linked,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFC9D4EA), width: 1.5),
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
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        priority,
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.0,
                          color: priorityColor,
                        ),
                      ),
                    ),
                    if (linked) ...[
                      const SizedBox(width: 5),
                      const Icon(Icons.link_rounded,
                          size: 13, color: AppColors.textLight),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  due,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: overdue
                        ? const Color(0xFFE8607C)
                        : AppColors.textSub,
                    fontWeight: overdue ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.drag_indicator_rounded,
              size: 18, color: AppColors.chevron),
        ],
      ),
    );
  }
}

class _DoneRow extends StatelessWidget {
  final String title;
  final String meta;

  const _DoneRow({required this.title, required this.meta});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFC9CFE0),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.0,
                    color: Color(0xFFB0BACC),
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  meta,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.0,
                    color: AppColors.textLight,
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
