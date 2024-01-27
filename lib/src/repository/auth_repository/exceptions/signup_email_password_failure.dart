class SignUpWithEmailAndPasswordFailure {
 final String message;
  const SignUpWithEmailAndPasswordFailure([this.message = "An unknown error occurred."]);
  factory SignUpWithEmailAndPasswordFailure.code(String code){
   switch(code){
    case 'weak-password':return const SignUpWithEmailAndPasswordFailure('Please enter a stronger password.');
    case 'invalid-password':return const SignUpWithEmailAndPasswordFailure('Email is not valid or badly formatted.');
    case 'operation-not-allowed':return const SignUpWithEmailAndPasswordFailure('This operation is not allowed, please contact support.');
    case 'email-already-in-use':return const SignUpWithEmailAndPasswordFailure('An account already exists for that email');
    case 'user-disabled':return const SignUpWithEmailAndPasswordFailure('This account has been disabled, please contact support.');
    default: return const SignUpWithEmailAndPasswordFailure();
   }
  }
}