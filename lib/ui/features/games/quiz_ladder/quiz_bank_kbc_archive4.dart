/// Thirteen more episode pages, from later seasons of the same archive.
///
/// Same rule as the three banks before it. Later seasons lean harder on
/// current affairs than the early ones did, so the share left behind is
/// larger here -- film releases, appointments, who captained whom last
/// season. What survives is what would have been as answerable in 2005 as
/// it is now.
///
/// Four of these pages were wrong, and one wrongly flagged:
///
///   * one asked which planet is the largest and answered Earth.
///   * one asked which jewellery material does not come from a mine and
///     answered diamond.
///   * one asked which tree has the shortest leaves and answered mango,
///     which is not a thing that can be answered.
///   * one asked how many millilitres make an inch, in an earlier batch.
///   * one page's own summary called the Bandipur and Odisha pairing an
///     error -- but the question asked which pairing was WRONG, so that was
///     the right answer. It is here.
///
/// Answer positions cycle 0, 1, 2, 3.
library;

import 'quiz_question.dart';

const List<QuizQuestion> kbcArchive4Questions = [
  QuizQuestion(question: 'Who was the first person to swim across the English Channel?', options: ['Matthew Webb', 'Gertrude Ederle', 'Mihir Sen', 'Arati Saha'], answer: 0, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'In the Mahabharata, which of Arjuna\'s wives was a naga princess?', options: ['Chitrangada', 'Ulupi', 'Subhadra', 'Draupadi'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Macluskiganj, laid out in the 1930s, was founded as a settlement for which community?', options: ['Parsis', 'Armenians', 'Anglo-Indians', 'Jews of Cochin'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which was the heaviest aircraft ever built?', options: ['The Boeing 747', 'The Airbus A380', 'The Hercules C-130', 'The Antonov An-225'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which of these happens only once in a month of the Hindu calendar?', options: ['Purnima', 'Ekadashi', 'Chaturthi', 'Ashtami'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is not an infantry regiment of the Indian Army?', options: ['The Rajput Regiment', 'The Kalinga Regiment', 'The Jat Regiment', 'The Dogra Regiment'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In the Raghuvamsha, which queen died when a flower fell on her from Narada\'s garland?', options: ['Sumitra', 'Kaikeyi', 'Indumati', 'Shakuntala'], answer: 2, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Allama Iqbal\'s line about a perfect man who woke India from sleep was written about whom?', options: ['Kabir', 'Mahatma Gandhi', 'Swami Vivekananda', 'Guru Nanak'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'According to the saying, a flute cannot be made without what?', options: ['Bamboo', 'Brass', 'Teak', 'Clay'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which medal goes to the third place at the Olympic Games?', options: ['Silver', 'Bronze', 'Copper', 'Iron'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'In an equilateral triangle, what is equal besides the sides?', options: ['The medians only', 'The heights only', 'The angles', 'Nothing else'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'What must usually be entered to complete an online banking payment?', options: ['A postal code', 'A photograph', 'A signature', 'A one-time password'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'For which law are the letters IPC the short form?', options: ['The Indian Penal Code', 'The Indian Partnership Code', 'The Income Protection Code', 'The Industrial Policy Code'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which of the four Vedas is the oldest?', options: ['The Samaveda', 'The Rigveda', 'The Yajurveda', 'The Atharvaveda'], answer: 1, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Through which organ does an unborn child receive its nourishment?', options: ['The liver', 'The spleen', 'The placenta', 'The thymus'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which force was raised in 1992 to deal with riots?', options: ['The Border Security Force', 'The Central Industrial Security Force', 'The National Security Guard', 'The Rapid Action Force'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which firm\'s legal case first took Gandhi to South Africa in 1893?', options: ['Dada Abdulla and Company', 'Tata and Sons', 'Godrej and Boyce', 'Walchand and Company'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who captained the Indian football team at the 1948 Olympics, its first after independence?', options: ['Sailen Manna', 'Talimeren Ao', 'Chuni Goswami', 'P.K. Banerjee'], answer: 1, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Prospero was the first satellite launched by which country\'s own rocket?', options: ['France', 'Canada', 'Britain', 'Australia'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'What is the spare wheel of a car commonly called in India?', options: ['Reserve', 'Backup', 'Spare tyre', 'Stepney'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the name for songs sung to put small children to sleep?', options: ['Lori', 'Thumri', 'Bhajan', 'Kajri'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'If indu means the moon, what day of the week is induvaar?', options: ['Sunday', 'Monday', 'Tuesday', 'Friday'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'The QR code was devised in 1994 to track what?', options: ['Library books', 'Postal packets', 'Parts in car manufacture', 'Railway wagons'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Who pulled the other end of the serpent during the churning of the ocean?', options: ['The apsaras', 'The gandharvas', 'The rishis', 'The asuras'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In IRCTC, what does the first C stand for?', options: ['Catering', 'Commerce', 'Corporation', 'Control'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What are the two sides of a coin called?', options: ['Front and back', 'Head and tail', 'Top and base', 'Face and reverse'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the main ingredient of mayonnaise?', options: ['Cream', 'Curd', 'Egg yolk', 'Cheese'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'On which of these does Satyameva Jayate not appear?', options: ['The rupee note', 'The national emblem', 'An Indian passport', 'The national flag'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The world\'s oldest living grapevine grows in which country?', options: ['Slovenia', 'Italy', 'France', 'Spain'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Olympic wrestling has two styles. One is freestyle. What is the other?', options: ['Sumo', 'Greco-Roman', 'Catch', 'Pehlwani'], answer: 1, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Annie Sharp founded India\'s first school in Amritsar in 1887 for which pupils?', options: ['The deaf', 'Orphans', 'The blind', 'Girls'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which of these Indian observances falls latest in the calendar year?', options: ['Independence Day', 'Teachers\' Day', 'Gandhi Jayanti', 'Children\'s Day'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which boy\'s name means lord of the mountains, and so the Himalaya?', options: ['Giriraj', 'Jalaj', 'Vasudev', 'Anil'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Papier mache work is a traditional craft of which region?', options: ['Rajasthan', 'Kashmir', 'Bengal', 'Kerala'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which sportsperson is matched with the wrong sport?', options: ['Pele and football', 'Carl Lewis and athletics', 'Michael Phelps and golf', 'Boris Becker and tennis'], answer: 2, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Which of these was not a son of Gandhari?', options: ['Duryodhana', 'Dushasana', 'Vikarna', 'Yuyutsu'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Helium takes its name from the Greek word for what?', options: ['The Sun', 'The Moon', 'Air', 'Fire'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'In the Ramayana, who asked Rama to prove his archery by piercing seven trees?', options: ['Hanuman', 'Sugriva', 'Vibhishana', 'Jatayu'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Goshtaba, a Kashmiri dish, is made chiefly of what?', options: ['Chicken', 'Fish', 'Mutton', 'Paneer'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is a photograph taken with the front camera of a telephone called?', options: ['A portrait', 'A snapshot', 'A close-up', 'A selfie'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Kindle is the name of which kind of device?', options: ['An electronic book reader', 'A music player', 'A camera', 'A printer'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Prakash Parv and Nagar Kirtan belong to which faith?', options: ['Jainism', 'Sikhism', 'Buddhism', 'Zoroastrianism'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Robusta and Arabica are varieties used to make what?', options: ['Tea', 'Cocoa', 'Coffee', 'Tobacco'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Right to Information Act came into force in which year?', options: ['1995', '2010', '2000', '2005'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In the Mahabharata, which hunter\'s arrow killed Krishna by mistake?', options: ['Jara', 'Ekalavya', 'Nishad', 'Bhilla'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which dish is named after the vessel it is cooked in?', options: ['Shahi paneer', 'Kadai paneer', 'Palak paneer', 'Matar paneer'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Skeet and trap are events in which Olympic sport?', options: ['Archery', 'Fencing', 'Shooting', 'Sailing'], answer: 2, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Bilaspur was the seat of which kingdom before the Marathas took it?', options: ['The Chola kingdom', 'The Ahom kingdom', 'The Chalukya kingdom', 'The Gond kingdom'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Dhauli in Odisha is believed to be the site of which battle?', options: ['The Kalinga war', 'The battle of Plassey', 'The battle of Talikota', 'The battle of Haldighati'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The book Lilavati\'s Daughters collects essays about whom?', options: ['Indian classical dancers', 'Indian women scientists', 'Indian mathematicians of old', 'Indian women writers'], answer: 1, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Who was awarded the Param Vir Chakra for the defence of Rezang La in 1962?', options: ['Major Somnath Sharma', 'Captain Vikram Batra', 'Major Shaitan Singh', 'Subedar Joginder Singh'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who wrote the novel Swami and Friends?', options: ['Mulk Raj Anand', 'Raja Rao', 'Khushwant Singh', 'R.K. Narayan'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which colour mixed with red gives orange?', options: ['Yellow', 'Blue', 'White', 'Green'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which is the longest river rising in Maharashtra?', options: ['The Krishna', 'The Godavari', 'The Tapi', 'The Bhima'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which fictional character carries the code number 007?', options: ['Sherlock Holmes', 'Hercule Poirot', 'James Bond', 'Philip Marlowe'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which four letters usually begin the address of a web page?', options: ['www', 'com', 'web', 'http'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Gulband and hansuli are ornaments worn on which part of the body?', options: ['The neck', 'The wrist', 'The ankle', 'The waist'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is not an official language of the United Nations?', options: ['Arabic', 'Hindi', 'Chinese', 'Russian'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'If Ctrl and X cut, and Ctrl and V paste, what does Ctrl and C do?', options: ['Close', 'Cancel', 'Copy', 'Clear'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Shakuni was to Duryodhana what Kansa was to Krishna. What was that relation?', options: ['Paternal uncle', 'Elder brother', 'Father-in-law', 'Maternal uncle'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which national park and state are wrongly paired?', options: ['Bandipur and Odisha', 'Kaziranga and Assam', 'Gir and Gujarat', 'Corbett and Uttarakhand'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which word completes the title of the 2007 film ______ Zameen Par?', options: ['Chaand', 'Taare', 'Suraj', 'Sapne'], answer: 1, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'The Nobel Prizes are presented each year on the anniversary of what?', options: ['Alfred Nobel\'s birth', 'The first award', 'Alfred Nobel\'s death', 'The founding of Sweden'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'According to the idiom, putting a lock on what means to keep quiet?', options: ['The hand', 'The heart', 'The door', 'The mouth'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which god is usually shown carrying a mountain in one hand?', options: ['Hanuman', 'Ganesha', 'Kartikeya', 'Varuna'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What do two particles of opposite charge do?', options: ['Repel each other', 'Attract each other', 'Stay still', 'Spin'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which of India\'s neighbours shares a border with India but not with China?', options: ['Nepal', 'Bhutan', 'Bangladesh', 'Pakistan'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which of these numbers is prime?', options: ['15', '21', '27', '13'], answer: 3, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Ramadan is which month of the Islamic calendar?', options: ['The ninth', 'The first', 'The fifth', 'The twelfth'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Bardoli, where Sardar Patel led the satyagraha of 1928, is in which state?', options: ['Maharashtra', 'Gujarat', 'Rajasthan', 'Madhya Pradesh'], answer: 1, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'In an old Indian office, who was the bada babu?', options: ['The watchman', 'The owner', 'The head clerk', 'The messenger'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Besides Sachin Tendulkar, which Indian has scored more than thirteen thousand Test runs?', options: ['Sunil Gavaskar', 'V.V.S. Laxman', 'Virender Sehwag', 'Rahul Dravid'], answer: 3, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Ranthambore, Sariska and Keoladeo Ghana are all what?', options: ['National parks', 'Hill stations', 'Forts', 'Lakes'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which musician was born in Varanasi?', options: ['Ustad Amjad Ali Khan', 'Pandit Ravi Shankar', 'Pandit Jasraj', 'Ustad Zakir Hussain'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Who captained India in its first ever Twenty20 international?', options: ['M.S. Dhoni', 'Rahul Dravid', 'Virender Sehwag', 'Sourav Ganguly'], answer: 2, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Where is the largest railway coach factory in the world?', options: ['Kapurthala', 'Rae Bareli', 'Bengaluru', 'Chennai'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which Urdu poet is honoured with the title Khuda-e-sukhan, god of poetry?', options: ['Mir Taqi Mir', 'Mirza Ghalib', 'Faiz Ahmed Faiz', 'Daagh Dehlvi'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Who is credited with coining the name Meghalaya?', options: ['Verrier Elwin', 'Shiba Prasad Chatterjee', 'Jawaharlal Nehru', 'B.P. Chaliha'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'What is a history-sheeter?', options: ['A keeper of archives', 'A history teacher', 'A person with a criminal record', 'A writer of chronicles'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The femur, the ulna and the sternum are all what?', options: ['Muscles', 'Nerves', 'Glands', 'Bones'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Lala Amarnath and his sons were known in which sport?', options: ['Cricket', 'Hockey', 'Football', 'Tennis'], answer: 0, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'The Virasat-e-Khalsa museum is in which town?', options: ['Amritsar', 'Anandpur Sahib', 'Patiala', 'Ludhiana'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Prithvi, Nag and Trishul are names of what?', options: ['Warships', 'Satellites', 'Missiles', 'Aircraft'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What does the word chaman mean?', options: ['A lamp', 'A mirror', 'A meadow stream', 'A garden'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In the Ramayana, Janaka and Dasharatha were each other\'s what?', options: ['Samdhi', 'Guru and pupil', 'Cousins', 'Rivals'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these would you not find in a vegetarian restaurant?', options: ['Vada pav', 'Keema pav', 'Misal pav', 'Bread pakoda'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Indian banknotes of which denomination have never been printed?', options: ['Two rupees', 'Twenty rupees', 'Three rupees', 'Fifty rupees'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Rod Laver, Bjorn Borg and John McEnroe were champions of which sport?', options: ['Golf', 'Cricket', 'Badminton', 'Tennis'], answer: 3, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Which of these states is not a party to the Kaveri water dispute?', options: ['Andhra Pradesh', 'Karnataka', 'Tamil Nadu', 'Kerala'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Pavo cristatus is the scientific name of which bird?', options: ['The parrot', 'The peacock', 'The pheasant', 'The crane'], answer: 1, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Maharana Bhupal Singh, the first Maha-Rajpramukh of Rajasthan, ruled which state?', options: ['Jodhpur', 'Jaipur', 'Udaipur', 'Bikaner'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which of these is not a shopping website?', options: ['Amazon', 'Flipkart', 'Myntra', 'Infosys'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is the base colour of the two hundred rupee note?', options: ['Bright yellow', 'Stone grey', 'Magenta', 'Green'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'A tagdi is worn around which part of the body?', options: ['The neck', 'The waist', 'The ankle', 'The head'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Besides sugarcane, jaggery is commonly made from the sap of which tree?', options: ['The mango', 'The neem', 'The date palm', 'The banyan'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which British Resident at Hyderabad, the subject of White Mughals, married Khair un-Nissa?', options: ['Warren Hastings', 'Charles Metcalfe', 'Robert Clive', 'James Achilles Kirkpatrick'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who led the first excavation of Harappa?', options: ['Daya Ram Sahni', 'R.D. Banerji', 'John Marshall', 'Mortimer Wheeler'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The Milinda-panha records a dialogue between King Menander and which monk?', options: ['Nagarjuna', 'Nagasena', 'Ananda', 'Upali'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Mini, double-decker and low-floor are kinds of what?', options: ['Train', 'Boat', 'Bus', 'Aeroplane'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Kala Ghoda arts festival is held in which city?', options: ['Delhi', 'Kolkata', 'Bengaluru', 'Mumbai'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What happens to red litmus paper dipped in a base?', options: ['It turns blue', 'It turns white', 'It turns green', 'Nothing'], answer: 0, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Ravi Verma and Vijay Verma are the two brothers in which film?', options: ['Sholay', 'Deewaar', 'Trishul', 'Zanjeer'], answer: 1, difficulty: 3, topic: 'Films'),
];
