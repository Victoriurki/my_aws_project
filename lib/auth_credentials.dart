// 1
abstract class AuthCredentials {
  final String username;
  final String password;

  AuthCredentials({required this.username, required this.password});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String? username, String? password})
      : super(username: username!, password: password!);
}

// 3
class SignUpCredentials extends AuthCredentials {
  final String email;

  SignUpCredentials({String? username, String? password, required this.email})
      : super(username: username!, password: password!);
}
