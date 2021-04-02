class MapLocale {
  /// Constructor of the model.
  MapLocale(this.languageCode, this.mapData, {this.countryCode});

  /// Language code. This will use to check with the supported language codes
  /// and find the data for localization.
  final String languageCode;

  /// Country code is the region subtag for the locale.
  final String? countryCode;

  /// This is the map of data that will use for localization. Just like the
  /// json file too.
  final Map<String, dynamic> mapData;
}
