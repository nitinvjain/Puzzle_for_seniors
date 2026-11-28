/// The last twelve pages of the twenty-five NJ asked for, plus three more.
///
/// Three pages from KBC season 12 and nine from season 13. The later the
/// season, the thinner the harvest: season 13's pages are mostly about who
/// had just been appointed to what, and those questions were stale within
/// the year. What is kept here would have been as answerable in 2005 as it
/// is now.
///
/// Four pages were wrong and are dropped:
///
///   * one asked which battle was fought LAST and answered Plassey, which
///     is the earliest of the four it offered.
///   * one asked which sage arrived at the Pandava camp and answered
///     Vishwamitra; the story is Durvasa's.
///   * one asked what is worked with the hands in a car and the feet on a
///     motorcycle, and answered the horn, which is a hand on both.
///   * one credited an American social reformer with work I could not
///     confirm anywhere, so it goes rather than be guessed at.
///
/// Answer positions cycle 0, 1, 2, 3.
library;

import 'quiz_question.dart';

const List<QuizQuestion> kbcArchive5Questions = [
  QuizQuestion(question: 'Which Union Territory of India has its own legislative assembly?', options: ['Puducherry', 'Lakshadweep', 'Daman and Diu', 'Chandigarh'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who commanded the Sikh army in the Second Anglo-Sikh War?', options: ['Hari Singh Nalwa', 'Sher Singh Attariwala', 'Gulab Singh', 'Lal Singh'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The Sulabh International Museum of Toilets is in which city?', options: ['Mumbai', 'Patna', 'Delhi', 'Jaipur'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which founder of a political party began his working life as a cartoonist?', options: ['Karpoori Thakur', 'Kanshi Ram', 'Chaudhary Charan Singh', 'Bal Thackeray'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Tofu is made by curdling what?', options: ['Soy milk', 'Cow\'s milk', 'Coconut milk', 'Almond milk'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Bagheli and Kannauji are kinds of what?', options: ['Dances', 'Dialects', 'Sweets', 'Fabrics'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which boy\'s name means well spoken?', options: ['Suresh', 'Sudhir', 'Subhash', 'Sumit'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Who was the first woman to preside over the United Nations General Assembly?', options: ['Sarojini Naidu', 'Hansa Mehta', 'Rajkumari Amrit Kaur', 'Vijaya Lakshmi Pandit'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Tarun Gogoi was the longest-serving Chief Minister of which state?', options: ['Assam', 'Odisha', 'Tripura', 'Jharkhand'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Panna and Golconda are known for mines of which stone?', options: ['Ruby', 'Diamond', 'Emerald', 'Sapphire'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which part of a living cell carries its hereditary information?', options: ['The ribosome', 'The vacuole', 'The chromosome', 'The cell wall'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'A Kolhapuri saaj is which kind of ornament?', options: ['An anklet', 'A bangle', 'A nose ring', 'A necklace'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Argentina won the football World Cup under Diego Maradona\'s captaincy in which year?', options: ['1986', '1978', '1990', '1982'], answer: 0, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Osmanabad is named after the last ruler of which princely state?', options: ['Mysore', 'Hyderabad', 'Gwalior', 'Baroda'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Rishi Kapoor first appeared on screen as a small child in which film?', options: ['Awaara', 'Barsaat', 'Shree 420', 'Sangam'], answer: 2, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which part of the body is cupped to make a chullu?', options: ['The ear', 'The mouth', 'The foot', 'The palm'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The yeast used to make bread belongs to which group of living things?', options: ['Fungi', 'Bacteria', 'Algae', 'Plants'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which colour completes the name of the fort Shah Jahan built in Delhi?', options: ['White', 'Red', 'Black', 'Golden'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Jhoom and intensive are kinds of what?', options: ['Soil', 'Minerals', 'Farming', 'Tools'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which Mughal emperor was an accomplished player of the veena?', options: ['Akbar', 'Jahangir', 'Humayun', 'Aurangzeb'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'At which town do the Alaknanda and the Bhagirathi join to become the Ganga?', options: ['Devprayag', 'Rudraprayag', 'Karnaprayag', 'Haridwar'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which of these states was never a Union Territory first?', options: ['Manipur', 'Sikkim', 'Tripura', 'Goa'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which of these festivals is not reckoned by the Moon?', options: ['Holi', 'Diwali', 'Makar Sankranti', 'Raksha Bandhan'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In the Ramayana, who was the mother of Subahu and Maricha?', options: ['Surpanakha', 'Mandodari', 'Trijata', 'Tadaka'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Taak, ghol, majjiga and mattha are all names for what?', options: ['Buttermilk', 'Curd', 'Lassi', 'Ghee'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What does the Urdu word pakeezah mean?', options: ['Beautiful', 'Pure', 'Beloved', 'Silent'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which bird cannot move its eyes within their sockets?', options: ['The eagle', 'The parrot', 'The owl', 'The crow'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which of these animals does not appear in Kipling\'s The Jungle Book?', options: ['The panther', 'The python', 'The bear', 'The gorilla'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which company makes the Mac operating system?', options: ['Apple', 'Microsoft', 'Google', 'IBM'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the Great Red Spot on Jupiter?', options: ['A crater', 'A storm', 'A desert', 'A moon\'s shadow'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which politician was the son of a former Prime Minister of India?', options: ['Sharad Pawar', 'Lalu Prasad Yadav', 'Ajit Singh', 'Mulayam Singh Yadav'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which word completes the aarti line that ends Jai Jagdish Hare?', options: ['Shri Jai', 'Hari Jai', 'Jai Jai', 'Om Jai'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'On an Android telephone, where are applications downloaded from?', options: ['The Play Store', 'The App Store', 'The Web Store', 'The Gallery'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Jaffa, Nagpur and Valencia are all known for which fruit?', options: ['The grape', 'The orange', 'The apple', 'The mango'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Who founded the organisation People for Animals?', options: ['Medha Patkar', 'Sunita Narain', 'Maneka Gandhi', 'Vandana Shiva'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In the Valmiki Ramayana, Kishkindha was the kingdom of whom?', options: ['The rakshasas', 'The nagas', 'The yakshas', 'The vanaras'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which element has the single-letter symbol K?', options: ['Potassium', 'Krypton', 'Calcium', 'Carbon'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'How many blades does an Indian ceiling fan usually have?', options: ['Two', 'Three', 'Four', 'Five'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which Hindi phrase describes a very generous person?', options: ['Dil chhota hona', 'Dil baith jaana', 'Dil dariya hona', 'Dil lagana'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Bhang thandai is traditionally drunk at which festival?', options: ['Diwali', 'Dussehra', 'Baisakhi', 'Holi'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which of these was never awarded the Bharat Ratna?', options: ['Mahatma Gandhi', 'Sardar Patel', 'B.R. Ambedkar', 'Lal Bahadur Shastri'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Apache, Chinook, Dhruv and Chetak are all kinds of what?', options: ['Fighter aircraft', 'Helicopters', 'Tanks', 'Warships'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The people of Malana in Himachal Pradesh claim descent from the soldiers of whom?', options: ['Genghis Khan', 'Timur', 'Alexander', 'Darius'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In the idiom, showing your battisi means showing what?', options: ['Your hands', 'Your feet', 'Your temper', 'Your teeth'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is not a national holiday in India?', options: ['The fourth of July', 'The fifteenth of August', 'The twenty-sixth of January', 'The second of October'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In the sweet khopra pak, what is khopra?', options: ['Jaggery', 'Coconut', 'Cashew', 'Semolina'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Indira Gandhi became Prime Minister after whom?', options: ['Jawaharlal Nehru', 'Morarji Desai', 'Lal Bahadur Shastri', 'Gulzarilal Nanda'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'To which genus does the Bengal tiger belong?', options: ['Felis', 'Lynx', 'Puma', 'Panthera'], answer: 3, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which country has Lebanon to its north and Egypt to its south-west?', options: ['Israel', 'Jordan', 'Cyprus', 'Syria'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'What is it called when a computer stops responding to anything you do?', options: ['It boots', 'It hangs', 'It syncs', 'It scrolls'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which fruit is the main ingredient of chyawanprash?', options: ['Mango', 'Date', 'Amla', 'Fig'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who moved the first no-confidence motion in the Lok Sabha, in 1963?', options: ['Ram Manohar Lohia', 'A.K. Gopalan', 'Atal Bihari Vajpayee', 'J.B. Kripalani'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which actor, born Yudhishthir, wrote the memoir Meri Filmi Atmakatha?', options: ['Balraj Sahni', 'Dev Anand', 'Ashok Kumar', 'Prithviraj Kapoor'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'What were the rulers of ancient Egypt called?', options: ['Caesars', 'Pharaohs', 'Sultans', 'Tsars'], answer: 1, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'Which of these happened earliest?', options: ['The Jallianwala Bagh massacre', 'The Dandi march', 'Curzon\'s partition of Bengal', 'The Quit India movement'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which pair of deities ride the same kind of creature?', options: ['Shiva and Vishnu', 'Ganesha and Kartikeya', 'Indra and Agni', 'Brahma and Saraswati'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Aki Kiti, fought with the soles of the feet, is a martial art of which people?', options: ['The Nagas', 'The Gonds', 'The Bhils', 'The Santhals'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is not one of the four tennis Grand Slam tournaments?', options: ['Wimbledon', 'The European Open', 'The French Open', 'The US Open'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Which island did Gulliver reach first in Gulliver\'s Travels?', options: ['Brobdingnag', 'Laputa', 'Lilliput', 'Houyhnhnm land'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In which ocean do the Seychelles lie?', options: ['The Atlantic', 'The Pacific', 'The Arctic', 'The Indian Ocean'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'What does the Hindi idiom charbi chadhna mean?', options: ['To become arrogant', 'To grow tired', 'To fall ill', 'To put on weight'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Katha, used in paan, comes from which tree?', options: ['Neem', 'Khair', 'Peepal', 'Sheesham'], answer: 1, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which charioteer of Indra carried Arjuna to heaven?', options: ['Sanjaya', 'Daruka', 'Matali', 'Sumantra'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Bande Utkal Janani is the state song of which state?', options: ['Assam', 'Bengal', 'Bihar', 'Odisha'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In the Hindu calendar, which month falls between Jyeshtha and Shravan?', options: ['Ashadha', 'Chaitra', 'Bhadrapada', 'Magha'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'On which continent is the largest hot desert in the world?', options: ['Asia', 'Africa', 'Australia', 'South America'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Who is the youngest person to have walked on the Moon?', options: ['Neil Armstrong', 'Buzz Aldrin', 'Charles Duke', 'Alan Shepard'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which of these is not one of the Padma awards?', options: ['Padma Vibhushan', 'Padma Bhushan', 'Padma Shri', 'Padma Shreshtha'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who was the youngest person elected President of India?', options: ['Neelam Sanjiva Reddy', 'A.P.J. Abdul Kalam', 'Zakir Husain', 'V.V. Giri'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In cricket, what is a lower-order batsman of limited ability called?', options: ['An opener', 'A tail ender', 'A night watchman', 'A pinch hitter'], answer: 1, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Vinoba Bhave\'s movement asked people to give away what?', options: ['Gold', 'Grain', 'Land', 'Cloth'], answer: 2, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'What is the study of very low temperatures called?', options: ['Thermodynamics', 'Meteorology', 'Seismology', 'Cryogenics'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which Hindi idiom, ______ uchhalna, means to insult somebody?', options: ['Topi', 'Haath', 'Pair', 'Aankh'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which poisonous metal is used to extract gold from its ore?', options: ['Lead', 'Mercury', 'Arsenic', 'Cadmium'], answer: 1, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which name means one who cannot be obstructed?', options: ['Ananth', 'Anand', 'Anirudh', 'Arvind'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In the Valmiki Ramayana, which sage urged Rama in the forest to take back the throne?', options: ['Vashishtha', 'Agastya', 'Bharadwaja', 'Jabali'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which article of the Indian Constitution gives freedom of speech?', options: ['Article 19', 'Article 14', 'Article 21', 'Article 32'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Little India, Chinatown and Dhoby Ghaut are stations on which city\'s metro?', options: ['Kuala Lumpur', 'Singapore', 'Hong Kong', 'Bangkok'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Who was the first chief of India\'s external intelligence agency?', options: ['Ajit Doval', 'B.N. Mullik', 'R.N. Kao', 'T.V. Rajeswar'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which book and author are wrongly paired?', options: ['Midnight\'s Children and Salman Rushdie', 'The God of Small Things and Arundhati Roy', 'Train to Pakistan and Khushwant Singh', 'Life of Pi and Anita Desai'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Sarla Thukral is remembered as the first Indian woman to do what?', options: ['Fly an aeroplane', 'Drive a train', 'Climb Everest', 'Swim the Channel'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who was the first Indian sportswoman to receive the Padma Shri?', options: ['P.T. Usha', 'Arati Saha', 'Karnam Malleswari', 'Mary Kom'], answer: 1, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Which of the big cats is the fastest?', options: ['The leopard', 'The lion', 'The cheetah', 'The tiger'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which of these is there the smallest number of?', options: ['Continents', 'Months in a year', 'Days in a week', 'Oceans'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which of these movements in the freedom struggle came first?', options: ['The Swadeshi movement', 'Non-cooperation', 'The Salt march', 'Quit India'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In the computing term P2P, what do the two Ps stand for?', options: ['Point', 'Peer', 'Public', 'Private'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which season comes first in an English dictionary?', options: ['Spring', 'Summer', 'Autumn', 'Winter'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Hubble that NASA named a space telescope after was what?', options: ['A pilot', 'A president', 'A mathematician', 'An astronomer'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'The battle of Haldighati in 1576 was fought between Akbar and whom?', options: ['Maharana Pratap', 'Rana Sanga', 'Shivaji', 'Prithviraj Chauhan'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'With what is the Bombay Natural History Society chiefly concerned?', options: ['Old buildings', 'Wildlife conservation', 'Coins', 'Manuscripts'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Charles Darwin made his famous voyage aboard which ship?', options: ['HMS Victory', 'HMS Endeavour', 'HMS Beagle', 'HMS Bounty'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'In which year were the Tokyo Olympic Games first cancelled?', options: ['1916', '1944', '1936', '1940'], answer: 3, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Which large country keeps only one time zone?', options: ['China', 'Russia', 'Canada', 'Brazil'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Rakesh Sharma spent his time in space aboard which station?', options: ['Mir', 'Salyut-7', 'Skylab', 'The ISS'], answer: 1, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which company began in 1964 as Blue Ribbon Sports before taking the name of a Greek goddess?', options: ['Adidas', 'Puma', 'Nike', 'Reebok'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The National Film Development Corporation of India co-produced which Oscar-winning film?', options: ['Lagaan', 'Slumdog Millionaire', 'Salaam Bombay', 'Gandhi'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which Sanskrit poet wrote the play Malatimadhava?', options: ['Bhavabhuti', 'Kalidasa', 'Bhasa', 'Shudraka'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'What did Maharaja Madho Singh II of Jaipur carry to London in two huge silver urns in 1902?', options: ['Jaipur soil', 'Water from the Ganga', 'Temple oil', 'Rose water'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Dharam Dev Dutt Pishorimal Anand was the real name of which actor?', options: ['Raj Kapoor', 'Dilip Kumar', 'Dev Anand', 'Balraj Sahni'], answer: 2, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'What is usually served from a samovar in Kashmir?', options: ['Lassi', 'Sherbet', 'Soup', 'Kahwa'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'The verses called boliyan belong to which folk dance?', options: ['Giddha', 'Garba', 'Bihu', 'Lavani'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which is the only inhabited continent with no active volcanoes on its mainland?', options: ['Africa', 'Australia', 'Europe', 'South America'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Vadodara\'s old name Vadapradaka meant a village among which trees?', options: ['Mango', 'Teak', 'Banyan', 'Palm'], answer: 2, difficulty: 3, topic: 'Geography'),
];
