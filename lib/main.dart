import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/ui/find_a_candidate.dart';
import 'package:householdexecutives_mobile/ui/onboarding_screen.dart';
import 'package:householdexecutives_mobile/ui/packages.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/create_new_password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/reset_password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/sent_link_page.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_in.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_up.dart';
import 'package:householdexecutives_mobile/ui/selected_candidate_list.dart';
import 'package:householdexecutives_mobile/ui/splash_screen.dart';
import 'package:householdexecutives_mobile/ui/successful_pay.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

/// A StatelessWidget class to hold basic details and routes of my application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Household Executives',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF1A60CD),
      ),
      initialRoute: Packages.id,
      routes: {
        Splash.id: (context) => Splash(),
        OnBoard.id:(context)=>OnBoard(),
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
        Reset.id:(context)=>Reset(),
        SentLinkPage.id:(context)=>SentLinkPage(),
        CreateNewPassword.id:(context)=>CreateNewPassword(),
        FindACandidate.id:(context)=>FindACandidate(),
        SelectedCandidateList.id:(context)=>SelectedCandidateList(),
        Packages.id:(context)=>Packages(),
        SuccessfulPay.id:(context)=>SuccessfulPay()
      },
    );
  }
}
