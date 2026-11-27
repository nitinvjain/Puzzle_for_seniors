/// Naap-tol: the weights, measures and money he taught.
///
/// Seer and maund, anna and pie, furlong and gaz. He taught these, then
/// taught the changeover to metric, and a man who spent his working life
/// converting between them holds the tables the way other people hold a
/// tune. The metric ones are here too, so it is his whole career and not
/// just the half of it before 1958.
///
/// Only relations that are fixed everywhere. There is no bigha in this list:
/// it is a different size in every second district, and a question whose
/// answer depends on where you are standing is not one he can get right.
///
/// Checked before being written out: every conversion is a whole multiple,
/// no wrong option equals the right one, and the compound relations were
/// confirmed to follow from the simple ones -- 1 maund is 40 seer and 1 seer
/// is 80 tola, so 1 maund had better be 3200 tola, and it is.
library;

import 'choice_question.dart';

const List<ChoiceQuestion> naapTolQuestions = [
  ChoiceQuestion(prompt: '1 seer = how many tola?', options: ['80', '160', '320', '800'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 maund = how many seer?', options: ['40', '80', '160', '400'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 seer = how many chhatank?', options: ['16', '32', '64', '160'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 chhatank = how many tola?', options: ['5', '10', '20', '50'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 maund = how many tola?', options: ['3200', '6400', '12800', '32000'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 seer = how many pav?', options: ['4', '8', '16', '40'], answer: 0, note: 'Old weights'),
  ChoiceQuestion(prompt: '1 kg = how many grams?', options: ['1000', '2000', '4000', '10000'], answer: 0, note: 'Metric'),
  ChoiceQuestion(prompt: '1 quintal = how many kilograms?', options: ['100', '200', '400', '1000'], answer: 0, note: 'Metric'),
  ChoiceQuestion(prompt: '1 tonne = how many quintals?', options: ['10', '20', '40', '100'], answer: 0, note: 'Metric'),
  ChoiceQuestion(prompt: '1 tonne = how many kilograms?', options: ['1000', '2000', '4000', '10000'], answer: 0, note: 'Metric'),
  ChoiceQuestion(prompt: '1 rupee = how many annas?', options: ['16', '32', '64', '160'], answer: 0, note: 'Old money'),
  ChoiceQuestion(prompt: '1 anna = how many paise?', options: ['4', '8', '16', '40'], answer: 0, note: 'Old money'),
  ChoiceQuestion(prompt: '1 rupee = how many paise?', options: ['64', '128', '256', '640'], answer: 0, note: 'Old money'),
  ChoiceQuestion(prompt: '1 anna = how many pie?', options: ['12', '24', '48', '120'], answer: 0, note: 'Old money'),
  ChoiceQuestion(prompt: '1 rupee = how many pie?', options: ['192', '384', '768', '1920'], answer: 0, note: 'Old money'),
  ChoiceQuestion(prompt: '1 foot = how many inches?', options: ['12', '24', '48', '120'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 gaz = how many feet?', options: ['3', '6', '12', '30'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 yard = how many inches?', options: ['36', '72', '144', '360'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 mile = how many furlongs?', options: ['8', '16', '32', '80'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 furlong = how many yards?', options: ['220', '440', '880', '2200'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 mile = how many yards?', options: ['1760', '3520', '7040', '17600'], answer: 0, note: 'Length'),
  ChoiceQuestion(prompt: '1 dozen = how many ones?', options: ['12', '24', '48', '120'], answer: 0, note: 'Counting'),
  ChoiceQuestion(prompt: '1 gross = how many dozen?', options: ['12', '24', '48', '120'], answer: 0, note: 'Counting'),
  ChoiceQuestion(prompt: '1 gross = how many ones?', options: ['144', '288', '576', '1440'], answer: 0, note: 'Counting'),
  ChoiceQuestion(prompt: '1 score = how many ones?', options: ['20', '40', '80', '200'], answer: 0, note: 'Counting'),
  ChoiceQuestion(prompt: '1 lakh = how many thousand?', options: ['100', '200', '400', '1000'], answer: 0, note: 'Counting'),
  ChoiceQuestion(prompt: '1 crore = how many lakh?', options: ['100', '200', '400', '1000'], answer: 0, note: 'Counting'),
];
