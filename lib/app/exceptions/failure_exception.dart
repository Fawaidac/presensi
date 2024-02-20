class FailureException {
  final String msg;

  const FailureException([this.msg = "An Uknown error occured."]);

  factory FailureException.code(String code) {
    switch (code) {
      case 'weak-password':
        return const FailureException('Please enter a stronger password');
      case 'invalid-email':
        return const FailureException('Email is not valid or badly formatted.');
      case 'email-already-in-use':
        return const FailureException('Email already in use.');
      case 'operation-not-allowed':
        return const FailureException('Operation not allowed.');
      case 'user-disabled':
        return const FailureException('This user has been disabled.');
      default:
        return const FailureException();
    }
  }
}
