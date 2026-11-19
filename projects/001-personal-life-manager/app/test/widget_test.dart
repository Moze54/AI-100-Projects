import 'package:flutter_test/flutter_test.dart';

import 'package:shiji/main.dart';

void main() {
  testWidgets('拾记 4 Tab 主框架可正常构建', (WidgetTester tester) async {
    await tester.pumpWidget(const ShijiApp());
    expect(find.text('拾记'), findsWidgets);
    expect(find.text('首页'), findsOneWidget);
    expect(find.text('分类'), findsOneWidget);
    expect(find.text('日程'), findsOneWidget);
    expect(find.text('我的'), findsOneWidget);
  });
}
