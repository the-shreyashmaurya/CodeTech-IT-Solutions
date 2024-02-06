import "package:firebase_auth/firebase_auth.dart";

class SignInFirebase {
  Future<String> mySignIn(
      {required String email, required String password}) async {
    // Sign In user using email and password
    var credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user!.uid;
  }
}
