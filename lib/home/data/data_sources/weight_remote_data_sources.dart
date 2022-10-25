

abstract class WeightRemoteDataSource {
  // Future<List<>> getListHeight(AuthenticationForm form);
}

class WeightRemoteDataSourceImpl implements WeightRemoteDataSource {
  // @override
  // Future<UserProfile> loginUser(AuthenticationForm form) async {
  //   final auth = FirebaseAuth.instance;
  //   try {
  //     final UserCredential user = await auth.signInWithEmailAndPassword(
  //       email: form.email,
  //       password: form.password,
  //     );
  //
  //     debugPrint("user \t- $user");
  //     debugPrint("credential \t- ${user.credential}");
  //     debugPrint("user \t- ${user.user}");
  //     debugPrint("profile \t- ${user.additionalUserInfo?.profile}");
  //
  //     return UserProfile(email: user.user?.email ?? "", uid: '');
  //   } on FirebaseAuthException catch (e) {
  //     throw AuthException(e.message ?? AuthException.unknownError);
  //   } catch (e) {
  //     debugPrint('LOGIN FAILED -> ${e.runtimeType}');
  //     debugPrint(e.toString());
  //     throw ServerException();
  //   }
  // }
}
