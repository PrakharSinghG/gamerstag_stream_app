class URLValidator {
  static bool isValidURL(String url) {
    final regex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
    );
    return regex.hasMatch(url);
  }
}
