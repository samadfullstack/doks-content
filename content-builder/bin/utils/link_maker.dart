class MkLink {
  static final _baseUrl =
      "https://raw.githubusercontent.com/samadfullstack/doks-content/version2/docs";

  /// result will be _baseurl/techId/data.json
  static String data(String techId) => "$_baseUrl/$techId/data.json";

  /// result will be
  /// ### _baseurl/techId/docs.json
  static String docs(String techId) => "$_baseUrl/$techId/docs.json";

  /// result will be _baseurl/techId/content/docId.md
  static String content(String techId, String docId) => "$_baseUrl/$techId/content/$docId.md";
}
