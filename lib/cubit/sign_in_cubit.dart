import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? user;

  Future signIn() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      print("BULL==============");
      emit(ErrorState());
    }

    user = googleUser;
    final googleAuthentication = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuthentication!.idToken,
        accessToken: googleAuthentication!.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    print("getting current user from firebase");
    User? currentUser = FirebaseAuth.instance.currentUser;
    print("success current user from firebase");

    if (currentUser == null) {
      emit(ErrorState());
    }
    emit(SignInSuccess());
  }

  Future getCurrentUser() async {
    // String? name;
    // String? profileImage;
    // String? uid;
    // name = auth.currentUser!.displayName;
    // profileImage = auth.currentUser!.photoURL;
    // uid = auth.currentUser!.uid;
  }
}
