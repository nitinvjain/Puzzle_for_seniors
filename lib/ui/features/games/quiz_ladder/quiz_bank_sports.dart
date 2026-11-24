/// Sport questions for KBC India.
///
/// Rules this file follows:
///  * settled facts only -- nothing that turns on a current season, a squad
///    list or a live record, because those go stale and a stale question is
///    a question the player gets wrong for no reason;
///  * India-weighted, and tilted towards the decades an older player
///    actually watched;
///  * distractors are plausible, never silly.
library;

import 'quiz_question.dart';

const List<QuizQuestion> sportsQuestions = [
  // ---------------------------------------------------------------- cricket
  QuizQuestion(
      question: 'Which country did India beat in the final to win the 1983 Cricket World Cup?',
      options: ['West Indies', 'England', 'Pakistan', 'Australia'],
      answer: 0,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who captained India to victory in the 1983 Cricket World Cup?',
      options: ['Sunil Gavaskar', 'Kapil Dev', 'Bishan Singh Bedi', 'Mohinder Amarnath'],
      answer: 1,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which ground hosted the final of the 1983 Cricket World Cup?',
      options: ['Headingley', 'The Oval', 'Lord’s', 'Old Trafford'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who was the first batsman to score a century in Test cricket for India?',
      options: ['Lala Amarnath', 'Vijay Merchant', 'Vijay Hazare', 'Vinoo Mankad'],
      answer: 0,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which Indian batsman was the first to score 10,000 runs in Test cricket?',
      options: ['Rahul Dravid', 'Dilip Vengsarkar', 'Sachin Tendulkar', 'Sunil Gavaskar'],
      answer: 3,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who was the first bowler to take all ten wickets in a Test innings for India?',
      options: ['Erapalli Prasanna', 'Anil Kumble', 'Kapil Dev', 'Bishan Singh Bedi'],
      answer: 1,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Against which team did Anil Kumble take ten wickets in an innings in 1999?',
      options: ['Pakistan', 'England', 'Sri Lanka', 'Australia'],
      answer: 0,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(question: 'How many stumps make up one wicket in cricket?', options: ['Two', 'Three', 'Four', 'Six'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(
      question: 'How many balls are bowled in one over in cricket?',
      options: ['Four', 'Five', 'Six', 'Eight'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'What is the distance between the two sets of stumps on a cricket pitch?',
      options: ['18 yards', '20 yards', '22 yards', '24 yards'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which trophy is contested by India’s domestic first-class cricket teams?',
      options: ['Irani Cup', 'Deodhar Trophy', 'Duleep Trophy', 'Ranji Trophy'],
      answer: 3,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which Indian cricket ground is known as the Eden Gardens?',
      options: ['The Delhi ground', 'The Mumbai ground', 'The Kolkata ground', 'The Chennai ground'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which Indian batsman was nicknamed the “Little Master” before Sachin Tendulkar?',
      options: ['Gundappa Viswanath', 'Sunil Gavaskar', 'Mohinder Amarnath', 'Chetan Chauhan'],
      answer: 1,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(question: 'Who was named Player of the Match in the 1983 Cricket World Cup final?', options: ['Sunil Gavaskar', 'Madan Lal', 'Kapil Dev', 'Mohinder Amarnath'], answer: 3, difficulty: 3, topic: 'Sport'),
  QuizQuestion(
      question: 'What is the term for a bowler dismissing three batsmen with three successive balls?',
      options: ['A triple', 'A maiden', 'A hat-trick', 'A double strike'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'How many runs are awarded when the ball crosses the boundary after bouncing?',
      options: ['Two', 'Three', 'Four', 'Six'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),

  // ----------------------------------------------------------------- hockey
  QuizQuestion(
      question: 'Which sport is Dhyan Chand remembered for?',
      options: ['Hockey', 'Football', 'Wrestling', 'Cricket'],
      answer: 0,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'In which Olympic Games did India win its first hockey gold medal?',
      options: ['1920 Antwerp', '1928 Amsterdam', '1936 Berlin', '1948 London'],
      answer: 1,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(
      question: 'How many players from each side are on the field in a hockey match?',
      options: ['Nine', 'Ten', 'Eleven', 'Twelve'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'India’s National Sports Day is observed on the birthday of which sportsman?',
      options: ['K. D. Jadhav', 'Balbir Singh', 'Dhyan Chand', 'Milkha Singh'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),

  // ------------------------------------------------------- athletics, others
  QuizQuestion(
      question: 'Which Indian athlete was known as the “Flying Sikh”?',
      options: ['Milkha Singh', 'Gurbachan Singh Randhawa', 'Sriram Singh', 'Praveen Kumar'],
      answer: 0,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who was the first Indian to win an individual Olympic medal?',
      options: ['Norman Pritchard', 'Karnam Malleswari', 'Leander Paes', 'K. D. Jadhav'],
      answer: 3,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(
      question: 'In which sport did K. D. Jadhav win his Olympic bronze medal?',
      options: ['Boxing', 'Wrestling', 'Weightlifting', 'Shooting'],
      answer: 1,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who was the first Indian woman to win an Olympic medal?',
      options: ['Karnam Malleswari', 'Saina Nehwal', 'Mary Kom', 'P. T. Usha'],
      answer: 0,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which Indian sprinter was nicknamed the “Payyoli Express”?',
      options: ['Shiny Abraham', 'Anju Bobby George', 'M. D. Valsamma', 'P. T. Usha'],
      answer: 3,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which board game, played on 64 squares, has India as the country of its ancient ancestor chaturanga?',
      options: ['Go', 'Draughts', 'Chess', 'Backgammon'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Who became India’s first chess Grandmaster?',
      options: ['Krishnan Sasikiran', 'Viswanathan Anand', 'Pravin Thipsay', 'Dibyendu Barua'],
      answer: 1,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'How many squares does a chessboard have?',
      options: ['36', '49', '64', '81'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'In badminton, which Indian player won the All England championship in 1980 and 1981?',
      options: ['Syed Modi', 'Pullela Gopichand', 'Dinesh Khanna', 'Prakash Padukone'],
      answer: 3,
      difficulty: 3,
      topic: 'Sport'),
  QuizQuestion(
      question: 'How many rings are there in the Olympic symbol?',
      options: ['Four', 'Five', 'Six', 'Seven'],
      answer: 1,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(question: 'In which city were the first Olympic Games of the modern series held, in 1896?', options: ['Rome', 'Paris', 'Athens', 'London'], answer: 2, difficulty: 2, topic: 'Sport'),
  QuizQuestion(
      question: 'Which sport uses the terms love, deuce and advantage?',
      options: ['Tennis', 'Badminton', 'Squash', 'Table tennis'],
      answer: 0,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'How many players are there in a football team on the field?',
      options: ['Nine', 'Ten', 'Eleven', 'Twelve'],
      answer: 2,
      difficulty: 1,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which Indian state is most closely associated with the sport of kabaddi’s traditional rural form?',
      options: ['Kerala', 'Punjab', 'Assam', 'Odisha'],
      answer: 1,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'Which traditional Indian sport is a combat sport played on soil, and has akharas as its training grounds?',
      options: ['Gilli-danda', 'Kabaddi', 'Kushti (wrestling)', 'Kho-kho'],
      answer: 2,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'The Davis Cup is contested in which sport?',
      options: ['Tennis', 'Cricket', 'Badminton', 'Golf'],
      answer: 0,
      difficulty: 2,
      topic: 'Sport'),
  QuizQuestion(
      question: 'In which sport are the terms raider, antis and bonus point used?',
      options: ['Wrestling', 'Volleyball', 'Kho-kho', 'Kabaddi'],
      answer: 3,
      difficulty: 2,
      topic: 'Sport'),
];
