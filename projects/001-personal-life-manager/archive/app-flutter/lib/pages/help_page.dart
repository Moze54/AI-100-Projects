import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'feedback_page.dart';

/// 帮助与常见问题页（静态复刻）。
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      background: 'assets/images/bg_search.png',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: const SubPageHeader(
              title: '帮助与常见问题',
              actionIcon: Icons.support_agent_rounded,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 搜索
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.66),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.9), width: 1),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search_rounded,
                            size: 18, color: AppColors.textLight),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '搜索问题，如「备份」「保险箱」「提醒」',
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.0,
                              color: AppColors.textLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 快速上手
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.rocket_launch_rounded,
                            color: AppColors.primary,
                            background: Color(0xFFE3EEFF),
                          ),
                          title: '快速上手',
                          trailing: '',
                        ),
                        const _FaqRow(
                          question: '如何快速添加一条记录？',
                          answer:
                              '点击首页右下角的「+」按钮，选择文字、拍照或文件方式新增；也可以把内容先复制到剪贴板，使用「自动识别」一键整理成结构化记录。',
                          expanded: true,
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FaqRow(
                          question: '首页的今日概览包含哪些内容？',
                          answer: '',
                          expanded: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 资料与保险箱
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.lock_rounded,
                            color: Color(0xFF9C6BFF),
                            background: Color(0xFFEFE9FF),
                          ),
                          title: '资料与保险箱',
                          trailing: '',
                        ),
                        const _FaqRow(
                          question: '保险箱里的内容会被加密吗？',
                          answer:
                              '会。保险箱内容使用端到端加密，密钥只保存在你的设备上，服务器与后台均无法读取明文。',
                          expanded: true,
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FaqRow(
                          question: '证件类资料如何防过期？',
                          answer: '',
                          expanded: false,
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FaqRow(
                          question: '如何把资料互相关联起来？',
                          answer: '',
                          expanded: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 备份与同步
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.cloud_sync_rounded,
                            color: Color(0xFF3DBB7A),
                            background: Color(0xFFE3F6EC),
                          ),
                          title: '备份与同步',
                          trailing: '',
                        ),
                        const _FaqRow(
                          question: '换新手机如何迁移数据？',
                          answer:
                              '在新设备登录同一账号后，进入「设置 → 备份与恢复」，选择最近一次备份进行恢复；恢复前会校验完整性并提示将覆盖的内容。',
                          expanded: true,
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _FaqRow(
                          question: '为什么提醒偶尔会延迟？',
                          answer: '',
                          expanded: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // 联系我们
                  GlassCard(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        const SectionHeader(
                          icon: ChipIcon(
                            icon: Icons.headset_mic_rounded,
                            color: Color(0xFFFF9D42),
                            background: Color(0xFFFFF0E0),
                          ),
                          title: '联系我们',
                          trailing: '',
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const FeedbackPage()),
                          ),
                          child: const _ContactRow(
                              icon: Icons.feedback_rounded,
                              label: '意见反馈',
                              value: '提交建议'),
                        ),
                        Container(height: 0.7, color: AppColors.divider),
                        const _ContactRow(
                            icon: Icons.mail_rounded,
                            label: '客服邮箱',
                            value: 'support@shiji.app'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '在线客服服务时间：工作日 9:00 - 18:00',
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

class _FaqRow extends StatelessWidget {
  final String question;
  final String answer;
  final bool expanded;

  const _FaqRow({
    required this.question,
    required this.answer,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EEFF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    'Q',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.0,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.navy,
                  ),
                ),
              ),
              Icon(
                expanded
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: AppColors.chevron,
              ),
            ],
          ),
        ),
        if (expanded && answer.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 4, bottom: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: AppColors.textSub.withValues(alpha: 0.95),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.0,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              height: 1.0,
              color: AppColors.textSub,
            ),
          ),
          const SizedBox(width: 2),
          const Icon(Icons.chevron_right_rounded,
              size: 18, color: AppColors.chevron),
        ],
      ),
    );
  }
}
