/// Question bank for KBC India -- the combiner.
///
/// The questions themselves live in quiz_bank_*.dart, one file per subject.
/// This file only joins them together, so `quizQuestions` stays the single
/// name the screen reads and nothing else needs to know the bank was split.
///
/// Roughly nine in ten questions are about India, across maths (to about
/// twelfth standard), basic science, general awareness, Hindi cinema and its
/// music, film music and classical music, history, geography, civics,
/// religion and culture, sport, and schooling and teaching.
///
/// Rules applied throughout, and worth keeping to when adding more:
///   * only settled facts. Anything that changes with an election, a release
///     or a season is left out, because a quiz that has quietly gone wrong is
///     worse than a short one;
///   * civics and religion are factual and neutral -- how the institutions
///     work, what the texts are -- never a matter of opinion;
///   * the wrong options are plausible rather than silly, so a right answer
///     means something;
///   * the maths questions are generated rather than hand-written, so every
///     sum in them is computed and cannot be wrong;
///   * the correct answer is spread evenly across the four positions. This
///     matters more than it looks: with the answer nearly always second, the
///     game could be "won" by pressing the same button every time, which
///     would defeat the whole point of playing it.
///
/// To add questions: put them in the bank file for their subject, or add a
/// new quiz_bank_<subject>.dart and list it below. Check first that the
/// question is not already in another bank -- the lists are concatenated, so
/// a repeat here is a repeat the player sees.
library;

import 'quiz_bank_bollywood.dart';
import 'quiz_bank_classx.dart';
import 'quiz_bank_culture.dart';
import 'quiz_bank_filmmusic2.dart';
import 'quiz_bank_films.dart';
import 'quiz_bank_general.dart';
import 'quiz_bank_geography.dart';
import 'quiz_bank_history.dart';
import 'quiz_bank_maths.dart';
import 'quiz_bank_music.dart';
import 'quiz_bank_quizbook.dart';
import 'quiz_bank_quizbook2.dart';
import 'quiz_bank_quizbook3.dart';
import 'quiz_bank_science.dart';
import 'quiz_bank_sports.dart';
import 'quiz_bank_teaching.dart';
import 'quiz_question.dart';

// Re-exported so that importing this file is enough -- the screen refers to
// QuizQuestion without needing to know which file declares it.
export 'quiz_question.dart';

/// Every question in the bank, in subject order.
///
/// The screen groups these by difficulty and draws a fresh round each game,
/// so the order here does not decide the order of play.
final List<QuizQuestion> quizQuestions = List<QuizQuestion>.unmodifiable([
  ...mathsQuestions,
  ...classXMathsQuestions,
  ...scienceQuestions,
  ...generalQuestions,
  ...geographyQuestions,
  ...historyQuestions,
  ...cultureQuestions,
  ...filmQuestions,
  ...bollywoodQuestions,
  ...musicQuestions,
  ...filmMusic2Questions,
  ...sportsQuestions,
  ...teachingQuestions,
  ...quizbookQuestions,
  ...quizbook2Questions,
  ...quizbook3Questions,
]);
