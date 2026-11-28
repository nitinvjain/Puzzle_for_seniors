/// One multiple-choice question.
///
/// The bank is split across quiz_bank_*.dart files by subject, which keeps
/// each file reviewable and makes it obvious where to add more.
library;

class QuizQuestion {
  final String question;

  /// Always four. The screen reshuffles them on display, so the answer is
  /// never in a predictable position.
  final List<String> options;

  /// Index into [options].
  final int answer;

  /// 1 easy, 2 medium, 3 hard. A game draws five of each.
  final int difficulty;

  final String topic;

  /// Names a drawing in quiz_figures.dart, or null for a question that is
  /// all words.
  ///
  /// Optional on purpose. There is no code generator in this fork -- no
  /// build_runner, no freezed -- so a field can be added to a hand-written
  /// class like this one but not to a generated one. Being optional also
  /// means the three thousand questions that came before say nothing about
  /// figures and go on compiling untouched.
  final String? figure;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.difficulty,
    required this.topic,
    this.figure,
  });
}
