import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/ContactsService/i_contacts_service.dart';
import 'package:im_okay/Services/PermissionsService/i_permissions_service.dart';
import 'package:im_okay/Services/service_injector.dart';
import 'package:im_okay/Utils/Consts/consts.dart';
import 'package:introduction_screen/introduction_screen.dart';

GlobalKey<IntroductionScreenState> _introScreenKey = GlobalKey<IntroductionScreenState>();

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final IAuthenticationService _authService;
  late final IPermissionsService _permissionsService;
  late final IContactsService _contactsService;

  @override
  void initState() {
    super.initState();

    _authService = serviceInjector.get<IAuthenticationService>();
    _permissionsService = serviceInjector.get<IPermissionsService>();
    _contactsService = serviceInjector.get<IContactsService>();
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introScreenKey,
      done: Text("Done!"),
      showNextButton: false,
      showBackButton: false,
      overrideNext: (context, onPressed) => ElevatedButton(
        child: Text(
          _OnboardingPageConsts.introductionPageNextButtonCaption,
        ),
        onPressed: () {
          _introScreenKey.currentState!.next();
        },
      ),
      globalBackgroundColor: Colors.white,
      onDone: () => context.replaceNamed(Routes.home),
      customProgress: null, // TODO: implement this from figma
      pages: [
        /* Introduction page */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.introductionPageTitle,
              description: _OnboardingPageConsts.introductionPageDescription,
              showNextButton: true,
              nextButtonCaption: _OnboardingPageConsts.introductionPageNextButtonCaption,
              imageLink: r"Assets/Onboarding/onboarding_page_1_image.png",
              actions: [],
            )),
        /* Register page */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.registerPageTitle,
              description: _OnboardingPageConsts.registerPageDescription,
              imageLink: r"Assets/Onboarding/onboarding_page_2_image.png",
              actions: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: Icon(Icons.g_mobiledata_sharp),
                  onPressed: () async {
                    await _authService.registerOrSignIn();
                    _introScreenKey.currentState!.next();
                  },
                  label: Text(_OnboardingPageConsts.registerPageActionGoogleSignIn),
                )
              ],
            )),
        /* Post register page */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.postRegisterPageTitle,
              description: _OnboardingPageConsts.postRegisterPageDescription,
              imageLink: r"Assets/Onboarding/onboarding_page_3_image.png",
              showNextButton: true,
              nextButtonCaption: _OnboardingPageConsts.postRegisterPageNextButtonCaption,
              actions: [],
            )),
        /* Contacts permissions */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.requestContactAccessPermissionsPageTitle,
              description: _OnboardingPageConsts.requestContactAccessPermissionsPageDescription,
              imageLink: r"Assets/Onboarding/onboarding_page_3_image.png",
              actions: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: () async {
                    await _permissionsService.requestContactsPermission();
                    _introScreenKey.currentState!.next();
                  },
                  label:
                      Text(_OnboardingPageConsts.requestContactAccessPermissionsPageButtonCaption),
                )
              ],
            )),
        // /* Phone number verification page */ PageViewModel(
        //   title: "",
        //   bodyWidget: OnboardingPageBase(
        //     titleText: "",
        //     description: "",
        //     imageLink: r"Assets/Onboarding/onboarding_page_3_image.png",
        //   showNextButton: true,
        //   nextButtonCaption: _OnboardingPageConsts.postRegisterPageNextButtonCaption,
        //   actions: [],
        //   )
        // ),
        /* Location permissions page */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.requestLocationPermissionPageTitle,
              description: _OnboardingPageConsts.requestLocationPermissionPageDescription,
              imageLink: r"Assets/Onboarding/onboarding_page_4_image.png",
              actions: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: () async {
                    await _permissionsService.requestLocationPermissions();
                    _introScreenKey.currentState!.next();
                  },
                  label: Text(_OnboardingPageConsts.requestLocationPermissionPageButtonCaption),
                )
              ],
            )),
        /* Notifications permissions page */ PageViewModel(
            title: "",
            bodyWidget: OnboardingPageBase(
              titleText: _OnboardingPageConsts.requestNotificationsPermissionPageTitle,
              description: _OnboardingPageConsts.requestNotificationsPermissionPageDescription,
              imageLink: r"Assets/Onboarding/onboarding_page_5_image.png",
              actions: [
                ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: Icon(Icons.notifications_active_outlined),
                  onPressed: () async {
                    await _permissionsService.requestNotificationPermissions();
                    _introScreenKey.currentContext!.replaceNamed(Routes.home);
                  },
                  label:
                      Text(_OnboardingPageConsts.requestNotificationsPermissionPageButtonCaption),
                )
              ],
            )),
      ],
    );
  }
}

class _OnboardingPageConsts {
  static const String introductionPageTitle = "ברוכים הבאים ל-I'm OK";
  static const String introductionPageDescription =
      "הדרך הפשוטה לעדכן שהכל בסדר ולהתעדכן על מצב הקרובים שלך בעת אזעקה";
  static const String introductionPageNextButtonCaption = "התחלה";

  static const String registerPageTitle = "לפני שמתחילים...";
  static const String registerPageDescription = " בכדי להשתמש באפליקציה, יש צורך ליצור פרופיל";
  static const String registerPageActionGoogleSignIn = "לכניסה באמצעות Google";

  static const String postRegisterPageTitle = "איזה כיף שהצטרפת!";
  static const String postRegisterPageDescription = "";
  static const String postRegisterPageNextButtonCaption = "הבא";

  static const String requestContactAccessPermissionsPageTitle = "גישה לאנשי קשר";
  static const String requestContactAccessPermissionsPageDescription =
      "כדי שתוכלו להזמין בקלות חברים ומשפחה להתחבר";
  static const String requestContactAccessPermissionsPageButtonCaption = "אישור גישה לאנשי קשר";

  static const String requestLocationPermissionPageTitle = "הפרטיות שלך חשובה לנו";
  static const String requestLocationPermissionPageDescription =
      "אנחנו מבקשים גישה למיקום שלך רק כדי לזהות אם היית באיזור עם אזעקה";
  static const String requestLocationPermissionPageDisclaimer =
      "המידע הזה לא נחשף לאף אחד ולא נשלח לשום מקום";
  static const String requestLocationPermissionPageButtonCaption = "אישור מיקום";

  static const String requestNotificationsPermissionPageTitle = "לדעת תמיד מה מצב הקרובים";
  static const String requestNotificationsPermissionPageDescription =
      "התרעות ישלחו בכדי לעדכן שהכל בסדר אצלך ואצל הקרובים";
  static const String requestNotificationsPermissionPageButtonCaption = "אישור התראות";
}

class OnboardingPageBase extends StatefulWidget {
  String titleText;
  String description;
  String? nextButtonCaption;
  bool showNextButton;
  String imageLink;
  List<Widget> actions;
  OnboardingPageBase(
      {super.key,
      required this.titleText,
      required this.description,
      required this.imageLink,
      required this.actions,
      this.nextButtonCaption,
      this.showNextButton = false});

  @override
  State<OnboardingPageBase> createState() => _OnboardingPageBaseState();
}

class _OnboardingPageBaseState extends State<OnboardingPageBase> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Text(
          widget.titleText,
          style: _headerStyle,
          textAlign: TextAlign.center,
        )
        // )
        ,
        Text(
          textAlign: TextAlign.center,
          widget.description,
          style: _smallText(Colors.black),
        ),
        Image(
          image: AssetImage(widget.imageLink),
        ),
        ...widget.actions,
        if (widget.showNextButton) nextButton(widget.nextButtonCaption!)
      ],
    );
  }

  Widget nextButton(String caption) => ElevatedButton(
        style: ButtonStyle(
            tapTargetSize: (MaterialTapTargetSize.shrinkWrap),
            fixedSize:
                WidgetStatePropertyAll(Size.fromWidth(MediaQuery.of(context).size.width * 0.8)),
            backgroundColor: WidgetStatePropertyAll(const Color(0xFF48A6A7)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ))),
        onPressed: () => _introScreenKey.currentState!.next(),
        child: Text(caption, style: _smallText(Colors.white)),
      );
}

final TextStyle _headerStyle = TextStyle(
  color: Color.fromARGB(255, 72, 166, 167),
  fontSize: 32,
  fontFamily: 'Inter',
  fontWeight: FontWeight.w600,
);

TextStyle _smallText(Color color) => TextStyle(
      color: color,
      fontSize: 20,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    );
