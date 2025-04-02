part of 'app_pages.dart';

abstract class Routes {
  static const MAIN_NAVIGATE = _Paths.MAIN_NAVIGATE;
  static const SPLASH = _Paths.SPLASH;
  static const HOME = _Paths.HOME;
  static const ADD_SESSION = _Paths.ADD_SESSION;
  static const EDIT_SESSION = _Paths.EDIT_SESSION;
  static const SETTINGS = _Paths.SETTINGS;
  static const PROJECT_BLUEPRINT = _Paths.PROJECT_BLUEPRINT;
  static const SEARCH_SESSION = _Paths.SEARCH_SESSION;
  static const POLICY_PRIVACY = _Paths.POLICY_PRIVACY;
  static const CHANGE_LANGUAGE = _Paths.CHANGE_LANGUAGE;
  static const HELP_SUPPORT = _Paths.HELP_SUPPORT;
  static const PLANE_DETECTION = _Paths.PLANE_DETECTION;
  Routes._();
}

abstract class _Paths {
  static const MAIN_NAVIGATE = '/main_navigate';
  static const SPLASH = '/splash';
  static const HOME = '/home';
  static const ADD_SESSION = '/add_session';
  static const EDIT_SESSION = '/edit_session';
  static const SETTINGS = '/settings';
  static const PROJECT_BLUEPRINT = '/project_blueprint';
  static const SEARCH_SESSION = '/search_session';
  static const POLICY_PRIVACY = '/policy_privacy';
  static const CHANGE_LANGUAGE = '/change_language';
  static const HELP_SUPPORT = '/help_support';
  static const PLANE_DETECTION = '/plane_detection';
}
