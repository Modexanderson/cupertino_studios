import './widget/pages_widgets.dart';
import 'package:flutter/cupertino.dart';

class AudifyMusicPlayerPage extends StatelessWidget {
  const AudifyMusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PagesWidget(
      title: 'Audify Music Player',
      appLogo: 'images/audify.png',
      shortDescription: 'The high quality\n     Music Player',
      appImage: 'images/audify-songs.png',
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.music.audify",
      appStoreUrl: "https://www.apple.com/app-store/",
      phoneImage: 'images/audify-phone-image.png',
      privacyPolicyUrl:
          'https://www.privacypolicies.com/live/d15819cb-1e41-44db-8e0d-d69659274d8e',
      highlightsIcon1: CupertinoIcons.music_note_2,
      highlightsTitle1: 'Music Player',
      highlightsDescrition1: 'Listen to your favorite songs on the go.',
      highlightsIcon2: CupertinoIcons.wrench,
      highlightsTitle2: 'Theme Customization',
      highlightsDescrition2: 'Customize theme to your taste.',
      highlightsIcon3: CupertinoIcons.doc_text,
      highlightsTitle3: 'Lyrics',
      highlightsDescrition3: 'Sing along with song lyrics.',
      featureImage: 'images/audify-feature.png',
    );
  }
}
