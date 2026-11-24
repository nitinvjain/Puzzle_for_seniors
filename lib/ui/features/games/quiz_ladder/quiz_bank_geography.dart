/// Geography questions for KBC India, weighted towards India.
///
/// Physical and settled political geography only. No "which state has the
/// most districts" or similar, because those change.
library;

import 'quiz_question.dart';

const List<QuizQuestion> geographyQuestions = [
  // ------------------------------------------------------- rivers and water
  QuizQuestion(question: 'Which is the longest river in India?', options: ['Ganga', 'Narmada', 'Yamuna', 'Godavari'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the longest river in peninsular India?', options: ['Kaveri', 'Mahanadi', 'Krishna', 'Godavari'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'On which river does the city of Varanasi stand?', options: ['Ganga', 'Gomti', 'Son', 'Yamuna'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'On which river does Delhi stand?', options: ['Sutlej', 'Chambal', 'Ganga', 'Yamuna'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which two rivers meet at Prayagraj?', options: ['Ganga and Yamuna', 'Ganga and Son', 'Yamuna and Chambal', 'Ganga and Gomti'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which river is known as the Sorrow of Bihar?', options: ['Son', 'Ghaghara', 'Gandak', 'Kosi'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which river flows through the Marble Rocks at Bhedaghat?', options: ['Narmada', 'Chambal', 'Betwa', 'Tapti'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest freshwater lake in India?', options: ['Dal', 'Loktak', 'Chilika', 'Wular'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Chilika Lake, India’s largest lagoon, is in which state?', options: ['Odisha', 'West Bengal', 'Tamil Nadu', 'Andhra Pradesh'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the longest river in the world?', options: ['Yangtze', 'Mississippi', 'Amazon', 'Nile'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which river flows through Egypt?', options: ['Nile', 'Niger', 'Zambezi', 'Congo'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest ocean in the world?', options: ['Arctic', 'Atlantic', 'Indian', 'Pacific'], answer: 3, difficulty: 1, topic: 'Geography'),

  // ---------------------------------------------------- mountains and desert
  QuizQuestion(question: 'Which is the highest mountain peak lying within India?', options: ['Kangchenjunga', 'Kamet', 'Saltoro Kangri', 'Nanda Devi'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which is the highest mountain in the world?', options: ['Kangchenjunga', 'Lhotse', 'K2', 'Mount Everest'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Thar Desert lies mainly in which state?', options: ['Rajasthan', 'Haryana', 'Punjab', 'Gujarat'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Western Ghats run roughly parallel to which coast?', options: ['The northern plains', 'The Himalayan foothills', 'The eastern coast', 'The western coast'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which range separates India from Tibet?', options: ['Himalaya', 'Satpura', 'Aravalli', 'Vindhya'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the oldest mountain range in India?', options: ['Satpura', 'Nilgiri', 'Himalaya', 'Aravalli'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'The Nilgiri Hills lie mainly in which state?', options: ['Tamil Nadu', 'Karnataka', 'Andhra Pradesh', 'Kerala'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest desert in the world?', options: ['Gobi', 'Thar', 'Kalahari', 'Sahara'], answer: 3, difficulty: 1, topic: 'Geography'),

  // ---------------------------------------------------------- states, cities
  QuizQuestion(question: 'What is the capital of Karnataka?', options: ['Bengaluru', 'Hubballi', 'Mysuru', 'Mangaluru'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Kerala?', options: ['Kozhikode', 'Thrissur', 'Kochi', 'Thiruvananthapuram'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Gujarat?', options: ['Gandhinagar', 'Vadodara', 'Ahmedabad', 'Surat'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Rajasthan?', options: ['Udaipur', 'Ajmer', 'Jodhpur', 'Jaipur'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Maharashtra?', options: ['Mumbai', 'Nashik', 'Pune', 'Nagpur'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Tamil Nadu?', options: ['Coimbatore', 'Salem', 'Madurai', 'Chennai'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of West Bengal?', options: ['Kolkata', 'Siliguri', 'Durgapur', 'Howrah'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Assam?', options: ['Silchar', 'Jorhat', 'Guwahati', 'Dispur'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Madhya Pradesh?', options: ['Bhopal', 'Gwalior', 'Jabalpur', 'Indore'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Uttar Pradesh?', options: ['Varanasi', 'Agra', 'Kanpur', 'Lucknow'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Punjab?', options: ['Chandigarh', 'Patiala', 'Amritsar', 'Ludhiana'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Odisha?', options: ['Puri', 'Rourkela', 'Cuttack', 'Bhubaneswar'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Telangana?', options: ['Hyderabad', 'Nizamabad', 'Karimnagar', 'Warangal'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Bihar?', options: ['Bhagalpur', 'Muzaffarpur', 'Gaya', 'Patna'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which state is called the Land of Five Rivers?', options: ['Punjab', 'Himachal Pradesh', 'Uttarakhand', 'Haryana'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest Indian state by area?', options: ['Uttar Pradesh', 'Madhya Pradesh', 'Maharashtra', 'Rajasthan'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the smallest Indian state by area?', options: ['Goa', 'Tripura', 'Nagaland', 'Sikkim'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian state has the longest coastline?', options: ['Maharashtra', 'Tamil Nadu', 'Andhra Pradesh', 'Gujarat'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which place is the southernmost tip of mainland India?', options: ['Kanyakumari', 'Kochi', 'Puducherry', 'Rameswaram'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Chandigarh is the shared capital of which two states?', options: ['Punjab and Himachal Pradesh', 'Haryana and Delhi', 'Punjab and Rajasthan', 'Punjab and Haryana'], answer: 3, difficulty: 2, topic: 'Geography'),

  // ----------------------------------------------------------- city nicknames
  QuizQuestion(question: 'Which city is known as the Pink City?', options: ['Jaipur', 'Udaipur', 'Bikaner', 'Jodhpur'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Blue City?', options: ['Jaisalmer', 'Bikaner', 'Jaipur', 'Jodhpur'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Golden City of Rajasthan?', options: ['Jaisalmer', 'Ajmer', 'Kota', 'Alwar'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Lakes?', options: ['Nainital', 'Srinagar', 'Bhopal', 'Udaipur'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Garden City of India?', options: ['Bengaluru', 'Mysuru', 'Chandigarh', 'Pune'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Nawabs?', options: ['Bhopal', 'Rampur', 'Hyderabad', 'Lucknow'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Manchester of India?', options: ['Kanpur', 'Coimbatore', 'Surat', 'Ahmedabad'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Queen of the Hills?', options: ['Mussoorie', 'Darjeeling', 'Ooty', 'Shimla'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the Silicon Valley of India?', options: ['Bengaluru', 'Pune', 'Chennai', 'Hyderabad'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which city is known as the City of Joy?', options: ['Chennai', 'Varanasi', 'Mumbai', 'Kolkata'], answer: 3, difficulty: 2, topic: 'Geography'),

  // -------------------------------------------------------- parks & wildlife
  QuizQuestion(question: 'Kaziranga National Park, home of the one-horned rhinoceros, is in which state?', options: ['Assam', 'Odisha', 'Meghalaya', 'West Bengal'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Sundarbans are best known for which animal?', options: ['Snow leopard', 'Indian elephant', 'Asiatic lion', 'Royal Bengal tiger'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Gir Forest, the last home of the Asiatic lion, is in which state?', options: ['Madhya Pradesh', 'Maharashtra', 'Rajasthan', 'Gujarat'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which was India’s first national park, established in 1936?', options: ['Jim Corbett', 'Bandhavgarh', 'Ranthambore', 'Kanha'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Ranthambore National Park is in which state?', options: ['Rajasthan', 'Gujarat', 'Haryana', 'Madhya Pradesh'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Periyar wildlife sanctuary is in which state?', options: ['Tamil Nadu', 'Goa', 'Karnataka', 'Kerala'], answer: 3, difficulty: 3, topic: 'Geography'),

  // ------------------------------------------------------------------ world
  QuizQuestion(question: 'What is the capital of Nepal?', options: ['Kathmandu', 'Lalitpur', 'Biratnagar', 'Pokhara'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Sri Lanka’s commercial life, its largest city?', options: ['Galle', 'Jaffna', 'Kandy', 'Colombo'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Bhutan?', options: ['Punakha', 'Phuentsholing', 'Paro', 'Thimphu'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Japan?', options: ['Nagoya', 'Osaka', 'Tokyo', 'Kyoto'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What is the capital of Australia?', options: ['Canberra', 'Perth', 'Sydney', 'Melbourne'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which is the largest country in the world by area?', options: ['Russia', 'China', 'United States', 'Canada'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which is the smallest country in the world?', options: ['San Marino', 'Nauru', 'Monaco', 'Vatican City'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which country has the Great Wall?', options: ['Korea', 'Japan', 'China', 'Mongolia'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Suez Canal connects the Mediterranean Sea to which sea?', options: ['Caspian Sea', 'Arabian Sea', 'Black Sea', 'Red Sea'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which line divides the Earth into northern and southern halves?', options: ['Tropic of Capricorn', 'Tropic of Cancer', 'Equator', 'Prime Meridian'], answer: 2, difficulty: 1, topic: 'Geography'),
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
