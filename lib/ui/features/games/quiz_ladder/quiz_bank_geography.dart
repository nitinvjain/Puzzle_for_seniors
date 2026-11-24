/// Geography questions for KBC India, weighted towards India.
///
/// Physical and settled political geography only. No "which state has the
/// most districts" or similar, because those change.
library;

import 'quiz_question.dart';

const List<QuizQuestion> geographyQuestions = [
  // ------------------------------------------------------- rivers and water
  QuizQuestion(question: 'Which is the longest river in India?', options: ['Ganga', 'Narmada', 'Yamuna', 'Godavari'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the longest river in peninsular India?', options: ['Mahanadi', 'Krishna', 'Godavari', 'Kaveri'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'On which river does the city of Varanasi stand?', options: ['Gomti', 'Son', 'Yamuna', 'Ganga'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'On which river does Delhi stand?', options: ['Sutlej', 'Chambal', 'Ganga', 'Yamuna'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which two rivers meet at Prayagraj?', options: ['Yamuna and Chambal', 'Ganga and Gomti', 'Ganga and Yamuna', 'Ganga and Son'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which river is known as the Sorrow of Bihar?', options: ['Kosi', 'Son', 'Ghaghara', 'Gandak'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which river flows through the Marble Rocks at Bhedaghat?', options: ['Narmada', 'Chambal', 'Betwa', 'Tapti'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest freshwater lake in India?', options: ['Loktak', 'Chilika', 'Wular', 'Dal'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Chilika Lake, India’s largest lagoon, is in which state?', options: ['West Bengal', 'Tamil Nadu', 'Andhra Pradesh', 'Odisha'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the longest river in the world?', options: ['Yangtze', 'Mississippi', 'Amazon', 'Nile'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which river flows through Egypt?', options: ['Zambezi', 'Congo', 'Nile', 'Niger'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest ocean in the world?', options: ['Pacific', 'Arctic', 'Atlantic', 'Indian'], answer: 0, difficulty: 1, topic: 'Geography'),

  // ---------------------------------------------------- mountains and desert
  QuizQuestion(question: 'Which is the highest mountain peak lying within India?', options: ['Kangchenjunga', 'Kamet', 'Saltoro Kangri', 'Nanda Devi'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the highest mountain in the world?', options: ['Lhotse', 'K2', 'Mount Everest', 'Kangchenjunga'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Thar Desert lies mainly in which state?', options: ['Haryana', 'Punjab', 'Gujarat', 'Rajasthan'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Western Ghats run roughly parallel to which coast?', options: ['The northern plains', 'The Himalayan foothills', 'The eastern coast', 'The western coast'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which range separates India from Tibet?', options: ['Aravalli', 'Vindhya', 'Himalaya', 'Satpura'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the oldest mountain range in India?', options: ['Aravalli', 'Satpura', 'Nilgiri', 'Himalaya'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'The Nilgiri Hills lie mainly in which state?', options: ['Tamil Nadu', 'Karnataka', 'Andhra Pradesh', 'Kerala'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest desert in the world?', options: ['Thar', 'Kalahari', 'Sahara', 'Gobi'], answer: 2, difficulty: 1, topic: 'Geography'),

  // ---------------------------------------------------------- states, cities
  QuizQuestion(question: 'What is the capital of Karnataka?', options: ['Hubballi', 'Mysuru', 'Mangaluru', 'Bengaluru'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Kerala?', options: ['Kozhikode', 'Thrissur', 'Kochi', 'Thiruvananthapuram'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Gujarat?', options: ['Ahmedabad', 'Surat', 'Gandhinagar', 'Vadodara'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Rajasthan?', options: ['Jaipur', 'Udaipur', 'Ajmer', 'Jodhpur'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Maharashtra?', options: ['Mumbai', 'Nashik', 'Pune', 'Nagpur'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Tamil Nadu?', options: ['Salem', 'Madurai', 'Chennai', 'Coimbatore'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of West Bengal?', options: ['Siliguri', 'Durgapur', 'Howrah', 'Kolkata'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Assam?', options: ['Silchar', 'Jorhat', 'Guwahati', 'Dispur'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Madhya Pradesh?', options: ['Jabalpur', 'Indore', 'Bhopal', 'Gwalior'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Uttar Pradesh?', options: ['Lucknow', 'Varanasi', 'Agra', 'Kanpur'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Punjab?', options: ['Chandigarh', 'Patiala', 'Amritsar', 'Ludhiana'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Odisha?', options: ['Rourkela', 'Cuttack', 'Bhubaneswar', 'Puri'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Telangana?', options: ['Nizamabad', 'Karimnagar', 'Warangal', 'Hyderabad'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Bihar?', options: ['Bhagalpur', 'Muzaffarpur', 'Gaya', 'Patna'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which state is called the Land of Five Rivers?', options: ['Uttarakhand', 'Haryana', 'Punjab', 'Himachal Pradesh'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest Indian state by area?', options: ['Rajasthan', 'Uttar Pradesh', 'Madhya Pradesh', 'Maharashtra'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the smallest Indian state by area?', options: ['Goa', 'Tripura', 'Nagaland', 'Sikkim'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state has the longest coastline?', options: ['Tamil Nadu', 'Andhra Pradesh', 'Gujarat', 'Maharashtra'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which place is the southernmost tip of mainland India?', options: ['Kochi', 'Puducherry', 'Rameswaram', 'Kanyakumari'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Chandigarh is the shared capital of which two states?', options: ['Punjab and Himachal Pradesh', 'Haryana and Delhi', 'Punjab and Rajasthan', 'Punjab and Haryana'], answer: 3, difficulty: 2, topic: 'Geography'),

  // ----------------------------------------------------------- city nicknames
  QuizQuestion(question: 'Which city is known as the Pink City?', options: ['Bikaner', 'Jodhpur', 'Jaipur', 'Udaipur'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Blue City?', options: ['Jodhpur', 'Jaisalmer', 'Bikaner', 'Jaipur'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Golden City of Rajasthan?', options: ['Jaisalmer', 'Ajmer', 'Kota', 'Alwar'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Lakes?', options: ['Srinagar', 'Bhopal', 'Udaipur', 'Nainital'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Garden City of India?', options: ['Mysuru', 'Chandigarh', 'Pune', 'Bengaluru'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Nawabs?', options: ['Bhopal', 'Rampur', 'Hyderabad', 'Lucknow'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Manchester of India?', options: ['Coimbatore', 'Surat', 'Ahmedabad', 'Kanpur'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Queen of the Hills?', options: ['Mussoorie', 'Darjeeling', 'Ooty', 'Shimla'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Silicon Valley of India?', options: ['Pune', 'Chennai', 'Hyderabad', 'Bengaluru'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Joy?', options: ['Varanasi', 'Mumbai', 'Kolkata', 'Chennai'], answer: 2, difficulty: 2, topic: 'Geography'),

  // -------------------------------------------------------- parks & wildlife
  QuizQuestion(question: 'Kaziranga National Park, home of the one-horned rhinoceros, is in which state?', options: ['Assam', 'Odisha', 'Meghalaya', 'West Bengal'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Sundarbans are best known for which animal?', options: ['Snow leopard', 'Indian elephant', 'Asiatic lion', 'Royal Bengal tiger'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Gir Forest, the last home of the Asiatic lion, is in which state?', options: ['Maharashtra', 'Rajasthan', 'Gujarat', 'Madhya Pradesh'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which was India’s first national park, established in 1936?', options: ['Jim Corbett', 'Bandhavgarh', 'Ranthambore', 'Kanha'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Ranthambore National Park is in which state?', options: ['Gujarat', 'Haryana', 'Madhya Pradesh', 'Rajasthan'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Periyar wildlife sanctuary is in which state?', options: ['Goa', 'Karnataka', 'Kerala', 'Tamil Nadu'], answer: 2, difficulty: 3, topic: 'Geography'),

  // ------------------------------------------------------------------ world
  QuizQuestion(question: 'What is the capital of Nepal?', options: ['Kathmandu', 'Lalitpur', 'Biratnagar', 'Pokhara'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Sri Lanka’s commercial life, its largest city?', options: ['Galle', 'Jaffna', 'Kandy', 'Colombo'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Bhutan?', options: ['Phuentsholing', 'Paro', 'Thimphu', 'Punakha'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Japan?', options: ['Tokyo', 'Kyoto', 'Nagoya', 'Osaka'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Australia?', options: ['Canberra', 'Perth', 'Sydney', 'Melbourne'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest country in the world by area?', options: ['China', 'United States', 'Canada', 'Russia'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the smallest country in the world?', options: ['Nauru', 'Monaco', 'Vatican City', 'San Marino'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which country has the Great Wall?', options: ['Korea', 'Japan', 'China', 'Mongolia'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Suez Canal connects the Mediterranean Sea to which sea?', options: ['Red Sea', 'Caspian Sea', 'Arabian Sea', 'Black Sea'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which line divides the Earth into northern and southern halves?', options: ['Prime Meridian', 'Tropic of Capricorn', 'Tropic of Cancer', 'Equator'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Tropic of Cancer passes through roughly how many Indian states?', options: ['Two', 'Five', 'Eight', 'Twelve'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which country is directly to the north-west of India?', options: ['Pakistan', 'Bangladesh', 'Myanmar', 'Nepal'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which strait separates India from Sri Lanka?', options: ['Bering Strait', 'Strait of Hormuz', 'Malacca Strait', 'Palk Strait'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Andaman and Nicobar Islands lie in which body of water?', options: ['Laccadive Sea', 'Arabian Sea', 'Bay of Bengal', 'Indian Ocean proper'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Lakshadweep lies in which body of water?', options: ['Arabian Sea', 'Andaman Sea', 'Palk Bay', 'Bay of Bengal'], answer: 0, difficulty: 2, topic: 'Geography'),
  // ======================= second batch =======================
  QuizQuestion(question: 'Which is the largest continent in the world?', options: ['North America', 'Europe', 'Africa', 'Asia'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the smallest continent in the world?', options: ['South America', 'Europe', 'Australia', 'Antarctica'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which continent has no permanent human population?', options: ['Antarctica', 'Greenland', 'Siberia', 'Australia'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Indian Standard Time is ahead of Greenwich Mean Time by how much?', options: ['Six hours', 'Five hours', 'Four hours', 'Five and a half hours'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest island in the world?', options: ['Madagascar', 'New Guinea', 'Greenland', 'Borneo'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which canal connects the Atlantic and Pacific Oceans?', options: ['Panama Canal', 'Kiel Canal', 'Grand Canal', 'Suez Canal'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the deepest known trench in the oceans?', options: ['Puerto Rico Trench', 'Tonga Trench', 'Java Trench', 'Mariana Trench'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest lake in the world by area?', options: ['Lake Baikal', 'Lake Superior', 'Caspian Sea', 'Lake Victoria'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest river island in the world, lying in the Brahmaputra?', options: ['Majuli', 'Sriharikota', 'Divar', 'Munroe Island'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which river is known as the Dakshin Ganga, or Ganga of the south?', options: ['Kaveri', 'Tungabhadra', 'Krishna', 'Godavari'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'The Brahmaputra is known by which name in Tibet?', options: ['Salween', 'Indus', 'Tsangpo', 'Mekong'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state shares a border with China, Nepal and Bhutan?', options: ['Sikkim', 'Arunachal Pradesh', 'Uttarakhand', 'Assam'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state is the largest producer of tea?', options: ['Kerala', 'Tamil Nadu', 'West Bengal', 'Assam'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state is the largest producer of coffee?', options: ['Andhra Pradesh', 'Kerala', 'Karnataka', 'Tamil Nadu'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Black soil is considered best for growing which crop?', options: ['Cotton', 'Tea', 'Wheat', 'Rice'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The south-west monsoon normally reaches the Indian mainland first in which state?', options: ['West Bengal', 'Odisha', 'Gujarat', 'Kerala'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Mawsynram and Cherrapunji, among the wettest places on Earth, are in which state?', options: ['Nagaland', 'Assam', 'Meghalaya', 'Mizoram'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city stands on the banks of the Hooghly?', options: ['Kolkata', 'Cuttack', 'Dhaka', 'Patna'], answer: 0, difficulty: 2, topic: 'Geography'),
];
