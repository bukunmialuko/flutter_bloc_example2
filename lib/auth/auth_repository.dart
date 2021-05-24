class AuthRepository {
  Future login() async {
    print("===> attempting login...");
    Future.delayed(Duration(seconds: 3));
    print("===> logged in");
  }
}
