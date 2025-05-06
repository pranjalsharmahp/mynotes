import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group("Mock Authentication", () {
    final provider = MockAuthProvider();
    test("Should not be initialized to begin with", () {
      expect(provider.isInitialized, false);
    });

    test('cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('Should be able to initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User should be null after the initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('create user should delegate to user function', () async {
      await provider.initialize();
      final badEmailUser = provider.register(
        email: "pranjal@gmail.com",
        password: "232323",
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.register(
        email: "Pranjal",
        password: "21092004",
      );

      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<InvalidCredentialsAuthException>()),
      );

      final user = await provider.register(email: "Prathit", password: '1234');
      expect(provider.currentUser, user);
      expect(user?.isEmailVerified, false);
    });
    test('Check if the email is verified of not', () async {
      await provider.initialize();
      await provider.logIn(email: "pranjal", password: "212132");
      await provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to log out and log in again', () async {
      await provider.initialize();
      await provider.logIn(email: 'email', password: 'password');
      await provider.logOut();

      final user = provider.currentUser;
      expect(user, null);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser?> logIn({required String email, required String password}) {
    if (isInitialized == false) {
      throw NotInitializedException();
    }
    if (email == "pranjal@gmail.com") throw UserNotFoundAuthException();
    if (password == '21092004') throw InvalidCredentialsAuthException();
    final user = AuthUser(email: email, id: email, isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser?> register({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  Future<void> reloadUser() async {
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotLoggedInAuthException();
    final newUser = AuthUser(
      email: "Prnajl",
      id: "13243",
      isEmailVerified: true,
    );
    _user = newUser;
  }
}
