/// Questions taken from televised quiz rounds, by way of a public archive
/// of them that NJ pointed me at.
///
/// Facts again, not copies: what is taken is the subject and the answer,
/// while the wording, the options and every distractor are written here. The
/// archive's own options are often three, or arrange-these-four, which this
/// game cannot use anyway.
///
/// Most of what was on those pages is not here, and the reason matters more
/// than the count. A televised quiz leans hard on current affairs -- this
/// year's cricketers, a minister appointed last spring, an actor's social
/// media handle, a film from 2009. Those questions ask for things learnt
/// recently, and recent learning is the first faculty vascular dementia
/// takes. He would miss every one of them, not because he does not know but
/// because that is precisely the part that has gone. A quiz he cannot win is
/// the opposite of what this app is for.
///
/// So the filter was: would this question have been as answerable twenty
/// years ago as today? Thirty-nine of about seventy survived it.
///
/// Four more were dropped because I could not check them. The archive runs
/// past my own knowledge, and two of its questions concerned events I have
/// no way to verify; one it flagged itself as having no correct option among
/// those printed. Shipping an unverifiable answer to a man who will believe
/// it is worse than shipping nothing.
///
/// Answer positions cycle 0, 1, 2, 3, as in the other banks.
library;

import 'quiz_question.dart';

const List<QuizQuestion> kbcArchiveQuestions = [
  QuizQuestion(question: 'In 1906 the Prince of Wales laid the foundation stone of which Kolkata monument?', options: ['The Victoria Memorial', 'The Howrah Bridge', 'Fort William', 'The Indian Museum'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which pigment gives human skin and hair their colour?', options: ['Haemoglobin', 'Melanin', 'Chlorophyll', 'Keratin'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Bihu and Bagurumba are traditional dances of which state?', options: ['Odisha', 'Manipur', 'Assam', 'Bihar'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What does a hygrometer measure?', options: ['Air pressure', 'Rainfall', 'Wind speed', 'Humidity'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'The tiger is the state animal of many Indian states. Of which is it not?', options: ['Punjab', 'Madhya Pradesh', 'Maharashtra', 'Bihar'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which of the seven wonders of the ancient world is still standing?', options: ['The Colossus of Rhodes', 'The Great Pyramid of Giza', 'The Hanging Gardens', 'The Lighthouse of Alexandria'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'In the motoring term SUV, what does the U stand for?', options: ['Urban', 'Universal', 'Utility', 'Upright'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Mahamana Express is named after which figure?', options: ['Lala Lajpat Rai', 'Gopal Krishna Gokhale', 'Bal Gangadhar Tilak', 'Madan Mohan Malaviya'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Indian Institute of Sugarcane Research is in which city?', options: ['Lucknow', 'Kanpur', 'Pune', 'Coimbatore'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Ima Market, run entirely by women, is in which state?', options: ['Meghalaya', 'Manipur', 'Kerala', 'Goa'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Krishnaraja Sagar dam is in which state?', options: ['Tamil Nadu', 'Andhra Pradesh', 'Karnataka', 'Maharashtra'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Baralacha La, Zoji La and Nathu La are all what?', options: ['Lakes', 'Glaciers', 'Peaks', 'Mountain passes'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Netaji Janmasthan Museum, in the house where Subhas Chandra Bose was born, is in which city?', options: ['Cuttack', 'Kolkata', 'Patna', 'Puri'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which of these captained India in one-day cricket earliest?', options: ['Sourav Ganguly', 'Mohammad Azharuddin', 'M.S. Dhoni', 'Virat Kohli'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'What is thirty written as a Roman numeral?', options: ['XL', 'LXX', 'XXX', 'XIII'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Java, Visual Basic and Logo are all what?', options: ['Board games', 'Card games', 'Typefaces', 'Computer languages'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which Olympic athletics event is named after a tool?', options: ['The hammer', 'The javelin', 'The discus', 'The shot put'], answer: 0, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Which part of the human body has exactly four chambers?', options: ['The brain', 'The heart', 'The stomach', 'The liver'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which former air hostess was awarded the Ashok Chakra?', options: ['Kalpana Chawla', 'Sarla Thakral', 'Neerja Bhanot', 'Harita Kaur Deol'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The calf of which animal can put on about ninety kilograms a day?', options: ['The elephant', 'The giraffe', 'The hippopotamus', 'The blue whale'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Gopalkrishna Gandhi is a grandson of Mahatma Gandhi and of which other leader?', options: ['C. Rajagopalachari', 'Sardar Patel', 'Rajendra Prasad', 'Lal Bahadur Shastri'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which of these became President of India earliest?', options: ['Pratibha Patil', 'A.P.J. Abdul Kalam', 'Pranab Mukherjee', 'Ram Nath Kovind'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'How many fifty millilitre pouches can be filled from five litres of oil?', options: ['50', '200', '100', '25'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which of these was not one of the older cities of Delhi?', options: ['Shahjahanabad', 'Firozabad', 'Tughlaqabad', 'Akbarabad'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'A lion\'s age can be estimated from the colour of which part of it?', options: ['Its nose', 'Its mane', 'Its tail', 'Its paws'], answer: 0, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'In an Indian family, who is your jamai?', options: ['Your sister\'s husband', 'Your daughter\'s husband', 'Your wife\'s brother', 'Your son\'s wife'], answer: 1, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Expectant mothers are advised to take enough of which nutrient for the baby\'s brain?', options: ['Calcium', 'Vitamin C', 'Iodine', 'Potassium'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which hill station takes its name from the five hills around it?', options: ['Mahabaleshwar', 'Matheran', 'Lonavala', 'Panchgani'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Who was the first Governor-General of Pakistan?', options: ['Muhammad Ali Jinnah', 'Liaquat Ali Khan', 'Iskander Mirza', 'Khawaja Nazimuddin'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Which leader revived the public celebration of Ganesh Chaturthi as a national gathering?', options: ['Gopal Krishna Gokhale', 'Bal Gangadhar Tilak', 'Dadabhai Naoroji', 'Vinayak Savarkar'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which of these is one of the languages listed in the Eighth Schedule of the Constitution?', options: ['Bhojpuri', 'Tulu', 'Dogri', 'Magahi'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Doctrine of Lapse was among the causes of which uprising?', options: ['The Quit India movement', 'The Champaran satyagraha', 'The Santhal rebellion', 'The Revolt of 1857'], answer: 3, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Which British car marque is owned by an Indian company?', options: ['Land Rover', 'Rolls-Royce', 'Bentley', 'Aston Martin'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Hindi expression means to accept defeat?', options: ['Haath bantana', 'Ghutne tekna', 'Sir uthana', 'Kadam badhana'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What is the word for bringing a file from the Internet onto your own computer?', options: ['Uploading', 'Formatting', 'Downloading', 'Refreshing'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In chess, which single piece moves as a rook and a bishop together?', options: ['The king', 'The knight', 'The pawn', 'The queen'], answer: 3, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which of these Indian states has no sea coast?', options: ['Telangana', 'Odisha', 'Gujarat', 'Kerala'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'In the Ramayana, which son of Vishwakarma built the bridge to Lanka?', options: ['Nila', 'Nala', 'Angada', 'Jambavan'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which of these metals is silvery white in its pure form?', options: ['Copper', 'Gold', 'Tin', 'Bronze'], answer: 2, difficulty: 2, topic: 'Science'),
];
