import 'package:auto_route/auto_route.dart';
import 'package:solnote/utils/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    // AutoRoute(page: SettingsRoute.page),
  ];
}
