import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

import 'pages/add_record_page.dart';
import 'pages/category_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/schedule_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const ShijiApp());
}

class ShijiApp extends StatelessWidget {
  const ShijiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '拾记',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: AppColors.scaffold,
      ),
      // 锁定系统字体缩放，保证与设计图布局一致。
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(textScaler: TextScaler.noScaling),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const RootShell(),
    );
  }
}

/// 4 Tab 主框架：整页背景 + 页面切换 + 悬浮新增按钮 + 底部导航。
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    HomePage(),
    CategoryPage(),
    SchedulePage(),
    ProfilePage(),
  ];

  static const List<String> _backgrounds = [
    'assets/images/bg_home.png',
    'assets/images/bg_category.png',
    'assets/images/bg_schedule.png',
    'assets/images/bg_profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    // 全局设计稿缩放：页面、FAB、底栏按同一系数等比缩放。
    final scale = designScaleOf(context);
    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 每个页面对应的全屏插画背景。
          Image.asset(
            _backgrounds[_index],
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            gaplessPlayback: true,
          ),
          IndexedStack(
            index: _index,
            children: [
              for (final page in _pages) DesignScaled(child: page),
            ],
          ),
        ],
      ),
      floatingActionButton: _index < 3
          ? Transform.scale(
              scale: scale,
              child: AddFab(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddRecordPage()),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: GlassNavBar(
        index: _index,
        onChanged: (i) => setState(() => _index = i),
        scale: scale,
      ),
    );
  }
}
