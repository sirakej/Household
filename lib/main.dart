import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/account-tab/edit-profile.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/account-tab/security.dart';
import 'package:householdexecutives_mobile/ui/home/drawer-page/purchases/saved-purchases.dart';
import 'package:householdexecutives_mobile/ui/candidate/find-category.dart';
import 'package:householdexecutives_mobile/ui/onboarding-screen.dart';
import 'package:householdexecutives_mobile/ui/registration/candidate-created-successfully.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot-password/create-new-password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot-password/reset-password.dart';
import 'package:householdexecutives_mobile/ui/registration/register-candidate-one.dart';
import 'package:householdexecutives_mobile/ui/registration/sign-in.dart';
import 'package:householdexecutives_mobile/ui/registration/sign-up.dart';
import 'package:householdexecutives_mobile/ui/registration/terms.dart';
import 'package:householdexecutives_mobile/ui/registration/user-created-successfully.dart';
import 'package:householdexecutives_mobile/ui/splash-screen.dart';
import 'package:householdexecutives_mobile/ui/successful-pay.dart';
import 'ui/home/home-screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

/// A StatelessWidget class to hold basic details and routes of my application
class MyApp extends StatefulWidget {

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Household Executives',
      debugShowCheckedModeBanner: false,
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF00A69D),
      ),
      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => Splash(),
        OnBoard.id:(context) => OnBoard(),
        SignIn.id:(context) => SignIn(),
        SignUp.id:(context) => SignUp(),
        Terms.id:(context) => Terms(),
        RegisterCandidateOne.id:(context) => RegisterCandidateOne(),
        Reset.id:(context) => Reset(),
        CreateNewPassword.id:(context) => CreateNewPassword(),
        UserCreatedSuccessfully.id:(context) => UserCreatedSuccessfully(),
        CandidateCreatedSuccessfully.id:(context) => CandidateCreatedSuccessfully(),
        FindACategory.id:(context) => FindACategory(),
        SuccessfulPay.id:(context) => SuccessfulPay(),
        HomeScreen.id:(context) => HomeScreen(),
        EditProfile.id:(context) => EditProfile(),
        PasswordAndSecurity.id:(context) => PasswordAndSecurity(),
        SavedPurchases.id:(context) => SavedPurchases(),
      },
    );
  }

}
