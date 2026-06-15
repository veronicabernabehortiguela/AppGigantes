class AppLanguages {

  static const String spanish = "es";
  static const String english = "en";
  static const String french = "fr";

  static String getTTSLocale(String language) {

    switch (language) {

      case english:
        return "en-US";

      case french:
        return "fr-FR";

      case spanish:
      default:
        return "es-ES";
    }
  }
}