/// Worked sums with a mistake in them, to be marked.
///
/// This is what he actually did, every evening, for thirty years. Finding
/// somebody else's slip is a different act from doing the sum yourself: it
/// is recognition rather than calculation, it is the thing he was expert at,
/// and it puts him back on the right side of the desk.
///
/// Each line follows on from the number written above it, so the working
/// hangs together and exactly one line is arithmetically wrong. An earlier
/// attempt corrupted an answer but built the next line from the original
/// value, which produced a page where a number appeared out of nowhere --
/// unmarkable, and confusing in exactly the way this app must not be.
///
/// Roughly one paper in five is correct throughout, with "No mistake" as the
/// answer. A teacher has to be able to recognise clean work too, and a game
/// where something is always wrong teaches him to distrust what he reads.
///
/// Generated and then re-marked from its own text: every line checked to
/// follow on, every stated answer checked against a fresh reading of the sum.
library;

import 'choice_question.dart';

const List<ChoiceQuestion> galtiQuestions = [
  ChoiceQuestion(prompt: '15 + 18 = 33\n33 × 8 = 264\n264 - 36 = 228', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '49 - 6 = 43\n43 × 4 = 172\n172 + 33 = 216', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '44 - 13 = 31\n31 × 6 = 186\n186 + 12 = 198', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '21 + 8 = 29\n29 × 8 = 232\n232 + 13 = 245', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '43 - 19 = 24\n24 × 5 = 120\n120 - 40 = 78', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '29 - 8 = 21\n21 × 2 = 42\n42 + 15 = 56', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '46 - 17 = 39\n39 × 2 = 78\n78 - 17 = 61', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 - 18 = 13\n13 × 6 = 78\n78 + 14 = 92', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '28 + 16 = 44\n44 × 2 = 90\n90 - 11 = 79', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '36 - 4 = 32\n32 × 8 = 256\n256 - 19 = 237', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 - 16 = 24\n24 × 3 = 72\n72 + 19 = 91', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '25 - 5 = 20\n20 × 5 = 98\n98 + 17 = 115', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '17 - 16 = 1\n1 × 3 = 3\n3 + 36 = 39', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '48 + 11 = 61\n61 × 6 = 366\n366 + 16 = 382', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 + 8 = 39\n39 × 6 = 234\n234 + 32 = 267', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '46 - 6 = 41\n41 × 7 = 287\n287 - 16 = 271', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 + 17 = 48\n48 × 6 = 288\n288 + 10 = 298', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '19 + 5 = 24\n24 × 6 = 145\n145 - 8 = 137', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '13 + 19 = 32\n32 × 5 = 160\n160 + 16 = 176', options: ['No mistake', 'First line', 'Second line', 'Third line'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '18 + 7 = 25\n25 × 5 = 125\n125 + 24 = 158', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '28 + 18 = 44\n44 × 5 = 220\n220 - 29 = 191', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '48 - 8 = 41\n41 × 7 = 287\n287 - 6 = 281', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '42 + 14 = 65\n65 × 8 = 520\n520 + 32 = 552', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '21 - 12 = 9\n9 × 7 = 63\n63 + 36 = 97', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '16 + 6 = 22\n22 × 6 = 132\n132 - 33 = 109', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 - 10 = 23\n23 × 4 = 92\n92 + 23 = 115', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '14 + 15 = 19\n19 × 6 = 114\n114 + 38 = 152', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '31 + 13 = 53\n53 × 3 = 159\n159 + 16 = 175', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '49 - 3 = 46\n46 × 5 = 230\n230 - 33 = 196', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '20 + 6 = 26\n26 × 9 = 233\n233 - 34 = 199', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '21 + 10 = 31\n31 × 4 = 134\n134 + 9 = 143', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '46 - 5 = 41\n41 × 5 = 214\n214 + 39 = 253', options: ['Second line', 'First line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '20 + 18 = 38\n38 × 6 = 228\n228 + 33 = 260', options: ['Third line', 'First line', 'Second line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '16 + 16 = 33\n33 × 2 = 66\n66 + 25 = 91', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '36 - 4 = 30\n30 × 5 = 150\n150 + 40 = 190', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
  ChoiceQuestion(prompt: '28 - 4 = 34\n34 × 6 = 204\n204 + 11 = 215', options: ['First line', 'Second line', 'Third line', 'No mistake'], answer: 0, note: 'Where does it go wrong?'),
];
