// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get loginTitle => 'mbti';

  @override
  String get startWithPhone => '使用手机号登录';

  @override
  String get startWithEmail => '使用邮箱登录';

  @override
  String get startAsGuest => '以游客身份开始';

  @override
  String get navHome => '首页';

  @override
  String get navMe => '我的';

  @override
  String get desktopUnderDev => '桌面端版本正在开发中...';

  @override
  String get desktopHint => '请在手机端访问以获取完整体验。';

  @override
  String get or => '或者';
}
