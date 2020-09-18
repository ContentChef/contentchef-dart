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

// param to replace that determines the resource_type of the media
const _resourceTypeParam = 'RESOURCE_TYPE';

/// default media url
const _defaultUrl =
    'https://res.cloudinary.com/$_cloudNameUrlParam/$_resourceTypeParam/upload/$_transformationUrlParam/v1/$_publicIdUrlParam';

/// When using `getUrl` method this enum is needed to correctly retrieve the resource
///
///   - `image`: for images
///   - `video`: for videos
///   - `raw`: for document files (pdf, doc) and audio files
enum ResourceType { image, video, raw }

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
  Media({String cloudName = _defaultCloudName}) {
    _cloudName = cloudName;
  }

  /// Retrieves a media public url.
  ///
  /// - Parameters:
  /// - publicId: the media publicId (retrieved from a published content that have a media field)
  /// - transformations: instance of `MediaTransformations`
  /// - resourceType: instance of `ResourceType`
  /// - Returns: the media public url
  ///
  String getUrl(
      {@required String publicId,
      MediaTransformations transformations,
      ResourceType resourceType = ResourceType.image}) {
    if (publicId == null) {
      throw Exception(
          'A media publicId is mandatory to retrieve a media public url');
    }
    var publicUrl = _defaultUrl
        .replaceAll(_cloudNameUrlParam, _cloudName)
        .replaceAll(_publicIdUrlParam, publicId);
    switch (resourceType) {
      case ResourceType.image:
        publicUrl = publicUrl.replaceAll(_resourceTypeParam, 'image');
        break;
      case ResourceType.video:
        publicUrl = publicUrl.replaceAll(_resourceTypeParam, 'video');
        break;
      case ResourceType.raw:
        publicUrl = publicUrl.replaceAll(_resourceTypeParam, 'raw');
        break;
      default:
        publicUrl = publicUrl.replaceAll(_resourceTypeParam, 'image');
        break;
    }

    if (transformations != null &&
        transformations.getStringTransformations().isNotEmpty) {
      publicUrl = publicUrl.replaceAll(
          _transformationUrlParam, transformations.getStringTransformations());
    } else {
      publicUrl = publicUrl.replaceAll('$_transformationUrlParam/', '');
    }
    return Uri.encodeFull(publicUrl);
  }

  /// Retrieves a raw resource's public url.
  ///
  /// - Parameters:
  /// - publicId: the media publicId (retrieved from a published content that have a media field)
  /// - transformations: instance of `MediaTransformations`
  /// - Returns: the media public url
  ///
  String rawFileUrl(
      {@required String publicId, MediaTransformations transformations}) {
    return getUrl(
        publicId: publicId,
        transformations: transformations,
        resourceType: ResourceType.raw);
  }

  /// Retrieves a video resource's public url.
  ///
  /// - Parameters:
  /// - publicId: the media publicId (retrieved from a published content that have a media field)
  /// - transformations: instance of `MediaTransformations`
  /// - Returns: the media public url
  ///
  String videoUrl(
      {@required String publicId, MediaTransformations transformations}) {
    return getUrl(
        publicId: publicId,
        transformations: transformations,
        resourceType: ResourceType.video);
  }

  /// Retrieves an image resource's public url.
  ///
  /// - Parameters:
  /// - publicId: the media publicId (retrieved from a published content that have a media field)
  /// - transformations: instance of `MediaTransformations`
  /// - Returns: the media public url
  ///
  String imageUrl(
      {@required String publicId, MediaTransformations transformations}) {
    return getUrl(
        publicId: publicId,
        transformations: transformations,
        resourceType: ResourceType.image);
  }
}
