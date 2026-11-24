/// History questions for KBC India, weighted towards India.
///
/// Dates, dynasties, the freedom struggle and monuments. Factual throughout;
/// where a period is contested by historians, the question sticks to what is
/// not in dispute.
library;

import 'quiz_question.dart';

const List<QuizQuestion> historyQuestions = [
  // --------------------------------------------------------- ancient India
  QuizQuestion(question: 'Who founded the Maurya Empire?', options: ['Ashoka', 'Bindusara', 'Chandragupta Maurya', 'Samudragupta'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Emperor Ashoka belonged to which dynasty?', options: ['Chola', 'Mughal', 'Gupta', 'Maurya'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'After which battle did Ashoka turn to Buddhism?', options: ['Battle of Kalinga', 'Battle of Hydaspes', 'Battle of Talikota', 'Battle of Panipat'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who wrote the Arthashastra?', options: ['Panini', 'Banabhatta', 'Kalidasa', 'Chanakya'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Gupta period is often called India’s what?', options: ['Age of Discovery', 'Dark Age', 'Golden Age', 'Iron Age'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which ancient university was in present-day Bihar?', options: ['Nalanda', 'Vallabhi', 'Odantapuri', 'Takshashila'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Indus Valley Civilisation is also known by which name?', options: ['Mauryan Civilisation', 'Dravidian Civilisation', 'Vedic Civilisation', 'Harappan Civilisation'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Mohenjo-daro, a major Indus Valley site, is in present-day which country?', options: ['Iran', 'India', 'Pakistan', 'Afghanistan'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which metal was NOT known to the Indus Valley people?', options: ['Copper', 'Bronze', 'Iron', 'Gold'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which script was used in Ashoka’s edicts?', options: ['Brahmi', 'Kharosthi only', 'Grantha', 'Devanagari'], answer: 0, difficulty: 3, topic: 'History'),

  // ------------------------------------------------------- medieval India
  QuizQuestion(question: 'Who built the Taj Mahal?', options: ['Aurangzeb', 'Akbar', 'Jahangir', 'Shah Jahan'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'In whose memory was the Taj Mahal built?', options: ['Mumtaz Mahal', 'Jodha Bai', 'Roshanara', 'Nur Jahan'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who founded the Mughal Empire in India?', options: ['Humayun', 'Shah Jahan', 'Akbar', 'Babur'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The First Battle of Panipat was fought in which year?', options: ['1426', '1526', '1556', '1761'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which Mughal emperor built Fatehpur Sikri?', options: ['Aurangzeb', 'Babur', 'Akbar', 'Jahangir'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who was the Maratha ruler crowned at Raigad in 1674?', options: ['Shivaji', 'Sambhaji', 'Baji Rao I', 'Shahu'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Which Mughal emperor was Shivaji’s chief adversary?', options: ['Akbar', 'Jahangir', 'Shah Jahan', 'Aurangzeb'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who built the Qutub Minar’s first storey in Delhi?', options: ['Alauddin Khilji', 'Iltutmish', 'Qutb-ud-din Aibak', 'Balban'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who was the first woman ruler of Delhi?', options: ['Razia Sultana', 'Chand Bibi', 'Nur Jahan', 'Rani Durgavati'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Vijayanagara Empire had its capital at which site?', options: ['Badami', 'Warangal', 'Bijapur', 'Hampi'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who was known as the Tiger of Mysore?', options: ['Chikka Devaraja', 'Hyder Ali', 'Tipu Sultan', 'Krishnaraja Wodeyar'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which Sikh Guru founded the Khalsa in 1699?', options: ['Guru Nanak', 'Guru Arjan', 'Guru Gobind Singh', 'Guru Tegh Bahadur'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who founded Sikhism?', options: ['Guru Nanak', 'Guru Angad', 'Guru Gobind Singh', 'Guru Ram Das'], answer: 0, difficulty: 1, topic: 'History'),

  // ---------------------------------------------------- colonial & struggle
  QuizQuestion(question: 'In which year was the Battle of Plassey fought?', options: ['1707', '1757', '1764', '1857'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The first war of Indian independence took place in which year?', options: ['1757', '1857', '1885', '1905'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'In which year was the Indian National Congress founded?', options: ['1857', '1885', '1905', '1920'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year did the Jallianwala Bagh massacre take place?', options: ['1909', '1919', '1929', '1942'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Dandi March, or Salt March, took place in which year?', options: ['1920', '1930', '1935', '1940'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year was the Quit India Movement launched?', options: ['1930', '1935', '1942', '1945'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In which year did India become independent?', options: ['1945', '1947', '1948', '1950'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'The partition of Bengal was carried out in which year?', options: ['1905', '1911', '1919', '1947'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who gave the slogan "Give me blood and I will give you freedom"?', options: ['Bal Gangadhar Tilak', 'Lala Lajpat Rai', 'Bhagat Singh', 'Subhas Chandra Bose'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who said "Swaraj is my birthright and I shall have it"?', options: ['Bal Gangadhar Tilak', 'Gokhale', 'Nehru', 'Gandhi'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who founded the Indian National Army, the Azad Hind Fauj?', options: ['Rash Behari Bose', 'Chandrashekhar Azad', 'Bhagat Singh', 'Subhas Chandra Bose'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which queen led the defence of Jhansi in 1857?', options: ['Rani Chennamma', 'Rani Durgavati', 'Rani Lakshmibai', 'Begum Hazrat Mahal'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was hanged along with Bhagat Singh in 1931?', options: ['Rajguru and Sukhdev', 'Batukeshwar Dutt and Rajguru', 'Ram Prasad Bismil and Roshan Singh', 'Chandrashekhar Azad and Ashfaqulla'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Gandhi’s first major satyagraha in India was at which place?', options: ['Kheda', 'Bardoli', 'Ahmedabad', 'Champaran'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who was the last Viceroy of India?', options: ['Lord Curzon', 'Lord Wavell', 'Lord Mountbatten', 'Lord Irwin'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which Viceroy ordered the partition of Bengal in 1905?', options: ['Lord Curzon', 'Lord Minto', 'Lord Ripon', 'Lord Dufferin'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who is remembered as the Frontier Gandhi?', options: ['Zakir Husain', 'Hakim Ajmal Khan', 'Abul Kalam Azad', 'Khan Abdul Ghaffar Khan'], answer: 3, difficulty: 3, topic: 'History'),

  // ------------------------------------------------------- independent India
  QuizQuestion(question: 'Who was the first Prime Minister of India?', options: ['Lal Bahadur Shastri', 'Sardar Patel', 'Jawaharlal Nehru', 'Rajendra Prasad'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the first President of India?', options: ['Rajendra Prasad', 'Zakir Husain', 'V. V. Giri', 'S. Radhakrishnan'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the first woman Prime Minister of India?', options: ['Vijaya Lakshmi Pandit', 'Sucheta Kripalani', 'Sarojini Naidu', 'Indira Gandhi'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the second Prime Minister of India?', options: ['Gulzarilal Nanda', 'Morarji Desai', 'Lal Bahadur Shastri', 'Indira Gandhi'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who gave the slogan "Jai Jawan Jai Kisan"?', options: ['Lal Bahadur Shastri', 'Indira Gandhi', 'Sardar Patel', 'Jawaharlal Nehru'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who is remembered as the Iron Man of India?', options: ['Subhas Chandra Bose', 'Bal Gangadhar Tilak', 'Bhagat Singh', 'Sardar Vallabhbhai Patel'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who was the first woman President of India?', options: ['Sarojini Naidu', 'Meira Kumar', 'Pratibha Patil', 'Indira Gandhi'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which Indian President was also a renowned space scientist?', options: ['A. P. J. Abdul Kalam', 'R. Venkataraman', 'K. R. Narayanan', 'Zakir Husain'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'The Green Revolution in India is chiefly associated with whom?', options: ['Norman Ernest', 'C. Subramaniam only', 'Verghese Kurien', 'M. S. Swaminathan'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The White Revolution, or Operation Flood, is associated with whom?', options: ['Vikram Sarabhai', 'M. S. Swaminathan', 'Verghese Kurien', 'Homi Bhabha'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Goa was liberated from Portuguese rule in which year?', options: ['1947', '1956', '1961', '1971'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which Indian state was formed in 2000 from Bihar?', options: ['Jharkhand', 'Uttarakhand', 'Telangana', 'Chhattisgarh'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which Indian state was formed in 2014?', options: ['Uttarakhand', 'Chhattisgarh', 'Jharkhand', 'Telangana'], answer: 3, difficulty: 2, topic: 'History'),

  // ---------------------------------------------------------------- world
  QuizQuestion(question: 'In which year did the Second World War end?', options: ['1943', '1945', '1947', '1950'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'In which year did the First World War begin?', options: ['1912', '1914', '1916', '1918'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who was the first President of the United States?', options: ['John Adams', 'Abraham Lincoln', 'George Washington', 'Thomas Jefferson'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Who led South Africa’s struggle against apartheid and became its President?', options: ['Nelson Mandela', 'Thabo Mbeki', 'Steve Biko', 'Desmond Tutu'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'The French Revolution began in which year?', options: ['1776', '1789', '1799', '1804'], answer: 1, difficulty: 3, topic: 'History'),
];
