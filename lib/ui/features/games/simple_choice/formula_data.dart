/// The formulas he taught.
///
/// Thirty years in front of a tenth and twelfth standard class leaves these
/// deeper than almost anything else he knows. Vascular dementia takes new
/// learning and working memory first; overlearned procedure -- the thing
/// repeated several thousand times -- is among the last to go. So this is
/// not a test, it is the part of his memory that still works, and it asks
/// him to be a maths teacher rather than a patient.
///
/// Every answer here was checked by machine before it was written down: each
/// formula was evaluated against its left-hand side at three hundred random
/// values, and each wrong option checked to be genuinely wrong. A formula
/// bank for a maths teacher has to be right, and this is the one kind of
/// content in the app that can be proved rather than trusted.
///
/// Written with "pi" and "root" spelled out rather than the symbols. The app
/// bundles no font that is guaranteed to carry Greek or the radical sign,
/// and an empty box where pi should be would be worse than a plain word.
library;

import 'choice_question.dart';

const List<ChoiceQuestion> formulaQuestions = [
  ChoiceQuestion(prompt: '(a + b)² = ?', options: ['a² + 2ab + b²', 'a² + b²', 'a² - 2ab + b²', 'a² + ab + b²'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(a - b)² = ?', options: ['a² - 2ab + b²', 'a² - b²', 'a² + 2ab + b²', 'a² - ab + b²'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: 'a² - b² = ?', options: ['(a + b)(a - b)', '(a - b)²', '(a + b)²', '(a + b)(a + b)'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(a + b)³ = ?', options: ['a³ + 3a²b + 3ab² + b³', 'a³ + b³', 'a³ + 3ab + b³', 'a³ - 3a²b + 3ab² - b³'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(a - b)³ = ?', options: ['a³ - 3a²b + 3ab² - b³', 'a³ - b³', 'a³ + 3a²b + 3ab² + b³', 'a³ - 3ab + b³'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: 'a³ + b³ = ?', options: ['(a + b)(a² - ab + b²)', '(a + b)(a² + ab + b²)', '(a - b)(a² + ab + b²)', '(a + b)³'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: 'a³ - b³ = ?', options: ['(a - b)(a² + ab + b²)', '(a - b)(a² - ab + b²)', '(a + b)(a² - ab + b²)', '(a - b)³'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(a + b)² - (a - b)² = ?', options: ['4ab', '2ab', '4a²b²', '2a² + 2b²'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(a + b)² + (a - b)² = ?', options: ['2a² + 2b²', '4ab', 'a² + b²', '2ab'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: '(x + a)(x + b) = ?', options: ['x² + (a + b)x + ab', 'x² + ab', 'x² + (a - b)x + ab', 'x² + (a + b)x - ab'], answer: 0, note: 'Algebra'),
  ChoiceQuestion(prompt: 'Area of a circle, radius r = ?', options: ['pi × r²', '2 × pi × r', 'pi × r³', 'pi × 2r'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Circumference of a circle = ?', options: ['2 × pi × r', 'pi × r²', 'pi × r', '4 × pi × r'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Volume of a sphere = ?', options: ['4/3 × pi × r³', '4 × pi × r²', '2/3 × pi × r³', '1/3 × pi × r³'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Surface area of a sphere = ?', options: ['4 × pi × r²', '4/3 × pi × r³', '2 × pi × r²', 'pi × r²'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Volume of a cylinder = ?', options: ['pi × r² × h', '2 × pi × r × h', '1/3 × pi × r² × h', 'pi × r × h²'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Volume of a cone = ?', options: ['1/3 × pi × r² × h', 'pi × r² × h', '1/2 × pi × r² × h', '1/3 × pi × r × h'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Area of a triangle = ?', options: ['1/2 × base × height', 'base × height', '1/3 × base × height', '2 × base × height'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'Area of a trapezium = ?', options: ['1/2 × (sum of parallel sides) × height', '(sum of parallel sides) × height', '1/2 × (difference of parallel sides) × height', '1/2 × a × b × height'], answer: 0, note: 'Mensuration'),
  ChoiceQuestion(prompt: 'nth term of an AP = ?', options: ['a + (n - 1)d', 'a + nd', 'a + (n + 1)d', 'na + d'], answer: 0, note: 'Progressions'),
  ChoiceQuestion(prompt: 'Sum of n terms of an AP = ?', options: ['n/2 × [2a + (n - 1)d]', 'n × [2a + (n - 1)d]', 'n/2 × [a + (n - 1)d]', 'n/2 × [2a + nd]'], answer: 0, note: 'Progressions'),
  ChoiceQuestion(prompt: 'Sum of the first n whole numbers = ?', options: ['n(n + 1)/2', 'n(n - 1)/2', 'n(n + 1)(2n + 1)/6', 'n²/2'], answer: 0, note: 'Progressions'),
  ChoiceQuestion(prompt: 'Sum of the squares of the first n numbers = ?', options: ['n(n + 1)(2n + 1)/6', 'n(n + 1)/2', '[n(n + 1)/2]²', 'n(n + 1)(n + 2)/6'], answer: 0, note: 'Progressions'),
  ChoiceQuestion(prompt: 'nth term of a GP = ?', options: ['a × r^(n-1)', 'a × r^n', 'a + (n - 1)r', 'a × n × r'], answer: 0, note: 'Progressions'),
  ChoiceQuestion(prompt: 'Simple interest = ?', options: ['P × R × T / 100', 'P × R × T', 'P + R × T / 100', 'P × R / (100 × T)'], answer: 0, note: 'Commercial arithmetic'),
  ChoiceQuestion(prompt: 'Amount under compound interest = ?', options: ['P × (1 + R/100)^T', 'P × (1 + R/100) × T', 'P + P × R × T / 100', 'P × (1 + RT/100)'], answer: 0, note: 'Commercial arithmetic'),
  ChoiceQuestion(prompt: 'Profit per cent = ?', options: ['(Profit / Cost price) × 100', '(Profit / Selling price) × 100', '(Cost price / Profit) × 100', 'Profit × 100'], answer: 0, note: 'Commercial arithmetic'),
  ChoiceQuestion(prompt: 'sin²A + cos²A = ?', options: ['1', '0', '2', 'sin A × cos A'], answer: 0, note: 'Trigonometry'),
  ChoiceQuestion(prompt: 'tan A = ?', options: ['sin A / cos A', 'cos A / sin A', '1 / sin A', 'sin A × cos A'], answer: 0, note: 'Trigonometry'),
  ChoiceQuestion(prompt: 'sin 2A = ?', options: ['2 sin A cos A', 'sin A + cos A', '2 sin A', 'sin²A - cos²A'], answer: 0, note: 'Trigonometry'),
  ChoiceQuestion(prompt: '1 + tan²A = ?', options: ['sec²A', 'cosec²A', 'cot²A', 'sin²A'], answer: 0, note: 'Trigonometry'),
];
