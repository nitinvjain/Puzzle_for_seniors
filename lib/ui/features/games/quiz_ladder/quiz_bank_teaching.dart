/// Teaching, schools and the history of Indian mathematics, for KBC India.
///
/// Included at the player's own request: he taught maths to classes 10 to 12
/// for a working lifetime, so this is the topic he is most likely to be sure
/// of. Settled facts only -- no syllabus changes, no current policy details.
///
/// Note: the Teachers' Day, Children's Day, CBSE, NCERT, UGC, IIT and
/// Right-to-Education questions live in quiz_bank_culture.dart. Don't add
/// them here as well -- the combiner concatenates every bank, so a repeat
/// here is a repeat the player actually sees.
library;

import 'quiz_question.dart';

const List<QuizQuestion> teachingQuestions = [
  // ------------------------------------------------- schools and the system
  QuizQuestion(
      question: 'What does NEP stand for in Indian education?',
      options: [
        'National Educational Panel',
        'National Education Policy',
        'New Education Plan',
        'National Examination Programme'
      ],
      answer: 1,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'What does IGNOU stand for?',
      options: [
        'Indira Gandhi National Open University',
        'Indian General National Online University',
        'Integrated Graduate National Open University',
        'Indian Government National Open University'
      ],
      answer: 0,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'What does NIOS stand for?',
      options: [
        'National Institute of Secondary Schools',
        'New Indian Open School',
        'National Independent Open Schooling',
        'National Institute of Open Schooling'
      ],
      answer: 3,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which examination is the entrance test for admission to the IITs?',
      options: ['GATE', 'NEET', 'JEE', 'CAT'],
      answer: 2,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which entrance examination is taken for admission to medical courses in India?',
      options: ['JEE', 'NEET', 'CLAT', 'GATE'],
      answer: 1,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which body conducts the Class 10 and Class 12 board examinations for CBSE schools?',
      options: ['UGC', 'AICTE', 'NCERT', 'CBSE itself'],
      answer: 3,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'What is the common name for Class 10 and Class 12 examinations in India?',
      options: ['Public service exams', 'Entrance exams', 'Board exams', 'Term exams'],
      answer: 2,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which degree is the usual teaching qualification for school teachers in India?',
      options: ['B.Ed.', 'M.Phil.', 'B.Sc.', 'B.A.'],
      answer: 0,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which organisation regulates university education in India?',
      options: ['AICTE', 'UGC', 'CBSE', 'NCERT'],
      answer: 1,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'In the Indian school system, what is Class 12 also commonly called?',
      options: ['Primary', 'Matriculation', 'Higher Secondary', 'Middle School'],
      answer: 2,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'In the older Indian school system, which class was called “matriculation”?',
      options: ['Class 8', 'Class 10', 'Class 11', 'Class 12'],
      answer: 1,
      difficulty: 2,
      topic: 'Teaching'),

  // ----------------------------------------------- the words of mathematics
  QuizQuestion(
      question: 'In mathematics, what is a statement accepted as true without proof called?',
      options: ['Axiom', 'Corollary', 'Lemma', 'Theorem'],
      answer: 0,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'In mathematics, what is a statement that has been proved called?',
      options: ['Postulate', 'Conjecture', 'Axiom', 'Theorem'],
      answer: 3,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'What is a mathematical statement believed true but not yet proved called?',
      options: ['Theorem', 'Conjecture', 'Axiom', 'Identity'],
      answer: 1,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which branch of mathematics uses letters to stand for numbers?',
      options: ['Algebra', 'Arithmetic', 'Statistics', 'Geometry'],
      answer: 0,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which branch of mathematics studies shapes, lines and angles?',
      options: ['Calculus', 'Statistics', 'Algebra', 'Geometry'],
      answer: 3,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which branch of mathematics deals with rates of change and areas under curves?',
      options: ['Number theory', 'Trigonometry', 'Calculus', 'Algebra'],
      answer: 2,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which branch of mathematics studies triangles and the ratios of their sides?',
      options: ['Probability', 'Trigonometry', 'Topology', 'Mensuration'],
      answer: 1,
      difficulty: 2,
      topic: 'Teaching'),

  // -------------------------------------- the mathematicians and the scholars
  QuizQuestion(
      question: 'Which ancient Indian mathematician wrote the Aryabhatiya?',
      options: ['Bhaskara', 'Varahamihira', 'Brahmagupta', 'Aryabhata'],
      answer: 3,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which Indian mathematician first gave rules for calculating with zero as a number?',
      options: ['Mahavira', 'Aryabhata', 'Brahmagupta', 'Bhaskara II'],
      answer: 2,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which Indian mathematician, largely self-taught, worked with G. H. Hardy at Cambridge?',
      options: ['Srinivasa Ramanujan', 'S. N. Bose', 'C. V. Raman', 'P. C. Mahalanobis'],
      answer: 0,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'National Mathematics Day in India is observed on the birthday of which mathematician?',
      options: ['Aryabhata', 'Srinivasa Ramanujan', 'Brahmagupta', 'Bhaskara II'],
      answer: 1,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which Indian statistician founded the Indian Statistical Institute?',
      options: ['Harish-Chandra', 'C. R. Rao', 'P. C. Mahalanobis', 'D. D. Kosambi'],
      answer: 2,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which ancient Indian scholar wrote the Sanskrit grammar known as the Ashtadhyayi?',
      options: ['Panini', 'Patanjali', 'Kalidasa', 'Vyasa'],
      answer: 0,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'In which present-day state was the ancient university of Nalanda situated?',
      options: ['West Bengal', 'Odisha', 'Uttar Pradesh', 'Bihar'],
      answer: 3,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Taxila, one of the ancient world’s great centres of learning, lies in present-day which country?',
      options: ['India', 'Pakistan', 'Afghanistan', 'Nepal'],
      answer: 1,
      difficulty: 3,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which Indian social reformer is remembered for founding schools for girls in 19th-century Maharashtra?',
      options: ['Savitribai Phule', 'Pandita Ramabai', 'Annie Besant', 'Kamala Nehru'],
      answer: 0,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which Nobel laureate founded the school at Santiniketan?',
      options: ['C. V. Raman', 'Mother Teresa', 'Amartya Sen', 'Rabindranath Tagore'],
      answer: 3,
      difficulty: 1,
      topic: 'Teaching'),

  // ------------------------------------------------------ the classroom itself
  QuizQuestion(
      question: 'In geometry, what is the name of the instrument used to draw circles?',
      options: ['Set square', 'Protractor', 'Compass', 'Divider'],
      answer: 2,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which instrument in a school geometry box is used to measure angles?',
      options: ['Compass', 'Protractor', 'Divider', 'Scale'],
      answer: 1,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which book of tables was used in Indian schools for multiplication and division before calculators?',
      options: ['Almanac', 'Gazetteer', 'Ledger', 'Logarithm tables'],
      answer: 3,
      difficulty: 2,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'What is the counting frame with sliding beads, long used to teach arithmetic, called?',
      options: ['Protractor', 'Vernier', 'Abacus', 'Slide rule'],
      answer: 2,
      difficulty: 1,
      topic: 'Teaching'),
  QuizQuestion(
      question: 'Which sliding calculating instrument did engineers use before pocket calculators?',
      options: ['Slide rule', 'Sextant', 'Theodolite', 'Abacus'],
      answer: 0,
      difficulty: 2,
      topic: 'Teaching'),
];
