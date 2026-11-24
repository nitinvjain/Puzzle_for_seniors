/// Hindi film music questions for Quiz Ladder.
///
/// Weighted deliberately towards the 1950s to the 1980s: a player in his
/// eighties grew up with this music, and a question he can answer from
/// memory is worth more here than a recent one he has never heard.
///
/// Settled facts only -- no chart positions, no "latest" anything.
library;

import 'quiz_question.dart';

const List<QuizQuestion> musicQuestions = [
  // ----------------------------------------------------------- the singers
  QuizQuestion(question: 'Which award is India’s highest honour for lifetime achievement in cinema?', options: ['National Film Award', 'Padma Shri', 'Filmfare Award', 'Dadasaheb Phalke Award'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(
      question: 'Lata Mangeshkar and Asha Bhosle were related in what way?',
      options: ['Not related', 'Cousins', 'Sisters', 'Aunt and niece'],
      answer: 2,
      difficulty: 1,
      topic: 'Film music'),
  QuizQuestion(question: 'The film Aradhana, famous for its songs, starred which actor?', options: ['Shammi Kapoor', 'Jeetendra', 'Dev Anand', 'Rajesh Khanna'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer was the usual playback voice for Raj Kapoor’s songs?',
      options: ['Hemant Kumar', 'Mohammed Rafi', 'Mukesh', 'Talat Mahmood'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(question: '“Ae Mere Watan Ke Logon” was written in memory of the soldiers of which war?', options: ['The 1962 war with China', 'The 1965 war with Pakistan', 'The 1971 war', 'The 1947 Kashmir war'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(
      question: 'Kishore Kumar was also known for which other role in films?',
      options: ['Choreography', 'Cinematography', 'Only singing', 'Acting and directing'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer’s voice is heard in “Chaudhvin Ka Chand Ho”?',
      options: ['Hemant Kumar', 'Talat Mahmood', 'Mohammed Rafi', 'Mukesh'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which male singer was known for his distinctive soft, trembling voice in ghazals of the 1950s?',
      options: ['Talat Mahmood', 'Mahendra Kapoor', 'Mukesh', 'Manna Dey'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer sang “Zindagi Kaisi Hai Paheli” from the film Anand?',
      options: ['Mukesh', 'Mohammed Rafi', 'Kishore Kumar', 'Manna Dey'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer sang “Kahin Door Jab Din Dhal Jaye” from Anand?',
      options: ['Manna Dey', 'Mohammed Rafi', 'Mukesh', 'Kishore Kumar'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer was famous for the song “Piya Tose Naina Lage Re” from Guide?',
      options: ['Lata Mangeshkar', 'Geeta Dutt', 'Suman Kalyanpur', 'Asha Bhosle'],
      answer: 0,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which playback singer of the 1950s was married to the director Guru Dutt?',
      options: ['Suraiya', 'Noor Jehan', 'Shamshad Begum', 'Geeta Dutt'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer was known for the bhajan “Allah Tero Naam” from Hum Dono?',
      options: ['Shamshad Begum', 'Asha Bhosle', 'Lata Mangeshkar', 'Geeta Dutt'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer sang “Mera Joota Hai Japani” in the film Shree 420?',
      options: ['Mukesh', 'Mohammed Rafi', 'Manna Dey', 'Kishore Kumar'],
      answer: 0,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer became closely associated with R. D. Burman’s livelier songs of the 1970s, including “Dum Maro Dum”?',
      options: ['Usha Mangeshkar', 'Suman Kalyanpur', 'Lata Mangeshkar', 'Asha Bhosle'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),

  // -------------------------------------------------------- the composers
  QuizQuestion(question: 'Who wrote the lyrics for the songs of Sholay?', options: ['Gulzar', 'Sahir Ludhianvi', 'Anand Bakshi', 'Majrooh Sultanpuri'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(
      question: 'R. D. Burman was the son of which other music director?',
      options: ['S. D. Burman', 'C. Ramchandra', 'Madan Mohan', 'Naushad'],
      answer: 0,
      difficulty: 1,
      topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Teesri Manzil and Caravan?', options: ['Laxmikant-Pyarelal', 'Kalyanji-Anandji', 'Shankar-Jaikishan', 'R. D. Burman'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(
      question: 'Who composed the music for Mughal-e-Azam?',
      options: ['Madan Mohan', 'Roshan', 'Naushad', 'Shankar-Jaikishan'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which composer duo scored many Raj Kapoor films including Awara and Shree 420?',
      options: ['Shankar-Jaikishan', 'Laxmikant-Pyarelal', 'Nadeem-Shravan', 'Kalyanji-Anandji'],
      answer: 0,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which composer is remembered for the ghazals of films such as Anpadh and Dastak?',
      options: ['Ravi', 'Khayyam', 'Jaidev', 'Madan Mohan'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Who composed the music for the film Guide?',
      options: ['Roshan', 'Naushad', 'S. D. Burman', 'Shankar-Jaikishan'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which composer wrote the score for Umrao Jaan (1981)?',
      options: ['Khayyam', 'R. D. Burman', 'Laxmikant-Pyarelal', 'Bappi Lahiri'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which composer became known in the 1980s for disco-influenced film songs?',
      options: ['Rajesh Roshan', 'Usha Khanna', 'Ravindra Jain', 'Bappi Lahiri'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),

  // ------------------------------------------------------------ the lyrics
  QuizQuestion(
      question: 'Which lyricist wrote the songs of Pyaasa, including “Jinhe Naaz Hai Hind Par”?',
      options: ['Hasrat Jaipuri', 'Shailendra', 'Sahir Ludhianvi', 'Majrooh Sultanpuri'],
      answer: 2,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which lyricist wrote “Mera Joota Hai Japani”?',
      options: ['Shailendra', 'Sahir Ludhianvi', 'Kaifi Azmi', 'Majrooh Sultanpuri'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Gulzar is best known in films as which of these?',
      options: ['A playback singer', 'A choreographer', 'A composer', 'A lyricist and director'],
      answer: 3,
      difficulty: 1,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which poet-lyricist wrote the songs for the film Kaagaz Ke Phool?',
      options: ['Shailendra', 'Hasrat Jaipuri', 'Kaifi Azmi', 'Sahir Ludhianvi'],
      answer: 2,
      difficulty: 3,
      topic: 'Film music'),

  // ---------------------------------------------- classical and instruments
  QuizQuestion(question: 'Which Indian musician played at the Woodstock festival in 1969?', options: ['Ravi Shankar', 'Vilayat Khan', 'Bismillah Khan', 'Ali Akbar Khan'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which wind instrument is traditionally played at weddings in north India?', options: ['Clarinet', 'Nadaswaram', 'Bansuri', 'Shehnai'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Alla Rakha, the celebrated tabla player, was the father of which musician?', options: ['Samta Prasad', 'Shivkumar Sharma', 'Zakir Hussain', 'Kishan Maharaj'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(
      question: 'Hariprasad Chaurasia is renowned for playing which instrument?',
      options: ['Bansuri (flute)', 'Sitar', 'Veena', 'Shehnai'],
      answer: 0,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which instrument did Ali Akbar Khan play?',
      options: ['Santoor', 'Violin', 'Sitar', 'Sarod'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Shivkumar Sharma brought which instrument into classical concert music?',
      options: ['Rudra veena', 'Esraj', 'Santoor', 'Sarangi'],
      answer: 2,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'How many main notes are there in the Indian classical sargam — sa, re, ga, ma, pa, dha, ni?',
      options: ['Five', 'Six', 'Seven', 'Eight'],
      answer: 2,
      difficulty: 1,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which raga is traditionally performed in the early morning?',
      options: ['Bhairav', 'Darbari', 'Malkauns', 'Bageshri'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'What is the rhythmic cycle in Indian classical music called?',
      options: ['Alap', 'Gharana', 'Raga', 'Taal'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'How many beats are there in teentaal?',
      options: ['Ten', 'Twelve', 'Fourteen', 'Sixteen'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'M. S. Subbulakshmi was celebrated as a singer of which tradition?',
      options: ['Thumri', 'Hindustani classical', 'Carnatic classical', 'Film ghazal'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which singer was famous for the bhajan “Vaishnav Jan To” in a widely heard recording?',
      options: ['M. S. Subbulakshmi', 'Juthika Roy', 'D. V. Paluskar', 'Lata Mangeshkar'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'What is a gharana in Indian classical music?',
      options: ['A concert hall', 'A type of raga', 'A kind of drum', 'A school or lineage of style'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'What is the unmetered opening section of a raga performance called?',
      options: ['Jhala', 'Bandish', 'Alap', 'Gat'],
      answer: 2,
      difficulty: 3,
      topic: 'Film music'),

  // ----------------------------------------------------------- film songs
  QuizQuestion(
      question: 'The song “Ek Pyar Ka Nagma Hai” is from which film?',
      options: ['Shor', 'Roti Kapda Aur Makaan', 'Bobby', 'Mera Naam Joker'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'The song “Yeh Dosti” comes from which film?',
      options: ['Zanjeer', 'Don', 'Deewar', 'Sholay'],
      answer: 3,
      difficulty: 1,
      topic: 'Film music'),
  QuizQuestion(
      question: 'The song “Pyar Hua Ikrar Hua” is from which Raj Kapoor film?',
      options: ['Sangam', 'Awara', 'Shree 420', 'Barsaat'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'In which film does the song “Ajeeb Dastan Hai Yeh” appear?',
      options: ['Dil Apna Aur Preet Parai', 'Sangam', 'Woh Kaun Thi', 'Anpadh'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'The song “Lag Ja Gale” is from which film?',
      options: ['Anpadh', 'Adalat', 'Mera Saaya', 'Woh Kaun Thi'],
      answer: 3,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'The qawwali-style song “Parda Hai Parda” is from which film?',
      options: ['Suhaag', 'Naseeb', 'Amar Akbar Anthony', 'Dharam Veer'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Which film features the song “Chalte Chalte Mere Yeh Geet”?',
      options: ['Pakeezah', 'Mere Huzoor', 'Mehboob Ki Mehndi', 'Chalte Chalte'],
      answer: 0,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'All India Radio’s long-running Hindi film song request programme was known by which name?',
      options: ['Sangeet Sarita', 'Jaimala', 'Chhayageet', 'Vividh Bharati’s Binaca Geetmala'],
      answer: 3,
      difficulty: 3,
      topic: 'Film music'),
  QuizQuestion(
      question: 'Who was the long-time presenter of the radio countdown show Binaca Geetmala?',
      options: ['Devki Nandan Pandey', 'Sushil Javeri', 'Ameen Sayani', 'Harish Bhimani'],
      answer: 2,
      difficulty: 2,
      topic: 'Film music'),
];
