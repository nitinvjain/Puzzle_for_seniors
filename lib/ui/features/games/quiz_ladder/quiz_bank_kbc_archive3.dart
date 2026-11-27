/// The last eight of the twenty-five episode pages.
///
/// Same rule throughout: facts taken, wording and options written here,
/// anything resting on recent learning left on the page.
///
/// Three of these pages were wrong, and the errors are instructive:
///
///   * one asked which country first sent a man-made object to the Moon and
///     answered the United States. It was the Soviet Union, with Luna 2 in
///     1959. Dropped.
///   * one asked which pair is NOT from the Ramayana and answered Bharata
///     and Mandavi, who are from it. Dropped.
///   * one asked how many millilitres are in an inch. An inch is a length,
///     and the number it gave -- 25.4 -- is millimetres. The question is
///     here with the right unit, because the fact is worth asking and only
///     the wording was broken.
///
/// Two more were dropped as unverifiable rather than wrong: which state has
/// produced the most governors who went on to be President, and which
/// district Udvada now falls in.
library;

import 'quiz_question.dart';

const List<QuizQuestion> kbcArchive3Questions = [
  QuizQuestion(question: 'Which state had India\'s first Muslim woman Chief Minister?', options: ['Assam', 'Kerala', 'Bihar', 'Jammu and Kashmir'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which word is both a sign of the zodiac and the name of a Hindi film actor?', options: ['Kumbh', 'Mithun', 'Tula', 'Meen'], answer: 1, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'On a railway ticket, what does the R in PNR stand for?', options: ['Reservation', 'Route', 'Record', 'Reference'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which of these is not a fish?', options: ['The pomfret', 'The rohu', 'The mackerel', 'The prawn'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'In 2017 ISRO launched a record number of satellites on one rocket. How many?', options: ['104', '37', '65', '88'], answer: 0, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which is the largest joint in the human body?', options: ['The elbow', 'The knee', 'The hip', 'The shoulder'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'King Dasharatha\'s name refers to his ability to do what?', options: ['Fight ten warriors at once', 'Rule ten kingdoms', 'Drive his chariot in all directions', 'Live for ten ages'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'What does the R stand for in the name B.R. Ambedkar?', options: ['Rao', 'Raghav', 'Ranjit', 'Ramji'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which creature is used to make vermicompost?', options: ['The earthworm', 'The honeybee', 'The silkworm', 'The termite'], answer: 0, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Balls, ribbons, ropes, hoops and clubs are the apparatus of which sport?', options: ['Fencing', 'Rhythmic gymnastics', 'Archery', 'Wrestling'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'The only person to win two unshared Nobel Prizes won them in which two fields?', options: ['Physics and Chemistry', 'Medicine and Peace', 'Chemistry and Peace', 'Physics and Peace'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which of these board games is played by exactly two opponents?', options: ['Ludo', 'Carrom', 'Snakes and ladders', 'Chess'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which Hindi expression means to slip away or run off?', options: ['Ruffu chakkar hona', 'Chakkar khana', 'Chakkar mein padna', 'Gol maal hona'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which puja is observed by honouring one\'s tools and machines?', options: ['Saraswati Puja', 'Vishwakarma Puja', 'Chhath Puja', 'Lakshmi Puja'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'EVM and VVPAT are used in which process?', options: ['The census', 'Tax collection', 'Elections', 'Passport issue'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Lord Brahma is usually shown seated upon what?', options: ['A bull', 'An eagle', 'A swan\'s egg', 'A lotus'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which decision was announced to the country in a television address on the evening of 8 November 2016?', options: ['Demonetisation', 'The GST rollout', 'The Aadhaar scheme', 'The Swachh Bharat mission'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who coined the word allopathy in 1842?', options: ['Louis Pasteur', 'Samuel Hahnemann', 'Edward Jenner', 'Joseph Lister'], answer: 1, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which pair of numbers is used in the Hindi phrase for a very slight difference?', options: ['Ek-do', 'Nau-das', 'Unnis-bees', 'Pandrah-solah'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The snack dabeli is believed to come from which region?', options: ['Malwa', 'Konkan', 'Marathwada', 'Kutch'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which of these is most numerous in the adult human body?', options: ['Bones', 'Kidneys', 'Lungs', 'Finger bones of both hands'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which direction gave the trading company that ruled Bengal its name?', options: ['West', 'East', 'North', 'South'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'What did all five Pandava brothers have in common?', options: ['They had the same mother', 'They were all archers', 'They shared one wife', 'They were all crowned'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Siddhartha Mukherjee\'s The Emperor of All Maladies is a biography of which disease?', options: ['Tuberculosis', 'Malaria', 'Cholera', 'Cancer'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which Nobel laureate philosopher appeared in the 1967 Hindi film Aman?', options: ['Bertrand Russell', 'Albert Schweitzer', 'Linus Pauling', 'Albert Einstein'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Cone, cup and bar are the usual forms of what?', options: ['Soap', 'Ice cream', 'Chocolate', 'Tea'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Who wrote Varna Parichay, used for generations to teach the Bengali alphabet?', options: ['Rabindranath Tagore', 'Bankim Chandra Chatterjee', 'Ishwar Chandra Vidyasagar', 'Raja Ram Mohan Roy'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In the Arabian Nights, who appears when Aladdin rubs the lamp?', options: ['A dwarf', 'A wizard', 'A parrot', 'A jinn'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which god took the form of Mohini?', options: ['Vishnu', 'Shiva', 'Brahma', 'Indra'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Nanda Devi has two summits. What is the eastern one called?', options: ['Trishul', 'Sunanda', 'Kamet', 'Panchachuli'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Gandhi Jayanti falls on which day of the calendar year?', options: ['The first day of the tenth month', 'The second day of the ninth month', 'The second day of the tenth month', 'The tenth day of the second month'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Which name belongs both to a variety of tea and to a hill station?', options: ['Assam', 'Nilgiri', 'Munnar', 'Darjeeling'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which word, borrowed into Hindi, originally meant a writer or clerk?', options: ['Munshi', 'Mistri', 'Mukhiya', 'Mahant'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In the Valmiki Ramayana, what was the name of the jewel Sita wore in her hair?', options: ['Kaustubh', 'Chudamani', 'Syamantak', 'Mani Mala'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Kalsubai peak and Ratangarh fort stand near which hill station?', options: ['Matheran', 'Lonavala', 'Bhandardara', 'Panchgani'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which social reformer of Maharashtra was known as Lokhitvadi?', options: ['Jyotirao Phule', 'Gopal Ganesh Agarkar', 'Mahadev Govind Ranade', 'Gopal Hari Deshmukh'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The Chandi Path recited during Durga Puja comes from which Purana?', options: ['The Markandeya Purana', 'The Vishnu Purana', 'The Shiva Purana', 'The Bhagavata Purana'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Who attended all three Round Table Conferences in London?', options: ['Mahatma Gandhi', 'B.R. Ambedkar', 'Jawaharlal Nehru', 'Sarojini Naidu'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Dastan-e-Ghadar, an eyewitness account of 1857, was written by a court poet of which emperor?', options: ['Akbar II', 'Shah Alam II', 'Bahadur Shah Zafar', 'Aurangzeb'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Aloo tikki chaat is made from patties of what?', options: ['Chickpea', 'Paneer', 'Rice', 'Potato'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The ritual called gaune belongs to which occasion?', options: ['A marriage', 'A birth', 'A harvest', 'A housewarming'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'One inch equals how many millimetres?', options: ['24.5', '25.4', '30.5', '12.7'], answer: 1, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'Flats and high heels are kinds of what?', options: ['Hats', 'Gloves', 'Shoes', 'Belts'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which colour mixed with red in equal part gives pink?', options: ['Yellow', 'Blue', 'Grey', 'White'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which of these fibres comes from the stem of a plant?', options: ['Jute', 'Cotton', 'Coir', 'Wool'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'The traditional Indian game kho kho is said to have grown out of which older game?', options: ['Chaupar', 'Rathera', 'Gilli danda', 'Atya patya'], answer: 1, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'The smallest bone in the human body is found in which part?', options: ['The nose', 'The hand', 'The ear', 'The foot'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'In the Ramayana, which king placed a golden image of his wife beside him for the Ashwamedha yagna?', options: ['Dasharatha', 'Janaka', 'Bharata', 'Rama'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Travelling in a straight line from Shillong towards Kolkata, which country would you cross?', options: ['Bangladesh', 'Nepal', 'Bhutan', 'Myanmar'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Palazzos are worn on which part of the body?', options: ['The head', 'The legs', 'The arms', 'The feet'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which of these is not usually used in shahi paneer?', options: ['Cream', 'Cashew', 'Lentils', 'Tomato'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which habit is most strongly linked to cancer of the mouth and throat?', options: ['Drinking tea', 'Eating chillies', 'Chewing betel leaf alone', 'Chewing tobacco'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Rani ki Vav, the stepwell on the hundred rupee note, is in which state?', options: ['Gujarat', 'Rajasthan', 'Madhya Pradesh', 'Maharashtra'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'In the Shiva Purana, who gave up her life in a sacrificial fire?', options: ['Parvati', 'Sati', 'Ganga', 'Menaka'], answer: 1, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which spiritual leader was made an honorary citizen of Canada?', options: ['Mother Teresa', 'Sri Aurobindo', 'The Dalai Lama', 'Swami Vivekananda'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'In the Ramayana, Nishadraj Guha ferried Rama across the Ganga from which place?', options: ['Chitrakoot', 'Prayag', 'Ayodhya', 'Shringaverpur'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'The poem that became the American national anthem was written aboard a ship built in which city?', options: ['Bombay', 'Calcutta', 'Madras', 'Surat'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Gandhi helped found three football clubs in South Africa. What were they called?', options: ['The Satyagrahis', 'The Passive Resisters', 'The Natal Indians', 'The Transvaal Eleven'], answer: 1, difficulty: 3, topic: 'Sport'),
];
