import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// 订阅与缴费页（静态复刻）。
class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_category.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '订阅与缴费',
              actionIcon: Icons.add_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 本月概览
                  GlassCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatItem(label: '本月待缴', value: '¥328.0'),
                        ),
                        Container(width: 1, height: 40, color: AppColors.divider),
                        Expanded(
                          child: _StatItem(label: '本月已缴', value: '¥566.5'),
                        ),
                        Container(width: 1, height: 40, color: AppColors.divider),
                        Expanded(
                          child: _StatItem(label: '自动续费', value: '3 项'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 订阅
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.workspace_premium_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '我的订阅',
                          trailing: '',
                        ),
                        const _SubRow(
                            name: '视频会员',
                            amount: '¥25.0',
                            cycle: '每月',
                            next: '5月1日',
                            auto: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SubRow(
                            name: '云空间 200GB',
                            amount: '¥21.0',
                            cycle: '每月',
                            next: '5月3日',
                            auto: true),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SubRow(
                            name: '健身房年卡',
                            amount: '¥2388.0',
                            cycle: '每年',
                            next: '6月15日',
                            auto: false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 生活缴费
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.receipt_long_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '生活缴费',
                          trailing: '',
                        ),
                        const _SubRow(
                            name: '电费',
                            amount: '¥186.5',
                            cycle: '每月',
                            next: '5月15日',
                            auto: false),
                        Container(height: 0.7, color: AppColors.divider),
                        const _SubRow(
                            name: '物业费',
                            amount: '¥380.0',
                            cycle: '每季度',
                            next: '已逾期 1 天',
                            auto: false,
                            overdue: true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 缴费历史
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.history_rounded,
                            color: Color(0xFF3DBB7A),
                            background: Color(0xFFE3F6EC),
                          ),
                          title: '缴费历史',
                          trailing: '全部',
                        ),
                        const _HistoryRow(
                            name: '视频会员 · 4月', amount: '¥25.0', date: '4月1日 已缴'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _HistoryRow(
                            name: '电费 · 4月', amount: '¥172.3', date: '4月15日 已缴'),
                        Container(height: 0.7, color: AppColors.divider),
                        const _HistoryRow(
                            name: '物业费 · 1季度', amount: '¥380.0', date: '1月20日 已缴'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '每次扣费前会按设置提前提醒，自动续费项可随时关闭',
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            height: 1.0,
            color: AppColors.textSub,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
      ],
    );
  }
}

class _SubRow extends StatelessWidget {
  final String name;
  final String amount;
  final String cycle;
  final String next;
  final bool auto;
  final bool overdue;

  const _SubRow({
    required this.name,
    required this.amount,
    required this.cycle,
    required this.next,
    required this.auto,
    this.overdue = false,
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
              color: overdue
                  ? const Color(0xFFFFE9EC)
                  : const Color(0xFFE3EEFF),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              overdue ? Icons.error_outline_rounded : Icons.subscriptions_rounded,
              size: 17,
              color: overdue ? const Color(0xFFE8607C) : AppColors.primary,
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
                      name,
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
                        color: overdue
                            ? const Color(0xFFE8607C).withValues(alpha: 0.12)
                            : const Color(0xFFE3F6EC),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        overdue ? next : '$cycle · $next',
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.0,
                          color: overdue
                              ? const Color(0xFFE8607C)
                              : const Color(0xFF2E9E66),
                        ),
                      ),
                    ),
                    if (auto) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFE9FF),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Text(
                          '自动续费',
                          style: TextStyle(
                            fontSize: 10,
                            height: 1.0,
                            color: Color(0xFF9C6BFF),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  overdue ? '原定 $cycle · 4月18日' : '计费周期 $cycle',
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    color: AppColors.textSub,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 15,
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
  final String name;
  final String amount;
  final String date;

  const _HistoryRow({
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: Row(
        children: [
          const Icon(Icons.check_circle_rounded,
              size: 16, color: Color(0xFF3DBB7A)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 13,
                height: 1.0,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
          ),
          Text(
            date,
            style: const TextStyle(
              fontSize: 11,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
        ],
      ),
    );
  }
}
