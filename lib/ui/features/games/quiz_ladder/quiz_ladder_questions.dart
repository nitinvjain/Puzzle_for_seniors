/// Question bank for Quiz Ladder.
///
/// Roughly nine in ten questions are about India, across maths (to about
/// twelfth standard), basic science, general awareness, Hindi cinema and its
/// music, history, geography, civics, religion and culture, and schooling.
///
/// Three rules were applied when writing these:
///   * only settled facts. Anything that changes with an election, a release
///     or a season is left out, because a quiz that has quietly gone wrong is
///     worse than a short one;
///   * civics and religion are factual and neutral — how the institutions
///     work, what the texts are — never a matter of opinion;
///   * the wrong options are plausible rather than silly, so a right answer
///     means something.
///
/// Difficulty: 1 easy, 2 medium, 3 hard. A game draws five of each.
library;

class QuizQuestion {
  final String question;
  final List<String> options;

  /// Index into [options].
  final int answer;
  final int difficulty;
  final String topic;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
    required this.difficulty,
    required this.topic,
  });
}

const List<QuizQuestion> quizQuestions = [
  // ------------------------------------------------------------------ maths
  QuizQuestion(question: 'What is 15% of 200?', options: ['20', '30', '35', '40'], answer: 1, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What do the angles of a triangle add up to?', options: ['90°', '180°', '270°', '360°'], answer: 1, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What is the square root of 144?', options: ['11', '12', '13', '14'], answer: 1, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What is 7 × 8?', options: ['54', '56', '63', '64'], answer: 1, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which is the next prime number after 7?', options: ['9', '10', '11', '13'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'How many degrees are there in a right angle?', options: ['45', '60', '90', '180'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What is the value of 2³?', options: ['6', '8', '9', '12'], answer: 1, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What is the HCF of 12 and 18?', options: ['3', '6', '9', '12'], answer: 1, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'What is the LCM of 4 and 6?', options: ['10', '12', '18', '24'], answer: 1, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'What do the first ten natural numbers add up to?', options: ['45', '50', '55', '60'], answer: 2, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'How many sides does a decagon have?', options: ['8', '9', '10', '12'], answer: 2, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'What is the value of 5! (five factorial)?', options: ['25', '60', '120', '720'], answer: 2, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'What is the value of sin 30°?', options: ['1/2', '1/√2', '√3/2', '1'], answer: 0, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'What is the volume of a cube with side 3 cm?', options: ['9 cm³', '18 cm³', '27 cm³', '81 cm³'], answer: 2, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'Taking π as 22/7, what is the area of a circle of radius 7 cm?', options: ['44 cm²', '77 cm²', '154 cm²', '308 cm²'], answer: 2, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'What is the value of log₁₀ 1000?', options: ['2', '3', '10', '100'], answer: 1, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'What is the derivative of x² with respect to x?', options: ['x', '2x', 'x²/2', '2'], answer: 1, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'What are the roots of x² − 5x + 6 = 0?', options: ['1 and 6', '2 and 3', '−2 and −3', '5 and 6'], answer: 1, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'Which number is famous as the Ramanujan, or taxicab, number?', options: ['1024', '1729', '2187', '4096'], answer: 1, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'Which Indian mathematician and astronomer wrote the Aryabhatiya?', options: ['Brahmagupta', 'Aryabhata', 'Bhaskara II', 'Varahamihira'], answer: 1, difficulty: 3, topic: 'Maths'),

  // ---------------------------------------------------------------- science
  QuizQuestion(question: 'What is the chemical symbol for gold?', options: ['Ag', 'Au', 'Gd', 'Go'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which planet is nearest to the Sun?', options: ['Venus', 'Earth', 'Mercury', 'Mars'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which gas do plants take in to make their food?', options: ['Oxygen', 'Nitrogen', 'Carbon dioxide', 'Hydrogen'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which is the largest organ of the human body?', options: ['Liver', 'Brain', 'Skin', 'Lungs'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'At what temperature does water boil at sea level?', options: ['90°C', '100°C', '110°C', '120°C'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which vitamin does the body make from sunlight?', options: ['Vitamin A', 'Vitamin B12', 'Vitamin C', 'Vitamin D'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'What is the unit of force?', options: ['Joule', 'Newton', 'Watt', 'Pascal'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Who gave the three laws of motion?', options: ['Galileo', 'Einstein', 'Newton', 'Kepler'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which acid gives lemons their sour taste?', options: ['Acetic acid', 'Citric acid', 'Lactic acid', 'Tartaric acid'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'What does CNG stand for?', options: ['Clean Natural Gas', 'Compressed Natural Gas', 'Carbon Neutral Gas', 'Cooled Nitrogen Gas'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Roughly what is the speed of light in a vacuum?', options: ['3 × 10⁵ m/s', '3 × 10⁶ m/s', '3 × 10⁸ m/s', '3 × 10¹⁰ m/s'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Where is the headquarters of ISRO?', options: ['New Delhi', 'Bengaluru', 'Hyderabad', 'Thiruvananthapuram'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'What was the name of India’s first satellite, launched in 1975?', options: ['Bhaskara', 'Rohini', 'Aryabhata', 'INSAT-1A'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Mangalyaan was India’s mission to which planet?', options: ['Venus', 'Mars', 'Jupiter', 'Saturn'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Near which part of the Moon did Chandrayaan-3 land in 2023?', options: ['The north pole', 'The south pole', 'The equator', 'The far side'], answer: 1, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Who discovered the human blood groups A, B, AB and O?', options: ['Alexander Fleming', 'Karl Landsteiner', 'Louis Pasteur', 'Edward Jenner'], answer: 1, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'What does LED stand for?', options: ['Light Emitting Diode', 'Low Energy Device', 'Linear Electric Display', 'Light Energy Detector'], answer: 0, difficulty: 2, topic: 'Science'),

  // -------------------------------------------------------------- geography
  QuizQuestion(question: 'Which is the longest river in India?', options: ['Yamuna', 'Godavari', 'Ganga', 'Narmada'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Pink City?', options: ['Jodhpur', 'Jaipur', 'Udaipur', 'Bikaner'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Thar Desert lies mainly in which state?', options: ['Gujarat', 'Rajasthan', 'Haryana', 'Punjab'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which state is called the Land of Five Rivers?', options: ['Haryana', 'Punjab', 'Himachal Pradesh', 'Uttarakhand'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Karnataka?', options: ['Mysuru', 'Mangaluru', 'Bengaluru', 'Hubballi'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which place is the southernmost tip of mainland India?', options: ['Rameswaram', 'Kanyakumari', 'Kochi', 'Puducherry'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Lakes?', options: ['Bhopal', 'Udaipur', 'Nainital', 'Srinagar'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest Indian state by area?', options: ['Madhya Pradesh', 'Maharashtra', 'Rajasthan', 'Uttar Pradesh'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Kaziranga National Park, home of the one-horned rhinoceros, is in which state?', options: ['West Bengal', 'Assam', 'Odisha', 'Meghalaya'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Sundarbans are best known for which animal?', options: ['Asiatic lion', 'Royal Bengal tiger', 'Snow leopard', 'Indian elephant'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state has the longest coastline?', options: ['Tamil Nadu', 'Andhra Pradesh', 'Gujarat', 'Maharashtra'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the highest mountain peak lying within India?', options: ['Nanda Devi', 'Kangchenjunga', 'Kamet', 'Saltoro Kangri'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'On which river does the city of Varanasi stand?', options: ['Yamuna', 'Ganga', 'Gomti', 'Son'], answer: 1, difficulty: 1, topic: 'Geography'),

  // ---------------------------------------------------------------- history
  QuizQuestion(question: 'In which year did India become independent?', options: ['1945', '1947', '1948', '1950'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the first Prime Minister of India?', options: ['Sardar Patel', 'Jawaharlal Nehru', 'Rajendra Prasad', 'Lal Bahadur Shastri'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the first President of India?', options: ['S. Radhakrishnan', 'Rajendra Prasad', 'Zakir Husain', 'V. V. Giri'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who built the Taj Mahal?', options: ['Akbar', 'Jahangir', 'Shah Jahan', 'Aurangzeb'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who is remembered as the Iron Man of India?', options: ['Bhagat Singh', 'Sardar Vallabhbhai Patel', 'Subhas Chandra Bose', 'Bal Gangadhar Tilak'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who gave the slogan "Jai Jawan Jai Kisan"?', options: ['Jawaharlal Nehru', 'Lal Bahadur Shastri', 'Indira Gandhi', 'Sardar Patel'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year did the Jallianwala Bagh massacre take place?', options: ['1909', '1919', '1929', '1942'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year was the Quit India Movement launched?', options: ['1930', '1935', '1942', '1945'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Dandi March, or Salt March, took place in which year?', options: ['1920', '1930', '1935', '1940'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who founded the Maurya Empire?', options: ['Ashoka', 'Bindusara', 'Chandragupta Maurya', 'Samudragupta'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year was the Battle of Plassey fought?', options: ['1757', '1764', '1857', '1707'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The first war of Indian independence took place in which year?', options: ['1757', '1857', '1885', '1905'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Emperor Ashoka belonged to which dynasty?', options: ['Gupta', 'Maurya', 'Chola', 'Mughal'], answer: 1, difficulty: 2, topic: 'History'),

  // ------------------------------------------------------- civics & general
  QuizQuestion(question: 'What is the national bird of India?', options: ['Sparrow', 'Peacock', 'Parrot', 'Eagle'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national animal of India?', options: ['Lion', 'Elephant', 'Tiger', 'Leopard'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national flower of India?', options: ['Rose', 'Marigold', 'Lotus', 'Jasmine'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Who wrote the national anthem of India?', options: ['Bankim Chandra Chatterjee', 'Rabindranath Tagore', 'Sarojini Naidu', 'Subramania Bharati'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the minimum age to vote in India?', options: ['16', '18', '21', '25'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the national song of India?', options: ['Jana Gana Mana', 'Vande Mataram', 'Sare Jahan Se Achha', 'Ae Mere Watan Ke Logon'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who is regarded as the chief architect of the Indian Constitution?', options: ['Jawaharlal Nehru', 'B. R. Ambedkar', 'Rajendra Prasad', 'Sardar Patel'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the upper house of the Indian Parliament?', options: ['Lok Sabha', 'Rajya Sabha', 'Vidhan Sabha', 'Vidhan Parishad'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How many states does India have?', options: ['25', '28', '29', '31'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the normal term of the Lok Sabha?', options: ['4 years', '5 years', '6 years', '7 years'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who formally appoints the Prime Minister of India?', options: ['The Chief Justice', 'The President', 'The Vice-President', 'The Speaker'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who is the Supreme Commander of the Indian Armed Forces?', options: ['The Prime Minister', 'The President', 'The Defence Minister', 'The Chief of Army Staff'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Where is the headquarters of the Reserve Bank of India?', options: ['New Delhi', 'Mumbai', 'Kolkata', 'Chennai'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How many seats are there in the Lok Sabha?', options: ['250', '400', '543', '600'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Constitution of India was adopted on which date?', options: ['15 August 1947', '26 November 1949', '26 January 1950', '2 October 1950'], answer: 1, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What does UPI stand for?', options: ['United Payment Interface', 'Unified Payments Interface', 'Universal Payment Index', 'Unique Payment Identifier'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which country did India overtake in 2023 to become the most populous?', options: ['Indonesia', 'China', 'United States', 'Pakistan'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which city hosted the G20 Leaders’ Summit held in India in 2023?', options: ['Mumbai', 'New Delhi', 'Bengaluru', 'Hyderabad'], answer: 1, difficulty: 3, topic: 'General'),

  // ------------------------------------------------------------ hindi films
  QuizQuestion(question: 'Who is known as the Shahenshah of Hindi cinema?', options: ['Dilip Kumar', 'Raj Kapoor', 'Amitabh Bachchan', 'Dev Anand'], answer: 2, difficulty: 1, topic: 'Films'),
  QuizQuestion(question: 'In which year was the film Sholay released?', options: ['1971', '1975', '1978', '1982'], answer: 1, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Who played Gabbar Singh in Sholay?', options: ['Amjad Khan', 'Prem Chopra', 'Ajit', 'Danny Denzongpa'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actress is known as the Dream Girl?', options: ['Rekha', 'Hema Malini', 'Sridevi', 'Madhuri Dixit'], answer: 1, difficulty: 1, topic: 'Films'),
  QuizQuestion(question: 'Raj Kapoor was popularly called by which title?', options: ['The Showman', 'The Tragedy King', 'The Evergreen Hero', 'The Angry Young Man'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which was the first Indian talkie film, released in 1931?', options: ['Raja Harishchandra', 'Alam Ara', 'Achhut Kanya', 'Devdas'], answer: 1, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who directed the classic Mughal-e-Azam?', options: ['Mehboob Khan', 'K. Asif', 'Bimal Roy', 'Guru Dutt'], answer: 1, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who directed the 1957 classic Mother India?', options: ['Raj Kapoor', 'Mehboob Khan', 'V. Shantaram', 'Bimal Roy'], answer: 1, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In which Oscar category was Lagaan nominated?', options: ['Best Picture', 'Best Foreign Language Film', 'Best Director', 'Best Original Score'], answer: 1, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'What does the film title DDLJ stand for?', options: ['Dil Deke Lo Jaan', 'Dilwale Dulhania Le Jayenge', 'Dil Dhadakne Laga Jaanam', 'Do Dilon Ki Jeet'], answer: 1, difficulty: 1, topic: 'Films'),

  // ------------------------------------------------------------ film music
  QuizQuestion(question: 'Which singer is known as the Nightingale of India?', options: ['Asha Bhosle', 'Lata Mangeshkar', 'Geeta Dutt', 'Shamshad Begum'], answer: 1, difficulty: 1, topic: 'Film music'),
  QuizQuestion(question: 'Asha Bhosle is the sister of which famous singer?', options: ['Geeta Dutt', 'Lata Mangeshkar', 'Suman Kalyanpur', 'Alka Yagnik'], answer: 1, difficulty: 1, topic: 'Film music'),
  QuizQuestion(question: 'Who sang the song "Mere Sapno Ki Rani"?', options: ['Mohammed Rafi', 'Kishore Kumar', 'Mukesh', 'Manna Dey'], answer: 1, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Sholay?', options: ['Naushad', 'R. D. Burman', 'Laxmikant-Pyarelal', 'Shankar-Jaikishan'], answer: 1, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The song "Pyar Kiya To Darna Kya" is from which film?', options: ['Mughal-e-Azam', 'Pakeezah', 'Umrao Jaan', 'Anarkali'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'For which film did A. R. Rahman win his Academy Awards?', options: ['Roja', 'Lagaan', 'Slumdog Millionaire', 'Dil Se'], answer: 2, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the song "Jai Ho"?', options: ['Shankar-Ehsaan-Loy', 'A. R. Rahman', 'Vishal-Shekhar', 'Pritam'], answer: 1, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Naushad Ali was celebrated as what in Hindi cinema?', options: ['A playback singer', 'A music director', 'A lyricist', 'A film director'], answer: 1, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Mohammed Rafi is remembered chiefly as what?', options: ['A music director', 'A playback singer', 'A lyricist', 'An actor'], answer: 1, difficulty: 1, topic: 'Film music'),

  // -------------------------------------------------- religion and culture
  QuizQuestion(question: 'Diwali is the festival of what?', options: ['Colours', 'Lights', 'Harvest', 'Rain'], answer: 1, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Holi is the festival of what?', options: ['Lights', 'Colours', 'Boats', 'Kites'], answer: 1, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'How many Vedas are there?', options: ['2', '3', '4', '6'], answer: 2, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Who is traditionally credited with composing the Ramayana?', options: ['Vyasa', 'Valmiki', 'Kalidasa', 'Tulsidas'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The Bhagavad Gita forms part of which epic?', options: ['Ramayana', 'Mahabharata', 'Rigveda', 'Puranas'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In which city is the Golden Temple?', options: ['Amritsar', 'Ludhiana', 'Patiala', 'Chandigarh'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Mahavira is associated with which religion?', options: ['Buddhism', 'Jainism', 'Sikhism', 'Zoroastrianism'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'At which place was Gautama Buddha born?', options: ['Bodh Gaya', 'Sarnath', 'Lumbini', 'Kushinagar'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'At which place did Gautama Buddha attain enlightenment?', options: ['Lumbini', 'Bodh Gaya', 'Sarnath', 'Rajgir'], answer: 1, difficulty: 2, topic: 'Culture'),

  // ---------------------------------------------------- teaching & schools
  QuizQuestion(question: 'On which date is Teachers’ Day celebrated in India?', options: ['5 September', '14 November', '2 October', '26 January'], answer: 0, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'Teachers’ Day in India marks the birthday of whom?', options: ['Jawaharlal Nehru', 'S. Radhakrishnan', 'Rabindranath Tagore', 'Mahatma Gandhi'], answer: 1, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'Children’s Day is celebrated in India on which date?', options: ['5 September', '14 November', '20 November', '1 June'], answer: 1, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'What does CBSE stand for?', options: ['Central Board of School Education', 'Central Board of Secondary Education', 'Combined Board of Secondary Education', 'Council for Basic School Education'], answer: 1, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'What does NCERT stand for?', options: ['National Centre for Education and Research Training', 'National Council of Educational Research and Training', 'National Committee for Education Reform and Teaching', 'National Curriculum and Education Research Trust'], answer: 1, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'The Right to Education covers children of which age group?', options: ['3 to 10 years', '6 to 14 years', '5 to 16 years', '6 to 18 years'], answer: 1, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'Which constitutional amendment made education a fundamental right?', options: ['42nd', '73rd', '86th', '101st'], answer: 2, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'What does IIT stand for?', options: ['Indian Institute of Technology', 'Indian Institute of Training', 'International Institute of Technology', 'Institute of Indian Technology'], answer: 0, difficulty: 1, topic: 'Schools'),
];
