import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'anniversary_page.dart' as anniv_mod;
import 'calendar_page.dart' as calendar_mod;
import 'search_page.dart' as search_mod;
import 'todos_page.dart' as todos_mod;

/// 日程页：日期 + 周历 + 今日安排 + 纪念日/待办 + 日程分类。
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

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
              subtitle: '收藏生活 · 记录美好',
              onSearchTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const search_mod.SearchPage()),
              ),
            ),
            const SizedBox(height: 14),
            const _DateTitle(),
            const SizedBox(height: 86),
            const _WeekStrip(),
            const SizedBox(height: 12),
            const _TodayPlan(),
            const SizedBox(height: 12),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _AnniversaryCard()),
                SizedBox(width: 12),
                Expanded(child: _TodoCard()),
              ],
            ),
            const SizedBox(height: 12),
            const _ScheduleCategories(),
          ],
        ),
      ),
    );
  }
}

class _DateTitle extends StatelessWidget {
  const _DateTitle();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '4月29日',
          style: TextStyle(
            fontSize: 30,
            height: 1.0,
            fontWeight: FontWeight.w800,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              Text(
                '周二',
                style: TextStyle(fontSize: 13, color: Color(0xFF6E7BA8)),
              ),
              Icon(Icons.expand_more_rounded, size: 16, color: Color(0xFF6E7BA8)),
            ],
          ),
        ),
      ],
    );
  }
}

/// 周历条。
class _WeekStrip extends StatelessWidget {
  const _WeekStrip();

  static const _days = [
    (week: '一', date: '28', lunar: '廿一'),
    (week: '二', date: '29', lunar: '廿二'),
    (week: '三', date: '30', lunar: '廿三'),
    (week: '四', date: '1', lunar: '廿四'),
    (week: '五', date: '2', lunar: '廿五'),
    (week: '六', date: '3', lunar: '廿六'),
    (week: '日', date: '4', lunar: '廿七'),
  ];

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.chevron_left_rounded, size: 20, color: Color(0xFFC4CFE8)),
          Expanded(
            child: Row(
              children: [
                for (final d in _days)
                  Expanded(
                    child: _DayCell(
                      week: d.week,
                      date: d.date,
                      lunar: d.lunar,
                      selected: d.date == '29',
                    ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 20, color: Color(0xFFC4CFE8)),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final String week;
  final String date;
  final String lunar;
  final bool selected;

  const _DayCell({
    required this.week,
    required this.date,
    required this.lunar,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          week,
          style: const TextStyle(
            fontSize: 11,
            height: 1.0,
            color: AppColors.textSub,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 34,
          height: 36,
          decoration: BoxDecoration(
            gradient: selected ? AppColors.gradBlue : null,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 16,
              height: 1.0,
              fontWeight: FontWeight.w800,
              color: selected ? Colors.white : AppColors.navy,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? AppColors.primary : Colors.transparent,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          lunar,
          style: const TextStyle(
            fontSize: 10,
            height: 1.0,
            color: AppColors.textLight,
          ),
        ),
      ],
    );
  }
}

/// 今日安排（时间线）。
class _TodayPlan extends StatelessWidget {
  const _TodayPlan();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          SectionHeader(
            icon: const ChipIcon(
              icon: Icons.calendar_month_rounded,
              color: AppColors.primary,
              background: Color(0xFFE3EEFF),
            ),
            title: '今日安排',
            trailing: '全部',
            onTrailingTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const calendar_mod.CalendarPage()),
            ),
          ),
          const SizedBox(height: 16),
          _PlanRow(
            time: '09:30',
            until: '1小时后',
            title: '去银行办理业务',
            place: '银行网点',
            done: true,
            lineColor: const Color(0xFF6FA3FE),
          ),
          const SizedBox(height: 14),
          _PlanRow(
            time: '19:00',
            until: '10小时后',
            title: '家庭聚餐',
            place: '家里',
            done: false,
            lineColor: const Color(0xFF66C79A),
          ),
        ],
      ),
    );
  }
}

class _PlanRow extends StatelessWidget {
  final String time;
  final String until;
  final String title;
  final String place;
  final bool done;
  final Color lineColor;

  const _PlanRow({
    required this.time,
    required this.until,
    required this.title,
    required this.place,
    required this.done,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 62,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.0,
                  fontWeight: FontWeight.w800,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.schedule_rounded,
                      size: 11, color: AppColors.textLight),
                  const SizedBox(width: 3),
                  Text(
                    until,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.0,
                      color: AppColors.textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 46,
          margin: const EdgeInsets.only(right: 14),
          child: CustomPaint(painter: _TimelinePainter(color: lineColor)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(Icons.place_rounded,
                      size: 12, color: AppColors.textSub),
                  const SizedBox(width: 3),
                  Text(
                    place,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.0,
                      color: AppColors.textSub,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? const Color(0xFF6FA3FE) : Colors.transparent,
            border: done
                ? null
                : Border.all(color: const Color(0xFFC9D4EA), width: 2),
          ),
          child: done
              ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
              : null,
        ),
      ],
    );
  }
}

/// 时间线：顶部圆点 + 竖线。
class _TimelinePainter extends CustomPainter {
  final Color color;

  _TimelinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final dotX = size.width / 2;
    final dotPaint = Paint()..color = color;
    canvas.drawCircle(Offset(dotX, 7), 3.5, dotPaint);
    final linePaint = Paint()
      ..color = color.withValues(alpha: 0.45)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(dotX, 14),
      Offset(dotX, size.height - 4),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimelinePainter oldDelegate) =>
      oldDelegate.color != color;
}

/// 纪念日卡片（左半）。
class _AnniversaryCard extends StatelessWidget {
  const _AnniversaryCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const anniv_mod.AnniversaryPage()),
      ),
      child: GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SectionHeader(
            compact: true,
            icon: ChipIcon(
              icon: Icons.cake_rounded,
              color: Color(0xFFFF8FB0),
              background: Color(0xFFFFEAF2),
            ),
            title: '纪念日',
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/cake.png',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '小猫的生日',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          '还有 ',
                          style: TextStyle(
                            fontSize: 12,
                            height: 1.2,
                            color: AppColors.textSub,
                          ),
                        ),
                        Text(
                          '26',
                          style: TextStyle(
                            fontSize: 22,
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
        ],
      ),
      ),
    );
  }
}

/// 待办事项卡片（右半）。
class _TodoCard extends StatelessWidget {
  const _TodoCard();

  @override
  Widget build(BuildContext context) {
    const todos = [
      (label: '整理房间', done: false),
      (label: '购买生活用品', done: false),
      (label: '阅读一本好书', done: true),
    ];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const todos_mod.TodosPage()),
      ),
      child: GlassCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SectionHeader(
            compact: true,
            icon: ChipIcon(
              icon: Icons.verified_rounded,
              color: Color(0xFF9C6BFF),
              background: Color(0xFFEFE9FF),
            ),
            title: '待办事项',
          ),
          const SizedBox(height: 10),
          for (final t in todos)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: t.done ? const Color(0xFFC9CFE0) : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: t.done
                          ? null
                          : Border.all(
                              color: const Color(0xFFC9D4EA), width: 1.5),
                    ),
                    child: t.done
                        ? const Icon(Icons.check_rounded,
                            size: 13, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    t.label,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.0,
                      color: t.done ? const Color(0xFFB0BACC) : AppColors.navy,
                      decoration:
                          t.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      ),
    );
  }
}

/// 日程分类横排。
class _ScheduleCategories extends StatelessWidget {
  const _ScheduleCategories();

  @override
  Widget build(BuildContext context) {
    const items = [
      (label: '全部', icon: Icons.calendar_month_rounded, gradient: AppColors.gradBlue, active: true),
      (label: '工作', icon: Icons.work_rounded, gradient: AppColors.gradGreen, active: false),
      (label: '生活', icon: Icons.home_rounded, gradient: AppColors.gradOrange, active: false),
      (label: '健康', icon: Icons.favorite_rounded, gradient: AppColors.gradPurple, active: false),
      (label: '出行', icon: Icons.flight_takeoff_rounded, gradient: AppColors.gradTeal, active: false),
      (label: '其他', icon: Icons.more_horiz_rounded, gradient: AppColors.gradGrey, active: false),
    ];
    return GlassCard(
      child: Column(
        children: [
          const SectionHeader(
            icon: ChipIcon(
              icon: Icons.layers_rounded,
              color: AppColors.primary,
              background: Color(0xFFE3EEFF),
            ),
            title: '日程分类',
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                Column(
                  children: [
                    GradientIconBox(
                      icon: item.icon,
                      gradient: item.gradient,
                      size: 40,
                      iconSize: 18,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        height: 1.0,
                        fontWeight:
                            item.active ? FontWeight.w700 : FontWeight.w500,
                        color: item.active
                            ? AppColors.primary
                            : AppColors.textSub,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 16,
                      height: 3,
                      decoration: BoxDecoration(
                        color: item.active
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
