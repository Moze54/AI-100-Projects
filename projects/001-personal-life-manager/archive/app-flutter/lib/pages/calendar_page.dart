import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'anniversary_page.dart' as anniv_mod;
import 'subscriptions_page.dart' as subs_mod;
import 'todos_page.dart' as todos_mod;

/// 日历月视图页（静态复刻）。
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_schedule.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: SubPageHeader(title: '日历'),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 月份切换
                  Row(
                    children: [
                      const Text(
                        '2026年4月',
                        style: TextStyle(
                          fontSize: 24,
                          height: 1.0,
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                        ),
                      ),
                      const Icon(Icons.expand_more_rounded,
                          size: 22, color: Color(0xFF6E7BA8)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          '今天',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const _MonthGrid(),
                  const SizedBox(height: 12),
                  const _DayEvents(),
                  const SizedBox(height: 12),
                  const _LegendCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 月历网格。
class _MonthGrid extends StatelessWidget {
  const _MonthGrid();

  static const _weekLabels = ['一', '二', '三', '四', '五', '六', '日'];

  @override
  Widget build(BuildContext context) {
    // 4月：1日为周三；29 日为今天（选中）。前 3 格 + 30 格 = 33 → 取前 35 格含下月补位
    const cells = [
      '', '', '1', '2', '3', '4', '5',
      '6', '7', '8', '9', '10', '11', '12',
      '13', '14', '15', '16', '17', '18', '19',
      '20', '21', '22', '23', '24', '25', '26',
      '27', '28', '29', '30', '', '', '',
    ];
    const dots = {29: AppColors.primary, 12: Color(0xFFFF8FB0), 26: Color(0xFFFFC46B)};
    return GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              for (final w in _weekLabels)
                Expanded(
                  child: Center(
                    child: Text(
                      w,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSub,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          for (var row = 0; row < 5; row++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  for (var col = 0; col < 7; col++)
                    Expanded(
                      child: _DayNumber(
                        label: cells[row * 7 + col],
                        day: row * 7 + col - 2,
                        selected: cells[row * 7 + col] == '29',
                        dotColor: dots[row * 7 + col - 2],
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

class _DayNumber extends StatelessWidget {
  final String label;
  final int day;
  final bool selected;
  final Color? dotColor;

  const _DayNumber({
    required this.label,
    required this.day,
    required this.selected,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    if (label.isEmpty) {
      return const SizedBox(height: 44);
    }
    return Column(
      children: [
        Container(
          width: 34,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: selected ? AppColors.gradBlue : null,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              height: 1.0,
              fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
              color: selected ? Colors.white : AppColors.navy,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor ?? Colors.transparent,
          ),
        ),
      ],
    );
  }
}

/// 当日事项列表。
class _DayEvents extends StatelessWidget {
  const _DayEvents();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.event_note_rounded,
              color: AppColors.primary,
              background: Color(0xFFE3EEFF),
            ),
            title: '4月29日 · 3 条事项',
            trailing: '全部',
          ),
          const SizedBox(height: 12),
          const _EventRow(
            time: '09:30',
            title: '去银行办理业务',
            place: '银行网点',
            done: true,
            color: Color(0xFF6FA3FE),
          ),
          const SizedBox(height: 12),
          const _EventRow(
            time: '19:00',
            title: '家庭聚餐',
            place: '家里',
            done: false,
            color: Color(0xFF66C79A),
          ),
          const SizedBox(height: 12),
          const _EventRow(
            time: '全天',
            title: '小猫的生日',
            place: '纪念日',
            done: false,
            color: Color(0xFFFF8FB0),
            isBirthday: true,
          ),
        ],
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final String time;
  final String title;
  final String place;
  final bool done;
  final Color color;
  final bool isBirthday;

  const _EventRow({
    required this.time,
    required this.title,
    required this.place,
    required this.done,
    required this.color,
    this.isBirthday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 46,
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 13,
              height: 1.0,
              fontWeight: FontWeight.w700,
              color: AppColors.navy,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isBirthday) ...[
                    const Icon(Icons.cake_rounded,
                        size: 14, color: Color(0xFFFF8FB0)),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.navy,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                place,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.0,
                  color: AppColors.textSub,
                ),
              ),
            ],
          ),
        ),
        if (done)
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF6FA3FE),
            ),
            child: const Icon(Icons.check_rounded, size: 14, color: Colors.white),
          ),
      ],
    );
  }
}

/// 图例卡（点按图例可跳到对应清单）。
class _LegendCard extends StatelessWidget {
  const _LegendCard();

  void _open(BuildContext context, String label) {
    final target = switch (label) {
      '待办' => const todos_mod.TodosPage(),
      '纪念日' => const anniv_mod.AnniversaryPage(),
      '缴费' => const subs_mod.SubscriptionsPage(),
      _ => null,
    };
    if (target != null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => target));
    }
  }

  @override
  Widget build(BuildContext context) {
    const items = [
      ('待办', Color(0xFF5B9BF8)),
      ('日程', Color(0xFF66C79A)),
      ('纪念日', Color(0xFFFF8FB0)),
      ('缴费', Color(0xFFFFC46B)),
    ];
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          for (final it in items) ...[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _open(context, it.$1),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: it.$2),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    it.$1,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ],
      ),
    );
  }
}
