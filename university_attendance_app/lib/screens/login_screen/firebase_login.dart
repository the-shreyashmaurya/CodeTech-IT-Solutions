import "package:firebase_auth/firebase_auth.dart";

class SignInFirebase {
  Future<void>mySignIn({required String email, required String password}) async {
    // Sign In user using email and password
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    
  }
}
