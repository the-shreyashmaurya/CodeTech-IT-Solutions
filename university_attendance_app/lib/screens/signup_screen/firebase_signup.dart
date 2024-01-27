import "package:firebase_auth/firebase_auth.dart";

class SignUpFirebase {
  Future<UserCredential> mySignUp(
      {required String email, required String password}) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }
}
