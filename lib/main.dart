import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_aws_project/amplifyconfiguration.dart';
import 'package:my_aws_project/auth_service.dart';
import 'package:my_aws_project/camera_flow.dart';
import 'package:my_aws_project/login_page.dart';
import 'package:my_aws_project/sign_up_page.dart';
import 'package:my_aws_project/verification_page.dart';

void main() {
  runApp(const MyApp());
}

// 1
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _amplify = Amplify;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      // 2
      home: StreamBuilder<AuthState>(
        // 2
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          // 3
          if (snapshot.hasData) {
            return Navigator(
              pages: [
                // 4
                // Show Login Page
                if (snapshot.data!.authFlowStatus == AuthFlowStatus.login)
                  MaterialPage(
                    child: LoginPage(
                      shouldShowSignUp: _authService.showSignUp,
                      didProvideCredentials: _authService.loginWithCredentials,
                    ),
                  ),

                // 5
                // Show Sign Up Page
                if (snapshot.data!.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(
                    child: SignUpPage(
                      shouldShowLogin: _authService.showLogin,
                      didProvideCredentials: _authService.signUpWithCredentials,
                    ),
                  ),

                // 6
                // Show Verification Code Page
                if (snapshot.data!.authFlowStatus ==
                    AuthFlowStatus.verification)
                  MaterialPage(
                    child: VerificationPage(
                      didProvideVerificationCode: _authService.verifyCode,
                    ),
                  ),
                if (snapshot.data!.authFlowStatus == AuthFlowStatus.session)
                  MaterialPage(
                      child: CameraFlow(shouldLogOut: _authService.logOut))
              ],
              onPopPage: (route, result) => route.didPop(result),
            );
          } else {
            // 6
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _configureAmplify() async {
    _amplify.addPlugin(AmplifyAuthCognito());
    try {
      await _amplify.configure(amplifyconfig);
      print('Successfully configured Amplify 🎉');
    } catch (e) {
      print('Could not configure Amplify ☠️');
    }
  }
}
