/// Culture, religion, language, schooling and everyday-India questions.
///
/// Religion here is treated the way a textbook treats it: which text belongs
/// to which tradition, when a festival falls, what a term means. Nothing asks
/// the player to prefer one faith, and nothing touches a matter of belief.
library;

import 'quiz_question.dart';

const List<QuizQuestion> cultureQuestions = [
  // ------------------------------------------------------------- festivals
  QuizQuestion(question: 'Diwali is the festival of what?', options: ['Harvest', 'Rain', 'Colours', 'Lights'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Holi is the festival of what?', options: ['Colours', 'Boats', 'Kites', 'Lights'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which festival is celebrated with kite flying in Gujarat in January?', options: ['Janmashtami', 'Rath Yatra', 'Navratri', 'Makar Sankranti'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Onam is the harvest festival of which state?', options: ['Kerala', 'Karnataka', 'Andhra Pradesh', 'Tamil Nadu'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Pongal is celebrated chiefly in which state?', options: ['Odisha', 'Assam', 'Kerala', 'Tamil Nadu'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Bihu is the festival of which state?', options: ['Assam', 'Manipur', 'Tripura', 'West Bengal'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Baisakhi is celebrated chiefly in which state?', options: ['Himachal Pradesh', 'Rajasthan', 'Haryana', 'Punjab'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'The Rath Yatra chariot festival is held at which city?', options: ['Puri', 'Dwarka', 'Mathura', 'Varanasi'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which festival marks the bond between brothers and sisters?', options: ['Teej', 'Lohri', 'Karva Chauth', 'Raksha Bandhan'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Ganesh Chaturthi is celebrated with greatest scale in which state?', options: ['Maharashtra', 'Karnataka', 'Goa', 'Gujarat'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Durga Puja is celebrated with greatest scale in which state?', options: ['Bihar', 'Jharkhand', 'Odisha', 'West Bengal'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which festival marks the end of the month of Ramadan?', options: ['Eid al-Fitr', 'Muharram', 'Shab-e-Barat', 'Eid al-Adha'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Guru Nanak Jayanti is also known by which name?', options: ['Baisakhi', 'Hola Mohalla', 'Lohri', 'Gurpurab'], answer: 3, difficulty: 2, topic: 'Culture'),

  // --------------------------------------------------------- texts & faiths
  QuizQuestion(question: 'How many Vedas are there?', options: ['2', '3', '4', '6'], answer: 2, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which is the oldest of the four Vedas?', options: ['Rigveda', 'Yajurveda', 'Atharvaveda', 'Samaveda'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Who is traditionally credited with composing the Ramayana?', options: ['Kalidasa', 'Tulsidas', 'Vyasa', 'Valmiki'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Who is traditionally credited with composing the Mahabharata?', options: ['Vyasa', 'Kalidasa', 'Bhasa', 'Valmiki'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Who wrote the Ramcharitmanas in Awadhi?', options: ['Tulsidas', 'Surdas', 'Kabir', 'Valmiki'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The Bhagavad Gita forms part of which epic?', options: ['Rigveda', 'Puranas', 'Ramayana', 'Mahabharata'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'In the Bhagavad Gita, who speaks to Arjuna?', options: ['Krishna', 'Yudhishthira', 'Vyasa', 'Bhishma'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'The Guru Granth Sahib is the holy book of which faith?', options: ['Buddhism', 'Zoroastrianism', 'Jainism', 'Sikhism'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Mahavira is associated with which religion?', options: ['Jainism', 'Sikhism', 'Zoroastrianism', 'Buddhism'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'At which place was Gautama Buddha born?', options: ['Kushinagar', 'Bodh Gaya', 'Sarnath', 'Lumbini'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'At which place did Gautama Buddha attain enlightenment?', options: ['Bodh Gaya', 'Sarnath', 'Rajgir', 'Lumbini'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Where did the Buddha give his first sermon?', options: ['Lumbini', 'Vaishali', 'Bodh Gaya', 'Sarnath'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In which city is the Golden Temple?', options: ['Amritsar', 'Ludhiana', 'Patiala', 'Chandigarh'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'The Meenakshi Temple is in which city?', options: ['Kanchipuram', 'Tiruchirappalli', 'Thanjavur', 'Madurai'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The Sun Temple at Konark is in which state?', options: ['Odisha', 'Bihar', 'Jharkhand', 'West Bengal'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The Ajanta and Ellora caves are in which state?', options: ['Karnataka', 'Gujarat', 'Madhya Pradesh', 'Maharashtra'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The Char Dham pilgrimage in Uttarakhand includes all EXCEPT which?', options: ['Badrinath', 'Kedarnath', 'Gangotri', 'Vaishno Devi'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'The Kumbh Mela is held at four places including Haridwar, Ujjain, Nashik and which other?', options: ['Prayagraj', 'Mathura', 'Ayodhya', 'Varanasi'], answer: 0, difficulty: 2, topic: 'Culture'),

  // ------------------------------------------------------ language & arts
  QuizQuestion(question: 'Which language is written in the Devanagari script?', options: ['Hindi', 'Telugu', 'Bengali', 'Tamil'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'How many languages are listed in the Eighth Schedule of the Constitution?', options: ['14', '18', '22', '28'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which classical dance form comes from Kerala?', options: ['Kuchipudi', 'Manipuri', 'Odissi', 'Kathakali'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which classical dance form comes from Tamil Nadu?', options: ['Bharatanatyam', 'Kathak', 'Odissi', 'Mohiniyattam'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which classical dance form is associated with north India and Mughal courts?', options: ['Kathakali', 'Sattriya', 'Kuchipudi', 'Kathak'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which classical dance form comes from Odisha?', options: ['Odissi', 'Manipuri', 'Kuchipudi', 'Mohiniyattam'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Madhubani painting comes from which state?', options: ['West Bengal', 'Jharkhand', 'Odisha', 'Bihar'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Warli painting comes from which state?', options: ['Maharashtra', 'Rajasthan', 'Goa', 'Gujarat'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which poet wrote the Sanskrit play Abhijnanashakuntalam?', options: ['Bhavabhuti', 'Sudraka', 'Bhasa', 'Kalidasa'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which Indian poet won the Nobel Prize for Gitanjali?', options: ['Rabindranath Tagore', 'Muhammad Iqbal', 'Subramania Bharati', 'Sarojini Naidu'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Sarojini Naidu was known by which title?', options: ['Lady of the Lamp', 'Iron Lady', 'Mother of the Nation', 'Nightingale of India'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which Hindi writer is best known for the novel Godaan?', options: ['Premchand', 'Nirala', 'Mahadevi Varma', 'Jaishankar Prasad'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which Urdu poet wrote "Sare Jahan Se Achha"?', options: ['Faiz Ahmad Faiz', 'Josh Malihabadi', 'Mirza Ghalib', 'Muhammad Iqbal'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which Urdu poet of Delhi is famous for his ghazals and letters?', options: ['Mirza Ghalib', 'Zauq', 'Dagh Dehlvi', 'Mir Taqi Mir'], answer: 0, difficulty: 2, topic: 'Culture'),

  // --------------------------------------------------- teaching and schools
  QuizQuestion(question: 'On which date is Teachers’ Day celebrated in India?', options: ['14 November', '2 October', '26 January', '5 September'], answer: 3, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'Teachers’ Day in India marks the birthday of whom?', options: ['S. Radhakrishnan', 'Rabindranath Tagore', 'Mahatma Gandhi', 'Jawaharlal Nehru'], answer: 0, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'Children’s Day is celebrated in India on which date?', options: ['20 November', '1 June', '5 September', '14 November'], answer: 3, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'Children’s Day in India marks the birthday of whom?', options: ['Jawaharlal Nehru', 'Indira Gandhi', 'Rajendra Prasad', 'Mahatma Gandhi'], answer: 0, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'What does CBSE stand for?', options: ['Combined Board of Secondary Education', 'Council for Basic School Education', 'Central Board of School Education', 'Central Board of Secondary Education'], answer: 3, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'What does NCERT stand for?', options: ['National Council of Educational Research and Training', 'National Committee for Education Reform and Teaching', 'National Curriculum and Education Research Trust', 'National Centre for Education and Research Training'], answer: 0, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'What does UGC stand for?', options: ['Union Graduate Council', 'Universal Grading Committee', 'University General Council', 'University Grants Commission'], answer: 3, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'What does IIT stand for?', options: ['Indian Institute of Technology', 'Indian Institute of Training', 'International Institute of Technology', 'Institute of Indian Technology'], answer: 0, difficulty: 1, topic: 'Schools'),
  QuizQuestion(question: 'Which was the first IIT, established in 1951?', options: ['IIT Madras', 'IIT Delhi', 'IIT Bombay', 'IIT Kharagpur'], answer: 3, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'The Right to Education covers children of which age group?', options: ['6 to 14 years', '5 to 16 years', '6 to 18 years', '3 to 10 years'], answer: 0, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'Which constitutional amendment made education a fundamental right?', options: ['101st', '42nd', '73rd', '86th'], answer: 3, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'The midday meal scheme in schools is intended chiefly to do what?', options: ['Improve attendance and nutrition', 'Fund school buildings', 'Provide uniforms', 'Reduce teacher workload'], answer: 0, difficulty: 2, topic: 'Schools'),
  QuizQuestion(question: 'National Education Day in India is observed on 11 November, marking whose birthday?', options: ['Jawaharlal Nehru', 'Ambedkar', 'S. Radhakrishnan', 'Maulana Abul Kalam Azad'], answer: 3, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'Which Indian university is among the oldest modern universities, founded in 1857?', options: ['University of Calcutta', 'Banaras Hindu University', 'Aligarh Muslim University', 'Delhi University'], answer: 0, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'Who founded Banaras Hindu University?', options: ['Sir Syed Ahmed Khan', 'Annie Besant', 'Gopal Krishna Gokhale', 'Madan Mohan Malaviya'], answer: 3, difficulty: 3, topic: 'Schools'),
  QuizQuestion(question: 'Which day is observed as World Teachers’ Day internationally?', options: ['5 October', '14 November', '1 May', '5 September'], answer: 0, difficulty: 3, topic: 'Schools'),
];
