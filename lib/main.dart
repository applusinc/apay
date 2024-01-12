import 'package:apay/constants.dart';
import 'package:apay/firebase_options.dart';
import 'package:apay/screens/auth/login/login_phone_page.dart';
import 'package:apay/screens/auth/login/provider/login_provider.dart';
import 'package:apay/screens/auth/register/provider/register_provider.dart';
import 'package:apay/widgets/dialogs/response_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:apay/routers/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ChangeNotifierProvider(create: (context) => LoginProvider())],
      child: MaterialApp(
          onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              snackBarTheme: const SnackBarThemeData(
                  backgroundColor: AppConst.surfaceColor,
                  elevation: 1,
                  contentTextStyle: TextStyle(color: Colors.white)),
              brightness: Brightness.dark,
              primaryColor: AppConst.primaryColor,
              hintColor: AppConst.secondaryColor,
              scaffoldBackgroundColor: AppConst.backgroundColor,
              cardColor: AppConst.surfaceColor,
              appBarTheme: const AppBarTheme(
                color: AppConst.primaryColor,
              ),
              colorScheme: const ColorScheme.dark(
                primary: AppConst.primaryColor,
                onPrimary: AppConst.onPrimaryColor,
                secondary: AppConst.secondaryColor,
                onSecondary: AppConst.onSecondaryColor,
                error: AppConst.errorColor,
                onError: AppConst.onErrorColor,
                background: AppConst.backgroundColor,
                onBackground: AppConst.onBackgroundColor,
                surface: AppConst.surfaceColor,
                onSurface: AppConst.onSurfaceColor,
              )
                  .copyWith(background: AppConst.backgroundColor)
                  .copyWith(error: AppConst.errorColor)),
          home: const LoginPhonePage()
          ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap: () {
            ResponseDialog.show(context, 'Hata', 'bilinmeyen bir sorun oluştu');
          },
            child: Container(
      color: Colors.white,
    )));
  }
}



class PinputExample extends StatefulWidget {
  const PinputExample({super.key});

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
              },
              // onClipboardFound: (value) {
              //   debugPrint('onClipboardFound: $value');
              //   pinController.setText(value);
              // },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              
            ),
          ),
          TextButton(
            onPressed: () {
              focusNode.unfocus();
              formKey.currentState!.validate();
            },
            child: const Text('Validate'),
          ),
        ],
      ),
    );
  }
}