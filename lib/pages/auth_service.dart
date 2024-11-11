import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign In
  signInWithGoogle() async {
    try {
      // Initialize GoogleSignIn with additional scopes (email)
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      // Start the Google Sign-In process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        print("Sign-in failed: User cancelled the sign-in.");
        return null; // User cancelled sign-in
      }

      // Get authentication details
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Ensure that the authentication details are not null
      if (gAuth.accessToken == null || gAuth.idToken == null) {
        print("Sign-in failed: Missing Google authentication details.");
        return null; // Missing authentication details
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with Firebase
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("Sign-in successful: ${userCredential.user?.displayName}");
      return userCredential;
    } on FirebaseAuthException catch (e) {
      // Firebase specific error handling
      print("Firebase Auth error: ${e.code}");
      print(e.message);
      return null;
    } catch (e) {
      // General error handling
      print("Sign-in error: $e");
      return null;
    }
  }
}
