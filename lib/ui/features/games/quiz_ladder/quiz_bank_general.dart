/// General awareness and civics questions for Quiz Ladder.
///
/// Civics here is structural and factual — how Parliament, the Constitution
/// and the institutions actually work. Nothing turns on who currently holds
/// an office, which would date the bank within months, and nothing asks the
/// player to take a political side.
library;

import 'quiz_question.dart';

const List<QuizQuestion> generalQuestions = [
  // ------------------------------------------------------- national symbols
  QuizQuestion(question: 'What is the national bird of India?', options: ['Parrot', 'Eagle', 'Sparrow', 'Peacock'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national animal of India?', options: ['Tiger', 'Leopard', 'Lion', 'Elephant'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national flower of India?', options: ['Jasmine', 'Rose', 'Marigold', 'Lotus'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national fruit of India?', options: ['Mango', 'Apple', 'Guava', 'Banana'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the national tree of India?', options: ['Peepal', 'Mango', 'Neem', 'Banyan'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the national river of India?', options: ['Ganga', 'Narmada', 'Godavari', 'Yamuna'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the national aquatic animal of India?', options: ['Blue whale', 'Olive ridley turtle', 'Gharial', 'Gangetic dolphin'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Who wrote the national anthem of India?', options: ['Rabindranath Tagore', 'Sarojini Naidu', 'Subramania Bharati', 'Bankim Chandra Chatterjee'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the national song of India?', options: ['Sare Jahan Se Achha', 'Ae Mere Watan Ke Logon', 'Jana Gana Mana', 'Vande Mataram'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who wrote Vande Mataram?', options: ['Bankim Chandra Chatterjee', 'Sarat Chandra', 'Michael Madhusudan Dutt', 'Rabindranath Tagore'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How long does it take to sing the full national anthem?', options: ['About 90 seconds', 'About two minutes', 'About 30 seconds', 'About 52 seconds'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What appears at the centre of the Indian flag?', options: ['Chakra with 24 spokes', 'Chakra with 12 spokes', 'Lotus', 'Lion capital'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The national emblem of India is taken from which monument?', options: ['Qutub Minar', 'Konark temple', 'Sanchi Stupa', 'Lion Capital of Ashoka at Sarnath'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What words appear below the national emblem of India?', options: ['Satyameva Jayate', 'Vande Mataram', 'Jai Hind', 'Dharmo Rakshati'], answer: 0, difficulty: 2, topic: 'General'),

  // ------------------------------------------------------------ constitution
  QuizQuestion(question: 'Who is regarded as the chief architect of the Indian Constitution?', options: ['Rajendra Prasad', 'Sardar Patel', 'Jawaharlal Nehru', 'B. R. Ambedkar'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Constitution of India was adopted on which date?', options: ['26 November 1949', '26 January 1950', '2 October 1950', '15 August 1947'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Constitution of India came into force on which date?', options: ['1 January 1950', '15 August 1947', '26 November 1949', '26 January 1950'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Republic Day in India is celebrated on which date?', options: ['26 January', '2 October', '14 November', '15 August'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Independence Day in India is celebrated on which date?', options: ['2 October', '26 November', '26 January', '15 August'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which day is celebrated as Constitution Day in India?', options: ['26 November', '15 August', '14 April', '26 January'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Preamble describes India as all of these EXCEPT which?', options: ['Secular', 'Sovereign', 'Socialist', 'Monarchical'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The idea of Fundamental Rights in the Indian Constitution was drawn chiefly from which country?', options: ['United States', 'Ireland', 'Canada', 'Britain'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Directive Principles of State Policy were drawn chiefly from which country?', options: ['United States', 'Australia', 'France', 'Ireland'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which article of the Constitution abolished untouchability?', options: ['Article 14', 'Article 17', 'Article 21', 'Article 32'], answer: 1, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which article guarantees the right to equality before the law?', options: ['Article 14', 'Article 19', 'Article 21', 'Article 25'], answer: 0, difficulty: 3, topic: 'General'),

  // --------------------------------------------------------------- parliament
  QuizQuestion(question: 'Which is the upper house of the Indian Parliament?', options: ['Rajya Sabha', 'Vidhan Sabha', 'Vidhan Parishad', 'Lok Sabha'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the lower house of the Indian Parliament?', options: ['Vidhan Parishad', 'Legislative Council', 'Rajya Sabha', 'Lok Sabha'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'How many seats are there in the Lok Sabha?', options: ['250', '400', '543', '600'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the normal term of the Lok Sabha?', options: ['4 years', '5 years', '6 years', '7 years'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the term of a Rajya Sabha member?', options: ['6 years', 'Life', '4 years', '5 years'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who presides over the Rajya Sabha?', options: ['The Speaker', 'The Prime Minister', 'The President', 'The Vice-President'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who presides over the Lok Sabha?', options: ['The Speaker', 'The President', 'The Leader of the House', 'The Vice-President'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Who formally appoints the Prime Minister of India?', options: ['The Vice-President', 'The Speaker', 'The Chief Justice', 'The President'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who is the Supreme Commander of the Indian Armed Forces?', options: ['The President', 'The Defence Minister', 'The Chief of Army Staff', 'The Prime Minister'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the minimum age to vote in India?', options: ['16', '18', '21', '25'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the minimum age to become a member of the Lok Sabha?', options: ['21', '25', '30', '35'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the minimum age to become President of India?', options: ['25', '30', '35', '40'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'A money bill can be introduced only in which house?', options: ['Either house', 'A joint sitting', 'Rajya Sabha', 'Lok Sabha'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'How many states does India have?', options: ['25', '28', '29', '31'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which body conducts elections in India?', options: ['The Election Commission', 'Parliament', 'The Home Ministry', 'The Supreme Court'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Who appoints the Chief Justice of India?', options: ['Parliament', 'The Law Minister', 'The Prime Minister', 'The President'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Where does the Supreme Court of India sit?', options: ['New Delhi', 'Allahabad', 'Kolkata', 'Mumbai'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the oldest High Court in India?', options: ['Bombay', 'Madras', 'Delhi', 'Calcutta'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The head of a state government in India is the what?', options: ['Chief Minister', 'Chief Secretary', 'Speaker', 'Governor'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Who appoints the Governor of a state?', options: ['The Prime Minister', 'The state assembly', 'The Chief Minister', 'The President'], answer: 3, difficulty: 2, topic: 'General'),

  // ------------------------------------------------------- money & economy
  QuizQuestion(question: 'Where is the headquarters of the Reserve Bank of India?', options: ['Mumbai', 'Kolkata', 'Chennai', 'New Delhi'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In which year was the Reserve Bank of India established?', options: ['1925', '1935', '1947', '1955'], answer: 1, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What does UPI stand for?', options: ['Universal Payment Index', 'Unique Payment Identifier', 'United Payment Interface', 'Unified Payments Interface'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What does GST stand for?', options: ['Goods and Services Tax', 'Gross State Tax', 'Government Service Tax', 'General Sales Tax'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What does PAN stand for in Indian tax matters?', options: ['Public Account Number', 'Primary Account Name', 'Personal Account Number', 'Permanent Account Number'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which currency is used in Japan?', options: ['Yen', 'Won', 'Ringgit', 'Yuan'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which currency is used in the United Kingdom?', options: ['Dollar', 'Franc', 'Euro', 'Pound sterling'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which currency is used in Bangladesh?', options: ['Taka', 'Rupiah', 'Riyal', 'Rupee'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Whose signature appears on most Indian currency notes?', options: ['The President', 'The Prime Minister', 'The Finance Minister', 'The RBI Governor'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which country did India overtake in 2023 to become the most populous?', options: ['China', 'United States', 'Pakistan', 'Indonesia'], answer: 0, difficulty: 2, topic: 'General'),

  // ------------------------------------------------------- sport & awards
  QuizQuestion(question: 'What is the national sport association most linked with the Dhyan Chand name?', options: ['Football', 'Badminton', 'Cricket', 'Hockey'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'How many players are there in a cricket team on the field?', options: ['9', '10', '11', '12'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In which year did India first win the Cricket World Cup?', options: ['1975', '1979', '1983', '1987'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Indian cricketer is known as the Little Master?', options: ['Sunil Gavaskar', 'Rahul Dravid', 'Virender Sehwag', 'Kapil Dev'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who captained India to its first Cricket World Cup win?', options: ['Mohinder Amarnath', 'Bishan Bedi', 'Sunil Gavaskar', 'Kapil Dev'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How many players are in a hockey team on the field?', options: ['9', '10', '11', '12'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which is India’s highest civilian award?', options: ['Bharat Ratna', 'Padma Bhushan', 'Param Vir Chakra', 'Padma Vibhushan'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is India’s highest military award for gallantry?', options: ['Maha Vir Chakra', 'Ashoka Chakra', 'Vir Chakra', 'Param Vir Chakra'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which award is India’s highest honour in literature?', options: ['Jnanpith Award', 'Padma Shri', 'Bharat Ratna', 'Sahitya Akademi Award'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Who was the first Indian to win a Nobel Prize?', options: ['Mother Teresa', 'Amartya Sen', 'C. V. Raman', 'Rabindranath Tagore'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'For which subject did C. V. Raman win the Nobel Prize?', options: ['Physics', 'Medicine', 'Peace', 'Chemistry'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Indian economist won the Nobel Prize in 1998?', options: ['Abhijit Banerjee', 'Manmohan Singh', 'Raghuram Rajan', 'Amartya Sen'], answer: 3, difficulty: 3, topic: 'General'),

  // --------------------------------------------------------------- the world
  QuizQuestion(question: 'Where is the headquarters of the United Nations?', options: ['New York', 'Paris', 'Vienna', 'Geneva'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'How many permanent members does the UN Security Council have?', options: ['3', '5', '7', '10'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Where is the headquarters of the World Health Organization?', options: ['Rome', 'Brussels', 'New York', 'Geneva'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which city hosted the G20 Leaders’ Summit held in India in 2023?', options: ['New Delhi', 'Bengaluru', 'Hyderabad', 'Mumbai'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How often are the summer Olympic Games normally held?', options: ['Every two years', 'Every three years', 'Every four years', 'Every five years'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'How many rings are there on the Olympic flag?', options: ['4', '5', '6', '7'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What does WWW stand for?', options: ['World Web Work', 'Wide World Web', 'Web Wide World', 'World Wide Web'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What does CPU stand for?', options: ['Central Processing Unit', 'Computer Primary Unit', 'Central Program Unit', 'Core Processing Utility'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the longest wall in the world?', options: ['Berlin Wall', 'Wall of Babylon', 'Hadrian’s Wall', 'The Great Wall of China'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Statue of Unity, the world’s tallest statue, depicts whom?', options: ['Sardar Patel', 'B. R. Ambedkar', 'Shivaji', 'Mahatma Gandhi'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In which state is the Statue of Unity?', options: ['Rajasthan', 'Madhya Pradesh', 'Maharashtra', 'Gujarat'], answer: 3, difficulty: 2, topic: 'General'),
  // ======================= second batch =======================
  QuizQuestion(question: 'How many Union Territories does India have?', options: ['Six', 'Seven', 'Eight', 'Nine'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How many digits are there in an Indian postal PIN code?', options: ['Five', 'Six', 'Seven', 'Eight'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'How many digits are there in an Aadhaar number?', options: ['Ten', 'Eleven', 'Twelve', 'Sixteen'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'How often is the Census of India normally conducted?', options: ['Every five years', 'Every ten years', 'Every fifteen years', 'Every twenty years'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which amendment to the Constitution added the Fundamental Duties?', options: ['Forty-second', 'Forty-fourth', 'Fifty-second', 'Seventy-third'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which amendment gave constitutional status to the panchayats?', options: ['Eighty-sixth', 'Forty-second', 'Sixty-first', 'Seventy-third'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What is the official residence of the President of India called?', options: ['Rashtrapati Bhavan', 'Raj Bhavan', 'Vigyan Bhavan', 'Teen Murti Bhavan'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which two architects are credited with designing New Delhi?', options: ['Corbusier and Doshi', 'Wren and Nash', 'Kahn and Correa', 'Lutyens and Baker'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which body regulates the securities market in India?', options: ['SEBI', 'IRDAI', 'NABARD', 'RBI'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which is the oldest stock exchange in India?', options: ['Calcutta Stock Exchange', 'Madras Stock Exchange', 'National Stock Exchange', 'Bombay Stock Exchange'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What does UPSC stand for?', options: ['Union Public Service Commission', 'United Provinces Service Council', 'Union Policy and Service Commission', 'Universal Public Selection Council'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which award is given to outstanding sportspersons in India?', options: ['Dronacharya Award', 'Dhyan Chand Award', 'Vishisht Seva Medal', 'Arjuna Award'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Indian award is given to outstanding sports coaches?', options: ['Dronacharya Award', 'Khel Ratna', 'Padma Shri', 'Arjuna Award'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Indian won the Nobel Peace Prize in 2014 for work against child labour?', options: ['Amartya Sen', 'Abhijit Banerjee', 'Venkatraman Ramakrishnan', 'Kailash Satyarthi'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which missionary who worked in Kolkata won the Nobel Peace Prize in 1979?', options: ['Mother Teresa', 'Sister Nivedita', 'Annie Besant', 'Pandita Ramabai'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'International Yoga Day is observed on which date?', options: ['5 June', '21 May', '11 July', '21 June'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'World Environment Day is observed on which date?', options: ['5 June', '21 March', '16 September', '22 April'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Hindi Diwas is observed in India on which date?', options: ['14 November', '26 November', '1 September', '14 September'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Where is the headquarters of SAARC?', options: ['Kathmandu', 'Colombo', 'Dhaka', 'New Delhi'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What does ATM stand for in banking?', options: ['Automatic Transfer Machine', 'Account Transaction Machine', 'Authorised Teller Module', 'Automated Teller Machine'], answer: 3, difficulty: 1, topic: 'General'),
];
