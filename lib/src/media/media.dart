import 'package:meta/meta.dart';
import 'transformations.dart';

/// ContentChef default media cloud name
const _defaultCloudName = 'contentchef';

/// param used to compose the cloud name path param in the default media url;
const _cloudNameUrlParam = 'CLOUD_NAME';
/// param used to compose the transformation path param in the default media url;
const _transformationUrlParam = 'TRANSFORMATION';
/// param use to compose the public id path param in the default media url;
const _publicIdUrlParam = 'PUBLIC_ID';
/// default media url
const _defaultUrl = 'https://res.cloudinary.com/$_cloudNameUrlParam/image/upload/$_transformationUrlParam/v1/$_publicIdUrlParam';

/// ContentChef media handler class used to retrieve the media publicUrl
///
/// Examples:
///
///   var mediaUtils = Media();
///   var publicMediaUrl = mediaUtils.getUrl(publicId: 'the-media-publicId');
///
class Media {
  String _cloudName;

  /// Initializes a new 'Media' utils
  ///
  /// Parameters:
  /// - cloudName: (default value is provided) if you have a custom cloudName pass your cloudName
  /// - Returns: an instance of `Media`.
  Media({ String cloudName = _defaultCloudName }) {
    _cloudName = cloudName;
  }

  /// Retrieves a media public url.
  ///
  /// - Parameters:
  /// - publicId: the media publicId (retrieved from a published content that have a media field)
  /// - transformations: instance of `MediaTransformations`
  /// - Returns: the media public url
  ///
  String getUrl({ @required String publicId, MediaTransformations transformations}) {
    if (publicId == null) {
      throw Exception('A media publicId is mandatory to retrieve a media public url');
    }

    var publicUrl = _defaultUrl
        .replaceAll(_cloudNameUrlParam, _cloudName)
        .replaceAll(_publicIdUrlParam, publicId);
    
    if (transformations != null && transformations.getStringTransformations().isNotEmpty) {
      publicUrl = publicUrl.replaceAll(_transformationUrlParam, transformations.getStringTransformations());
    } else {
      print('$_transformationUrlParam/');
      publicUrl = publicUrl.replaceAll('$_transformationUrlParam/', '');
    }
    return publicUrl;
  }
}
