/// One question with four answers, used by every game in this folder.
///
/// Five games share this shape and the one screen that renders it: completing
/// a song title, completing a kahavat, saying which of two things came first,
/// a times-table drill, and picking the odd one out. They differ only in where
/// their questions come from, which keeps one interaction to get right rather
/// than five.
library;

class ChoiceQuestion {
  /// Shown large, above the answers. Often holds a blank.
  final String prompt;

  /// A quieter line under the prompt, for a hint of context -- the film a
  /// song comes from, the category a word belongs to. May be empty.
  final String note;

  /// Always four.
  final List<String> options;

  /// Index into [options].
  final int answer;

  const ChoiceQuestion({
    required this.prompt,
    required this.options,
    required this.answer,
    this.note = '',
  });
}
