import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";

class SignUpFirebase {
  String email = "";
  String password = "";

  Future<void> mySignUp(
      {required String email, required String password}) async {
    email = this.email;
    password = this.password;
    // try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print("------------------------------------------------------");
  }
  // on FirebaseAuthException {
  //   print("Auth Exception");
  // catch (e) {
  //   print(e);
  // }
  // }
}
