import 'package:flutter/material.dart';
import 'package:im_okay/Services/AuthenticationService/i_authentication_service.dart';
import 'package:im_okay/Services/service_injector.dart';

class OtpOnboardingWidget extends StatefulWidget {
  Function() navigateToNextPage;

  OtpOnboardingWidget({super.key, required this.navigateToNextPage});

  @override
  State<OtpOnboardingWidget> createState() => _OtpOnboardingWidgetState();
}

class _OtpOnboardingWidgetState extends State<OtpOnboardingWidget> {
  bool isCodePhase = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  late IAuthenticationService _authService;

  @override
  void initState() {
    super.initState();
    _authService = serviceInjector.get<IAuthenticationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!isCodePhase)
            ...enterPhoneNumber(
                phoneController,
                _authService,
                () => setState(
                      () => isCodePhase = true,
                    ))
          else
            ...enterCode(codeController, _authService, widget.navigateToNextPage),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }
}

List<Widget> enterPhoneNumber(
    TextEditingController phoneController, IAuthenticationService authService, Function setState) {
  return [
    TextField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
      ),
    ),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () async {
        await authService.sendOtp();
        setState();
      },
      child: Text('Approve'),
    ),
  ];
}

List<Widget> enterCode(TextEditingController codeController, IAuthenticationService authService,
    Function() navigateToNextPage) {
  return [
    TextField(
      controller: codeController,
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
        labelText: '6-digit Code',
        border: OutlineInputBorder(),
      ),
    ),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: () async {
        String code = codeController.value.text.toString();
        bool val = await authService.validateOtp(code);
        if (val) {
          navigateToNextPage();
        }
      },
      child: Text('Submit'),
    ),
  ];
}
