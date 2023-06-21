import './widget/pages_widgets.dart';
import 'package:flutter/cupertino.dart';

class GPACalculatorPage extends StatelessWidget {
  const GPACalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PagesWidget(
      title: 'GPA Calculator',
      appLogo: 'images/gpa-calculator.png',
      shortDescription: 'The high quality\nGrade Calculator',
      appImage: 'images/gpacalculator-grades.png',
      appName: 'GPA Calculator',
      appDownloadUrl:
          'https://drive.google.com/file/d/1isry2Pj6mfqc6CzfkppjiZXekCgKKsFy/view?usp=sharing',
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.anderson.gpa_calculator",
      appStoreUrl: "https://www.apple.com/app-store/",
      phoneImage: 'images/gpacalculator-phone-image.png',
      privacyPolicyUrl:
          'https://www.privacypolicies.com/live/919bba91-173c-4699-8191-c0781afc0ee9',
      highlightsIcon1: CupertinoIcons.graph_circle,
      highlightsTitle1: 'Real Time Grading',
      highlightsDescrition1: 'Calculate your grades on the go.',
      highlightsIcon2: CupertinoIcons.headphones,
      highlightsTitle2: 'Get Support',
      highlightsDescrition2: 'Get Support from Admin.',
      highlightsIcon3: CupertinoIcons.conversation_bubble,
      highlightsTitle3: 'Request Features',
      highlightsDescrition3: 'Request more features.',
      featureImage: 'images/audify-plus-feature.png',
    );
  }
}
