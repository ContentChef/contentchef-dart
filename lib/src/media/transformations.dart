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
  MediaTransformations(
      {bool autoFormat,
      int mediaHeight,
      int mediaWidth,
      MediaFormats mediaFormat}) {
    _autoFormat = autoFormat;
    _mediaHeight = mediaHeight;
    _mediaWidth = mediaWidth;
    _mediaFormat = mediaFormat;
  }

  String buildTransformations([List<String> mediaSpecificTransformation]) {
    var transformations = mediaSpecificTransformation ?? [];
    if (_mediaWidth != null) {
      transformations.add('w_$_mediaWidth');
    }
    if (_mediaHeight != null) {
      transformations.add('h_$_mediaHeight');
    }
    if (_mediaFormat != null &&
        (_autoFormat == null || _autoFormat != null && !_autoFormat)) {
      transformations.add('f_$_mediaFormat');
    }
    if (_autoFormat != null && _autoFormat) {
      transformations.add('f_auto');
    }

    return transformations.join(',');
  }

  /// Retrieves all media transformations
  ///
  /// - Parameters:
  /// - Returns: a string that contains all transformation
  ///
  String getStringTransformations() {
    return buildTransformations();
  }
}

/// Class needed to create a VideoTransformations that enables resizes and cropping videos to optimize file size
class CroppingMode {
  final String _type;
  CroppingMode._fromValue(this._type);

  @override
  String toString() {
    return _type;
  }

  /// Change the size of the video exactly to the given width and height without necessarily retaining the original aspect ratio
  static CroppingMode scale = CroppingMode._fromValue('scale');

  /// Change video size to fit in the given width and height while retaining the original aspect ratio with all the original video parts visible
  static CroppingMode fit = CroppingMode._fromValue('fit');

  /// Create a video with the exact given width and height while retaining original proportions
  static CroppingMode fill = CroppingMode._fromValue('fill');

  /// The limit mode is used for creating a video that does not exceed the given width and height
  static CroppingMode limit = CroppingMode._fromValue('limit');

  /// Resize the video to fill the given width and height while retaining the original aspect ratio
  static CroppingMode pad = CroppingMode._fromValue('pad');

  /// Same as the pad mode, but doesn't scale the video up if your requested dimensions are larger than the original video's
  static CroppingMode lpad = CroppingMode._fromValue('lpad');

  /// Extract only part of a given width and height out of the original video.
  static CroppingMode crop = CroppingMode._fromValue('crop');
}

/// ContentChef video's transformations handler class used to retrieve the video transformations
///
/// Examples:
///
///   var transformations1 = VideoTransformations(autoFormat: true, mediaWidth: 100, mediaHeight: 200, croppingMode: CroppingMode.fit);
///   var transformations2 = VideoTransformations(quality: 20, mediaWidth: 100, mediaHeight: 200);
///
class VideoTransformations extends MediaTransformations {
  int _videoQuality;
  CroppingMode _croppingMode;

  /// Initializes a new 'VideoTransformations'
  ///
  /// Parameters:
  /// - autoFormat: set this value to true in order to perform automatic format selection based on the requesting browser
  /// - mediaHeight: set this value if you want to retrieve a media with a specific height
  /// - mediaWidth: set this value if you want to retrieve a media with a specific width
  /// - mediaFormat: set this value if you want to retrieve the media with a different format
  /// - videoQuality: defaults to 'auto' and should be a value between 0 and 100,
  /// - croppingMode: resizes video to fit your application and optimizes file size
  /// - Returns: an instance of `VideoTransformations`.
  ///
  /// - autoFormat param always override the mediaFormat for a better media optimization
  /// - if autoFormat or mediaFormat params are not specified media will be retrieved with its original format
  ///
  VideoTransformations({
    bool autoFormat,
    int mediaHeight,
    int mediaWidth,
    MediaFormats mediaFormat,
    int videoQuality,
    CroppingMode croppingMode,
  }) : super(
            autoFormat: autoFormat,
            mediaHeight: mediaHeight,
            mediaWidth: mediaWidth,
            mediaFormat: mediaFormat) {
    _videoQuality = videoQuality;
    _croppingMode = croppingMode;
  }

  /// Retrieves all media transformations
  ///
  /// - Parameters:
  /// - Returns: a string that contains all transformation
  ///
  @override
  String getStringTransformations() {
    var transformations = <String>[];

    if (_videoQuality != null) {
      transformations.add('q_$_videoQuality');
    } else {
      transformations.add('q_auto');
    }

    if (_croppingMode != null) {
      transformations.add('c_$_croppingMode');
    }

    return buildTransformations(transformations);
  }
}
