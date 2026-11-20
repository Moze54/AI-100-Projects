import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'asset_detail_page.dart' as detail_mod;

/// 生活资产列表页（静态复刻）。
class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_category.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '生活资产',
              actionIcon: Icons.add_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 统计
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
                    child: Row(
                      children: [
                        for (final it in const [
                          ('4', '资产总数'),
                          ('2', '保养中'),
                          ('1', '待年检'),
                          ('¥8.6万', '年维护'),
                        ]) ...[
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  it.$1,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    height: 1.0,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.navy,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  it.$2,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 资产卡片
                  const _AssetCard(
                    name: '小轿车 · 大众迈腾',
                    type: '车辆',
                    meta: '购入 2022-06 · 保修至 2027-06',
                    alert: '年检截止 12-15',
                    alertColor: AppColors.red,
                    icon: Icons.directions_car_rounded,
                    iconBg: Color(0xFF4A87F8),
                  ),
                  const SizedBox(height: 10),
                  const _AssetCard(
                    name: '首套房 · 朝阳小区',
                    type: '房屋',
                    meta: '购入 2020-03 · 保险生效中',
                    alert: null,
                    alertColor: AppColors.primary,
                    icon: Icons.cottage_rounded,
                    iconBg: Color(0xFFFF9D42),
                  ),
                  const SizedBox(height: 10),
                  const _AssetCard(
                    name: '净水器 · 小米厨下式',
                    type: '家电',
                    meta: '购入 2024-01 · 滤芯 3 个月一换',
                    alert: '滤芯更换 12-01',
                    alertColor: Color(0xFFFF9D42),
                    icon: Icons.water_drop_rounded,
                    iconBg: Color(0xFF2FB8A8),
                  ),
                  const SizedBox(height: 10),
                  const _AssetCard(
                    name: '小猫 · 英短银渐层',
                    type: '宠物',
                    meta: '疫苗 3/3 已完成 · 驱虫本月已做',
                    alert: '下次疫苗 2027-01',
                    alertColor: Color(0xFF3DBB7A),
                    icon: Icons.pets_rounded,
                    iconBg: Color(0xFFFF8FB0),
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

class _AssetCard extends StatelessWidget {
  final String name;
  final String type;
  final String meta;
  final String? alert;
  final Color alertColor;
  final IconData icon;
  final Color iconBg;

  const _AssetCard({
    required this.name,
    required this.type,
    required this.meta,
    required this.alert,
    required this.alertColor,
    required this.icon,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const detail_mod.AssetDetailPage()),
      ),
      child: GlassCard(
      padding: const EdgeInsets.all(14),
      radius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.navy,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      meta,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: iconBg.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.0,
                    fontWeight: FontWeight.w600,
                    color: iconBg,
                  ),
                ),
              ),
            ],
          ),
          if (alert != null) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: alertColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.alarm_rounded, size: 12, color: alertColor),
                  const SizedBox(width: 5),
                  Text(
                    alert!,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      color: alertColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      ),
    );
  }
}
