class ZermeloUtil {
  static String getApiURL(String school) {
    return "https://$school.zportal.nl/api/v3";
  }

  static Uri createApiURL(String school, String slug, String accessToken) {
    // print("$school$slug$accessToken");
    String apiURL = getApiURL(school);
    String a = slug.indexOf("?") > 1 ? "&" : "?";
    return Uri.parse("$apiURL/$slug${a}access_token=$accessToken");
  }
}
