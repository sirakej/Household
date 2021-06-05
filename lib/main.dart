import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:householdexecutives_mobile/ui/home/edit_profile.dart';
import 'package:householdexecutives_mobile/ui/home/password_and_security.dart';
import 'package:householdexecutives_mobile/ui/home/saved_candidate.dart';
import 'package:householdexecutives_mobile/ui/candidate/find_a_category.dart';
import 'package:householdexecutives_mobile/ui/candidate/my_list.dart';
import 'package:householdexecutives_mobile/ui/candidate/selected_category.dart';
import 'package:householdexecutives_mobile/ui/onboarding_screen.dart';
import 'package:householdexecutives_mobile/ui/packages.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/create_new_password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/reset_password.dart';
import 'package:householdexecutives_mobile/ui/registration/forgot_password/sent_link_page.dart';
import 'package:householdexecutives_mobile/ui/registration/register_candidate.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_in.dart';
import 'package:householdexecutives_mobile/ui/registration/sign_up.dart';
import 'package:householdexecutives_mobile/ui/registration/user_created_successfully.dart';
import 'package:householdexecutives_mobile/ui/splash_screen.dart';
import 'package:householdexecutives_mobile/ui/successful_pay.dart';
import 'ui/home/home_screen.dart';

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

      initialRoute: Splash.id,
      routes: {
        Splash.id: (context) => Splash(),
        OnBoard.id:(context)=>OnBoard(),
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
        RegisterCandidate.id:(context)=>RegisterCandidate(),
        Reset.id:(context)=>Reset(),
        SentLinkPage.id:(context)=>SentLinkPage(),
        CreateNewPassword.id:(context)=>CreateNewPassword(),
        UserCreatedSuccessfully.id:(context)=>UserCreatedSuccessfully(),
        FindACategory.id:(context)=>FindACategory(),
        //SelectedCandidateList.id:(context)=>SelectedCandidateList(),
        Packages.id:(context)=>Packages(),
        SuccessfulPay.id:(context)=>SuccessfulPay(),
        HomeScreen.id:(context)=>HomeScreen(),
        EditProfile.id:(context)=>EditProfile(),
        PasswordAndSecurity.id:(context)=>PasswordAndSecurity(),
        SavedCandidate.id:(context)=>SavedCandidate(),
        MyListCandidate.id:(context)=>MyListCandidate(),
      },
    );
  }

}
