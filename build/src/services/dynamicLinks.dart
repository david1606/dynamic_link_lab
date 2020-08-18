import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinks {
  Future<String> createLinkWithDocID(String documentId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://total-promo.com/app',
      link: Uri.parse('https://total-promo.com/publicacion/$documentId'),
      androidParameters: AndroidParameters(
        packageName: 'com.novalabs.dynamic_link',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.novalabs.dynamic_link',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'New App, go check it!!',
          description: 'Hello there, im ,just chilin',
          imageUrl: Uri.parse('')),
    );

    ShortDynamicLink shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl.toString();
  }

  Future<String> createNewLinkWithDocID(String documentId) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://total-promo.com/app',
      link: Uri.parse('https://total-promo.com/publicacion/$documentId'),
      androidParameters: AndroidParameters(
        packageName: 'com.novalabs.dynamic_link',
        minimumVersion: 0,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.novalabs.dynamic_link',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
          title: 'New App, go check it!!',
          description: 'Hello there, im ,just chilin',
          imageUrl: Uri.parse('')),
    );

    ShortDynamicLink shortLink = await parameters.buildShortLink();
    return shortLink.shortUrl.toString();
  }
}
