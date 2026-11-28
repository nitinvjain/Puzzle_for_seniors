import 'package:flutter/widgets.dart';

/// Hindi for the screens this fork added.
///
/// The app was already localised into twenty-four languages before I touched
/// it: `lib/l10n/app_hi.arb` carries 1,753 keys, 1,280 of them real
/// Devanagari, and 621 files make 2,678 calls to `AppLocalizations`. Upstream
/// did that work properly and none of it is changed here.
///
/// What was not in Hindi was everything I added -- today's games, the senior
/// settings screen, KBC India, the greeting. Every string in those was
/// hard-coded English, which is the wrong language for a man whose mother
/// tongue is Hindi and who taught in a UP Board college. At eighty-four, with
/// vascular dementia, a second language is the first thing to go, and every
/// English sentence spends working memory the question itself should be
/// getting.
///
/// Why this is a hand-written table rather than new keys in the .arb files,
/// which would be the idiomatic place: `pubspec.yaml` sets `generate: true`,
/// so `AppLocalizations` is produced by `flutter gen-l10n` at build time. I
/// cannot run that here, and if it did not regenerate on NJ's machine a
/// missing getter would not be a missing translation -- it would be a build
/// that does not compile. A plain table cannot fail that way. The cost is
/// that these forty-odd strings live apart from the other 1,753; the benefit
/// is that applying the patch cannot break his build.
///
/// Everything follows [Localizations.localeOf], so there is no second setting
/// to keep in step with the first.
class SeniorStrings {
  const SeniorStrings(this.hindi);

  /// True when the app is running in Hindi.
  final bool hindi;

  factory SeniorStrings.of(BuildContext context) =>
      SeniorStrings(Localizations.localeOf(context).languageCode == 'hi');

  String pick(String en, String hi) => hindi ? hi : en;

  // --- the home screen ------------------------------------------------------

  String get todaysGames => pick("TODAY'S GAMES", 'आज के खेल');

  String get addYourName =>
      pick('Tap here to add your name', 'अपना नाम लिखने के लिए यहाँ छुएँ');

  String get whoIsPlaying => pick('Who is playing?', 'कौन खेल रहा है?');

  String get nameLabel => pick('Name', 'नाम');

  String get save => pick('Save', 'सहेजें');

  String get cancel => pick('Cancel', 'रहने दें');

  /// Namaste reads the same either way; only the script changes.
  String greeting(String name) => pick('Namaste, $name', 'नमस्ते, $name');

  // --- the date -------------------------------------------------------------

  /// Written out rather than taken from intl's DateFormat, which throws if
  /// its locale data has not been initialised -- a crash on the home screen.
  static const List<String> _daysEn = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  static const List<String> _daysHi = [
    'सोमवार', 'मंगलवार', 'बुधवार', 'गुरुवार',
    'शुक्रवार', 'शनिवार', 'रविवार',
  ];

  static const List<String> _monthsEn = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  static const List<String> _monthsHi = [
    'जनवरी', 'फ़रवरी', 'मार्च', 'अप्रैल', 'मई', 'जून',
    'जुलाई', 'अगस्त', 'सितंबर', 'अक्तूबर', 'नवंबर', 'दिसंबर',
  ];

  String dayName(DateTime d) =>
      (hindi ? _daysHi : _daysEn)[(d.weekday - 1) % 7];

  /// 28 नवंबर 2026.
  ///
  /// The numerals stay Arabic in both languages, deliberately. Devanagari
  /// digits are correct but almost nobody in India reads a date in them, and
  /// the point of the date is to be understood at a glance.
  String dateLine(DateTime d) =>
      '${d.day} ${(hindi ? _monthsHi : _monthsEn)[(d.month - 1) % 12]} ${d.year}';

  // --- KBC India ------------------------------------------------------------

  String get quizTitle => pick('KBC INDIA', 'केबीसी इंडिया');

  String get quizSubtitle => pick(
        'Fifteen questions, climbing for the top prize',
        'पंद्रह सवाल, सबसे बड़े इनाम तक',
      );

  String questionCount(int n, int of) =>
      pick('Question $n of $of', 'सवाल $n / $of');

  String playingFor(String amount) =>
      pick('Playing for ₹$amount', 'इस सवाल पर ₹$amount');

  String guaranteedSoFar(String amount) =>
      pick('Guaranteed so far: ₹$amount', 'अब तक पक्का: ₹$amount');

  String get startAgain => pick('Start again', 'फिर से शुरू');

  String get lifelineFifty => '50 : 50';

  String get lifelineAudience => pick('Audience', 'दर्शक');

  String get lifelineSwap => pick('New one', 'नया सवाल');

  String allRight(int n, String amount) => pick(
        'All $n questions right — ₹$amount',
        'सभी $n सवाल सही — ₹$amount',
      );

  String takeHome(String amount) =>
      pick('You take home ₹$amount', 'आप ले जाते हैं ₹$amount');

  String get noPrize => pick(
        'No prize this time — have another go',
        'इस बार इनाम नहीं — फिर से कोशिश कीजिए',
      );

  String get figureLabel => pick(
        'A picture belonging to this question',
        'इस सवाल की तस्वीर',
      );

  /// The topic printed above each question.
  ///
  /// The three topics this fork added are his own ground, so they are named
  /// in his own language first: जैन धर्म, शिक्षण, बड़ौत.
  String topicLabel(String topic) {
    if (!hindi) return topic.toUpperCase();
    switch (topic) {
      case 'Jain Dharma':
        return 'जैन धर्म';
      case 'Teaching':
        return 'शिक्षण';
      case 'Baraut':
        return 'बड़ौत';
      case 'Maths':
        return 'गणित';
      case 'Science':
        return 'विज्ञान';
      case 'Geography':
        return 'भूगोल';
      case 'History':
        return 'इतिहास';
      case 'Culture':
        return 'संस्कृति';
      case 'Sport':
        return 'खेल';
      case 'Films':
        return 'फ़िल्म';
      case 'General':
        return 'सामान्य ज्ञान';
      default:
        return topic.toUpperCase();
    }
  }

  // --- the settings screen --------------------------------------------------

  String get settingsTitle => pick('SETTINGS', 'सेटिंग');

  String get settingsSubtitle =>
      pick('Sound, size and name', 'आवाज़, अक्षर और नाम');

  String get headingLanguage => pick('LANGUAGE', 'भाषा');

  String get headingWhoIsPlaying => pick('WHO IS PLAYING', 'कौन खेल रहा है');

  String get headingSound => pick('SOUND', 'आवाज़');

  String get headingTextSize => pick('TEXT SIZE', 'अक्षर का आकार');

  String get headingHomeScreen => pick('HOME SCREEN', 'पहला पन्ना');

  String get notSet => pick('Not set', 'नहीं लिखा');

  String get sounds => pick('Sounds', 'आवाज़');

  String get soundsHint => pick(
        'A note when a piece is placed, a chime at the end',
        'कुछ रखने पर एक सुर, खेल पूरा होने पर घंटी',
      );

  String get vibration => pick('Vibration', 'कंपन');

  String get vibrationHint =>
      pick('A small buzz on each tap', 'हर छुअन पर हल्का कंपन');

  String get testTheSound => pick('Test the sound', 'आवाज़ जाँचिए');

  String soundTest(String report) =>
      pick('Sound test: $report', 'आवाज़ की जाँच: $report');

  String get showPoints => pick('Show points', 'अंक दिखाएँ');

  String get showPointsHint => pick(
        'The running total under the greeting',
        'नमस्ते के नीचे कुल जोड़',
      );

  String get textNormal => pick('Normal', 'सामान्य');

  String get textLarge => pick('Large', 'बड़े');

  String get textLargest => pick('Largest', 'सबसे बड़े');
}
