class Validar {
  String? validarUrl(String url) {
    String urlPattern =
        r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
    RegExp regExp = new RegExp(urlPattern, caseSensitive: false);
    if (regExp.hasMatch(url)) {
      return null;
    }
    return "Formato no valido";
  }
}
