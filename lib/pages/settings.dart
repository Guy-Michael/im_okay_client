import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Providers/providers.dart';
import 'package:im_okay/Services/ApiServices/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/LocationService/i_location_service.dart';
import 'package:im_okay/Services/router_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:im_okay/Utils/string_utils.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends ConsumerState<SettingsPage> {
  late IAuthenticationService _authService;
  late ILocationService _locationService;

  @override
  void initState() {
    super.initState();

    _authService = serviceInjector.get<IAuthenticationService>();
    _locationService = serviceInjector.get<ILocationService>();
  }

  @override
  Widget build(context) {
    final alertZone = ref.watch(alertZoneProvider);

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: alertZone.when(
                      loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                      error: (error, stackTrace) => Container(),
                      data: (alertZone) {
                        return Text(
                          interpolateString(_SettingsPageConsts.alertZoneCaption, [alertZone.name]),
                          style: _settingNameStyle,
                        );
                      }))),
        ),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text(
                "Debug",
                style: _sectionNameStyle,
              ),
              tiles: [
                SettingsTile.navigation(
                  title: Text("Onboarding Screen", style: _settingNameDangerousStyle),
                  trailing: _iosBackArrowIcon,
                  onPressed: (context) => context.pushNamed(Routes.onboarding_TEMP),
                )
              ],
            ),
            SettingsSection(
              title: Text(
                _SettingsPageConsts.sectionNameSettings,
                style: _sectionNameStyle,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingNotifications,
                    style: _settingNameStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingLocationServices,
                    style: _settingNameStyle,
                  ),
                  description: Text(
                    _SettingsPageConsts.settingDescriptionLocationServices,
                    style: _settingDescriptionStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
              ],
            ),
            SettingsSection(
              title: Text(
                _SettingsPageConsts.sectionNameSupport,
                style: _sectionNameStyle,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingQAndQ,
                    style: _settingNameStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingContactUS,
                    style: _settingNameStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingTermsOfUse,
                    style: _settingNameStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingPrivacyPolicy,
                    style: _settingNameStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
              ],
            ),
            SettingsSection(
              title: Text(
                _SettingsPageConsts.sectionNameLogout,
                style: _sectionNameStyle,
              ),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingLogOut,
                    style: _settingNameDangerousStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
                SettingsTile.navigation(
                  title: Text(
                    _SettingsPageConsts.settingAccountDeletion,
                    style: _settingNameDangerousStyle,
                  ),
                  trailing: _iosBackArrowIcon,
                ),
              ],
            ),
          ],
        ));
  }

  Future<void> onLogoutButtonClicked() async {
    await _authService.signOut();
  }

  Future<void> onDeleteUserButtonClicked() async {
    await _authService.deleteSignedInUserAndSignOut();

    globalRouter.go(Routes.auth.authRedirectPage);
  }

  final TextStyle _sectionNameStyle =
      TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w700);

  final TextStyle _settingNameStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700);

  final TextStyle _settingNameDangerousStyle = TextStyle(
      color: const Color.fromARGB(255, 142, 14, 5), fontSize: 20, fontWeight: FontWeight.w700);

  final TextStyle _settingDescriptionStyle =
      TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w900);

  final Icon _iosBackArrowIcon = Icon(Icons.arrow_forward_ios);
}

class _SettingsPageConsts {
  static const String alertZoneCaption = "איזור ההתרעה שלך: {0}";

  static const String sectionNameSettings = "הגדרות";
  static const String settingNotifications = "התראות";
  static const String settingLocationServices = "שירותי מיקום";
  static const String settingDescriptionLocationServices =
      "כיבוי שירותי מיקום ימנע מהאפליקציה לעבוד";

  static const String sectionNameSupport = "תמיכה";
  static const String settingQAndQ = "שאלות ותשובות";
  static const String settingContactUS = "צור קשר";
  static const String settingTermsOfUse = "תנאי שימוש";
  static const String settingPrivacyPolicy = "מדיניות פרטיות";

  static const String sectionNameLogout = "התנתקות";
  static const String settingLogOut = "יציאה מהחשבון";
  static const String settingAccountDeletion = "מחיקת חשבון";
}
