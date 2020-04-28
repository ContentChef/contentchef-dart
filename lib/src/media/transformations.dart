/// An enum class that enumerates the possible image formats
///
/// Examples:
///
///      var pngFormat = ImageFormats.PNG => (if you want to retrieve your image in PNG format);
///
class MediaFormats {
  final String _value;
  const MediaFormats._(this._value);
  @override
  String toString() {
    return _value;
  }
  /// PNG format
  static const MediaFormats PNG = MediaFormats._('png');
  /// JPEG format
  static const MediaFormats JPG = MediaFormats._('jpg');
  /// JPEG 2000 format
  static const MediaFormats JP2 = MediaFormats._('jp2');
  /// JPEG eXtended Rang format
  static const MediaFormats WPD = MediaFormats._('wpd');
  /// WebP or animated WebP format
  static const MediaFormats WEBP = MediaFormats._('webp');
  /// SVG format
  static const MediaFormats SVG = MediaFormats._('svg');
  /// PDF format
  static const MediaFormats PDF = MediaFormats._('pdf');
  /// GIF format
  static const MediaFormats GIF = MediaFormats._('gif');
  /// ICO format
  static const MediaFormats ICO = MediaFormats._('ico');
  /// TIFF format
  static const MediaFormats TIF = MediaFormats._('tif');
  /// Bitmap format
  static const MediaFormats BMP = MediaFormats._('bmp');
  /// Filmbox format
  static const MediaFormats FBX = MediaFormats._('fbx');
  /// Raw image files format
  static const MediaFormats ARW = MediaFormats._('arw');
}

/// ContentChef media transformations handler class used to retrieve the media with possible transformations
///
/// Examples:
///
///   var mediaTransformations_1 = MediaTransformations(autoFormat: true, mediaWidth: 100, mediaHeight: 200);
///   var mediaTransformations_2 = MediaTransformations(mediaFormat: MediaFormats.PNG, mediaWidth: 100, mediaHeight: 200);
///
class MediaTransformations {
  bool _autoFormat;
  int _mediaHeight;
  int _mediaWidth;
  MediaFormats _mediaFormat;

  /// Initializes a new 'MediaTransformations'
  ///
  /// Parameters:
  /// - autoFormat: set this value to true in order to perform automatic format selection based on the requesting browser
  /// - mediaHeight: set thi value if you want to retrieve a media with a specific height
  /// - mediaWidth: set thi value if you want to retrieve a media with a specific width
  /// - mediaFormat: set this value if you want to retrieve the media with a different format
  /// - Returns: an instance of `MediaTransformations`.
  ///
  /// - autoFormat param always override the mediaFormat for a better media optimization
  /// - if autoFormat or mediaFormat params are not specified media will be retrieved with its original format
  ///
  MediaTransformations({
    bool autoFormat,
    int mediaHeight,
    int mediaWidth,
    MediaFormats mediaFormat
  }) {
    _autoFormat = autoFormat;
    _mediaHeight = mediaHeight;
    _mediaWidth = mediaWidth;
    _mediaFormat = mediaFormat;
  }

  /// Retrieves all media transformations
  ///
  /// - Parameters:
  /// - Returns: a string that contains all transformation
  ///
  String getStringTransformations() {
    var transformations = [];
    if (_mediaWidth != null) {
      transformations.add('w_$_mediaWidth');
    }
    if (_mediaHeight != null) {
      transformations.add('h_$_mediaHeight');
    }
    if (_mediaFormat != null && (_autoFormat == null || _autoFormat != null && !_autoFormat)) {
      transformations.add('f_$_mediaFormat');
    }
    if (_autoFormat != null && _autoFormat) {
      transformations.add('f_auto');
    }

    return transformations.join(',');
  }
}
