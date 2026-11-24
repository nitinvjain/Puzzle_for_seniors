/// Questions drawn from two sets of a classic Indian school-quiz book.
///
/// Provenance, and why these are not copies. The source is an in-copyright
/// quiz book, and its rounds are either open-ended ("what is a drey?") or
/// three-option. This game needs four options, so every question here had to
/// be written from scratch regardless: what was taken is the subject matter
/// and the answer -- facts, which belong to nobody -- and the wording,
/// options and distractors are all new. Nothing is reproduced verbatim.
///
/// Two things were checked rather than assumed while writing them:
///
///   * the book is from 2016, so anything that has moved on since was left
///     out. What remains is settled: firsts that already happened, etymology,
///     geography, mythology, who wrote or composed what.
///
///   * one answer in the source is wrong, or at least mistyped -- the
///     southern tip of Great Nicobar is Indira Point, not "India Point".
///     The correct name is used here.
///
/// Several good questions from those sets are missing on purpose, because the
/// bank already asks them: the largest internal organ, the hardest natural
/// substance, who founded the Maurya empire, the capital of Assam, Ravi
/// Shankar's instrument, the symbol for potassium, and the first Indian woman
/// to win an Olympic medal.
library;

import 'quiz_question.dart';

const List<QuizQuestion> quizbookQuestions = [
  // ------------------------------------------------------------- India
  QuizQuestion(question: 'The Lifeline Express, which runs on India’s railways, is what?', options: ['A hospital on a train', 'A travelling bank', 'A mobile school', 'A post office on wheels'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which company supplies the indelible ink used to mark voters in Indian elections?', options: ['Asian Paints', 'Indian Oil', 'Hindustan Inks', 'Mysore Paints and Varnishes'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What is the southernmost point of Indian territory, on Great Nicobar, called?', options: ['Dhanushkodi', 'Kanyakumari', 'Indira Point', 'Point Calimere'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'On Indian banknotes, what does the AP in “AP Series” stand for?', options: ['Andhra Pradesh', 'Approved Print', 'Ancient Pattern', 'Ashokan Pillar'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Tussar, Muga and Endi are varieties of what?', options: ['Cotton', 'Rice', 'Silk', 'Tea'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Dussehri is a well-known variety of which fruit?', options: ['Mango', 'Banana', 'Custard apple', 'Guava'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Chowpatty beach is in which city?', options: ['Kolkata', 'Kochi', 'Chennai', 'Mumbai'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The name Kanchenjunga means “Five Treasures of the Great Snow”. In which Indian state does it stand?', options: ['Himachal Pradesh', 'Uttarakhand', 'Sikkim', 'Arunachal Pradesh'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which of these large Indian states has no coastline at all?', options: ['Madhya Pradesh', 'Odisha', 'Karnataka', 'West Bengal'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The red panda is the state animal of which Indian state?', options: ['Meghalaya', 'Nagaland', 'Assam', 'Sikkim'], answer: 3, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which Indian classical dance form comes from Andhra Pradesh?', options: ['Manipuri', 'Odissi', 'Kuchipudi', 'Mohiniyattam'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Odhra Magadha is regarded as the forerunner of which classical dance form?', options: ['Odissi', 'Bharatanatyam', 'Kathakali', 'Kathak'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'By what other name is the Golden Temple at Amritsar known?', options: ['Anandpur Sahib', 'Keshgarh Sahib', 'Akal Takht', 'Sri Darbar Sahib'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In the Ramayana, who was the eldest son of King Dasharatha?', options: ['Shatrughna', 'Bharata', 'Rama', 'Lakshmana'], answer: 2, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'In Hindu mythology, which god lives in a mansion called Vaijayanta?', options: ['Indra', 'Shiva', 'Varuna', 'Vishnu'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'In Hindu mythology, Swaha is the consort of which god?', options: ['Surya', 'Yama', 'Vayu', 'Agni'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'The writer Dhanpat Rai Srivastava is better known by which pen name?', options: ['Dinkar', 'Nirala', 'Premchand', 'Agyeya'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which collection of Premchand’s Urdu short stories was banned by the British?', options: ['Soz-e-Watan', 'Gaban', 'Nirmala', 'Godaan'], answer: 0, difficulty: 3, topic: 'Culture'),

  // ----------------------------------------------------------- history
  QuizQuestion(question: 'Which portfolio was Indira Gandhi given in Lal Bahadur Shastri’s government in 1964?', options: ['Home', 'External Affairs', 'Defence', 'Information and Broadcasting'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Who wrote the Gita Rahasya while imprisoned at Mandalay?', options: ['Motilal Nehru', 'Gopal Krishna Gokhale', 'Bal Gangadhar Tilak', 'Lala Lajpat Rai'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who was known as the Grand Old Man of India?', options: ['Dadabhai Naoroji', 'Surendranath Banerjee', 'Pherozeshah Mehta', 'Gopal Krishna Gokhale'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Princess Manikarnika is better known to history as whom?', options: ['Rani Padmini', 'Begum Hazrat Mahal', 'Ahilyabai Holkar', 'Rani Lakshmibai of Jhansi'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Bhavani Talwar, a famous sword, belonged to which Indian ruler?', options: ['Prithviraj Chauhan', 'Maharana Pratap', 'Shivaji', 'Tipu Sultan'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which Mughal emperor succeeded Jahangir?', options: ['Shah Jahan', 'Aurangzeb', 'Humayun', 'Akbar'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Who delivered the celebrated address at the Parliament of Religions in Chicago in 1893?', options: ['Rabindranath Tagore', 'Raja Ram Mohan Roy', 'Dayananda Saraswati', 'Swami Vivekananda'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Simla Agreement of 1972 was signed between India and which country?', options: ['Sri Lanka', 'China', 'Pakistan', 'Bangladesh'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which world leader was a defendant at the Rivonia Trial?', options: ['Nelson Mandela', 'Jomo Kenyatta', 'Kwame Nkrumah', 'Martin Luther King'], answer: 0, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The aircraft Enola Gay is remembered for which event?', options: ['The Berlin airlift', 'The first flight over the Atlantic', 'The sinking of the Bismarck', 'The bombing of Hiroshima'], answer: 3, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'The Eiffel Tower was built for the 1889 exposition marking the centenary of what?', options: ['The first railway in France', 'The Napoleonic wars', 'The French Revolution', 'The founding of Paris'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which country did Herodotus describe as possessing more wonders than any other?', options: ['Egypt', 'Greece', 'India', 'Persia'], answer: 0, difficulty: 3, topic: 'History'),

  // ----------------------------------------------------------- science
  QuizQuestion(question: 'Apart from Venus, which planet rotates from east to west?', options: ['Mars', 'Saturn', 'Jupiter', 'Uranus'], answer: 3, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Where in the human body is the stapedius, the smallest skeletal muscle, found?', options: ['The hand', 'The nose', 'The ear', 'The eye'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which gland of the body swells to produce a goitre?', options: ['Thyroid', 'Adrenal', 'Pancreas', 'Pituitary'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'What is the white of an egg properly called?', options: ['Chalaza', 'Membrane', 'Yolk', 'Albumen'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'What is a squirrel’s nest called?', options: ['A lodge', 'A warren', 'A drey', 'A sett'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'The name of which primate of Madagascar comes from a Latin word for spirits of the dead?', options: ['Lemur', 'Macaque', 'Marmoset', 'Gibbon'], answer: 0, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Calcium oxide is better known by which name?', options: ['Washing soda', 'Gypsum', 'Quicksilver', 'Quicklime'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Nutmeg is the seed of a tree with which botanical name?', options: ['Cinnamomum verum', 'Elettaria cardamomum', 'Myristica fragrans', 'Syzygium aromaticum'], answer: 2, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'The name of which spice comes from the French word for a nail?', options: ['Clove', 'Cardamom', 'Saffron', 'Cinnamon'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'What does a giant panda mostly eat?', options: ['Insects', 'Fruit', 'Fish', 'Bamboo'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which is the second largest living bird after the ostrich?', options: ['Penguin', 'Cassowary', 'Emu', 'Rhea'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'How far can a fully grown ostrich fly?', options: ['It cannot fly at all', 'About ten kilometres', 'Only when young', 'About a kilometre'], answer: 0, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'The term black panther is usually applied to a dark-coated form of which animal?', options: ['Lion', 'Lynx', 'Cheetah', 'Leopard'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Mammuthus is the extinct genus related to which animal of today?', options: ['Camel', 'Rhinoceros', 'Elephant', 'Hippopotamus'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'The three kinds of honeybee in a hive are drones, queens and what?', options: ['Workers', 'Guards', 'Nurses', 'Scouts'], answer: 0, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Is it easier to float in a swimming pool or in the sea?', options: ['There is no difference', 'A pool, because it is still', 'A swimming pool', 'The sea, because of the salt'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'What are the sharp thin leaves of a pine or fir tree called?', options: ['Spines', 'Blades', 'Needles', 'Fronds'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which NASA astronaut went to school in Karnal, Haryana?', options: ['Kalpana Chawla', 'Rakesh Sharma', 'Raja Chari', 'Sunita Williams'], answer: 0, difficulty: 2, topic: 'Science'),

  // --------------------------------------------------------- geography
  QuizQuestion(question: 'Which mountain is known as the Savage Mountain for the difficulty of its ascent?', options: ['Annapurna', 'Nanga Parbat', 'Kanchenjunga', 'K2'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Which desert covers most of northern Africa?', options: ['Danakil', 'Kalahari', 'Sahara', 'Namib'], answer: 2, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which African river takes its name from a Tonga phrase meaning great river?', options: ['Zambezi', 'Orange', 'Congo', 'Limpopo'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which country’s name begins with E and ends with T?', options: ['Estonia', 'Eritrea', 'Ecuador', 'Egypt'], answer: 3, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'In which country was Alfred Nobel born?', options: ['Finland', 'Norway', 'Sweden', 'Denmark'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'What are the lines on a map joining places of equal rainfall called?', options: ['Isohyets', 'Contours', 'Isotherms', 'Isobars'], answer: 0, difficulty: 3, topic: 'Geography'),

  // ------------------------------------------------------------- sport
  QuizQuestion(question: 'Who was India’s first Formula One driver?', options: ['Jehan Daruvala', 'Armaan Ebrahim', 'Karun Chandhok', 'Narain Karthikeyan'], answer: 3, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Before joining the police, Kiran Bedi was a champion in which sport?', options: ['Swimming', 'Badminton', 'Tennis', 'Athletics'], answer: 2, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'Who captained Pakistan to victory in the 1992 Cricket World Cup?', options: ['Imran Khan', 'Wasim Akram', 'Inzamam-ul-Haq', 'Javed Miandad'], answer: 0, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'In cricket, wides, no balls and byes are all recorded under which heading?', options: ['Sundries only in Australia', 'Overthrows', 'Penalties', 'Extras'], answer: 3, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'The Border–Gavaskar Trophy is contested between Australia and which country?', options: ['Pakistan', 'England', 'India', 'South Africa'], answer: 2, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Who was the first Swedish man ranked world number one in tennis in the Open era?', options: ['Björn Borg', 'Stefan Edberg', 'Thomas Johansson', 'Mats Wilander'], answer: 0, difficulty: 3, topic: 'Sport'),
  QuizQuestion(question: 'A contract for which footballer was famously first written on a paper napkin in Barcelona in 2000?', options: ['Xavi', 'Andrés Iniesta', 'Ronaldinho', 'Lionel Messi'], answer: 3, difficulty: 3, topic: 'Sport'),

  // ------------------------------------------------- films and music
  QuizQuestion(question: 'Who composed the music for the 1969 film Goopy Gyne Bagha Byne?', options: ['Hemant Kumar', 'Ravi Shankar', 'Satyajit Ray', 'Salil Chowdhury'], answer: 2, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'The actor Ashok Kumar was affectionately known by which name?', options: ['Dadamoni', 'Bhai Sahab', 'Babu Moshai', 'Dilip Saab'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which cricketer played the lead in the 1980 Marathi film Savli Premachi?', options: ['Dilip Vengsarkar', 'Ajit Wadekar', 'Kapil Dev', 'Sunil Gavaskar'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which Salman Khan film was released abroad under the English title When Love Calls?', options: ['Biwi No. 1', 'Hum Aapke Hain Koun', 'Maine Pyar Kiya', 'Saajan'], answer: 2, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'The actress Kajol is the elder daughter of which actress?', options: ['Tanuja', 'Shobhana Samarth', 'Nanda', 'Nutan'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which tabla player composed the music for the film Mr and Mrs Iyer?', options: ['Bickram Ghosh', 'Shivkumar Sharma', 'Alla Rakha', 'Zakir Hussain'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Raga Mala is the autobiography of which Indian musician?', options: ['Vilayat Khan', 'Ali Akbar Khan', 'Ravi Shankar', 'Bismillah Khan'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which sarod player, born in Gwalior in 1945, is the son of Hafiz Ali Khan?', options: ['Amjad Ali Khan', 'Bahadur Khan', 'Buddhadev Das Gupta', 'Ali Akbar Khan'], answer: 0, difficulty: 3, topic: 'Film music'),

  // ------------------------------------------------- words and the world
  QuizQuestion(question: 'Complete Einstein’s remark: “The important thing is not to stop …”', options: ['thinking', 'dreaming', 'wishing', 'questioning'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'A parasol is a kind of what?', options: ['Hat', 'Shoe', 'Umbrella', 'Bracelet'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'What is a cruciverbalist good at?', options: ['Solving crosswords', 'Public speaking', 'Carving wood', 'Walking a tightrope'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which word describes a recurring urge to steal?', options: ['Insomnia', 'Claustrophobia', 'Pyromania', 'Kleptomania'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which geometric word comes from Latin words meaning around and to carry?', options: ['Radius', 'Diameter', 'Circumference', 'Perimeter'], answer: 2, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'What is the last letter of the Greek alphabet?', options: ['Omega', 'Sigma', 'Delta', 'Alpha'], answer: 0, difficulty: 2, topic: 'Teaching'),
  QuizQuestion(question: 'How many zeroes are there in ten crore?', options: ['Six', 'Seven', 'Eight', 'Nine'], answer: 2, difficulty: 2, topic: 'Maths'),
  QuizQuestion(question: 'How many days are there in 144 hours?', options: ['Four', 'Five', 'Six', 'Seven'], answer: 2, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'How many yolks would a dozen ordinary chicken eggs give?', options: ['Twenty-four', 'Ten', 'Six', 'Twelve'], answer: 3, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which pen name did the writer William Sydney Porter use?', options: ['Lewis Carroll', 'Mark Twain', 'O. Henry', 'Saki'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which US president was awarded a Pulitzer Prize?', options: ['John F. Kennedy', 'Woodrow Wilson', 'Harry Truman', 'Theodore Roosevelt'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'In Alice’s Adventures in Wonderland, which game is played with hedgehogs for balls?', options: ['Cricket', 'Bowls', 'Chess', 'Croquet'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Who lives at 221B Baker Street?', options: ['Philip Marlowe', 'Hercule Poirot', 'Sherlock Holmes', 'Father Brown'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In which village does Agatha Christie’s Miss Marple live?', options: ['St Mary Mead', 'Little Paxford', 'Midsomer', 'Ambridge'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which character in Shakespeare’s Othello plots against the hero?', options: ['Cassio', 'Malvolio', 'Shylock', 'Iago'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Robinson Crusoe’s companion on the island was called what?', options: ['Saturday', 'Sunday', 'Friday', 'Monday'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Robin Hood’s band of outlaws is known as what?', options: ['The Merry Men', 'The Forest Men', 'The Free Men', 'The Bold Men'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In Jack and the Beanstalk, what was Milky White?', options: ['The beanstalk', 'A magic bean', 'The giant’s harp', 'The cow'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In which park do Yogi Bear and Boo Boo live?', options: ['Riverdale Park', 'Yellowstone Park', 'Jellystone Park', 'Hunnypot Park'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which park did John Hammond build on Isla Nublar?', options: ['Jurassic Park', 'Lost World Park', 'Adventure Park', 'Wonder Park'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What is the day after Christmas Day popularly called?', options: ['Saint Stephen’s Eve', 'New Year’s Eve', 'Twelfth Night', 'Boxing Day'], answer: 3, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'The Scout motto “Be Prepared” was chosen because it matches what?', options: ['The first Scout camp’s name', 'A line from a poem', 'The initials of its founder, B-P', 'An old military order'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'What colour is the background of the flag of the United Nations?', options: ['Light blue', 'Dark green', 'Grey', 'White'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'What colour is the Golden Gate Bridge in San Francisco?', options: ['Silver', 'Red', 'Gold', 'Orange'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Does the Statue of Liberty wear a cap, a crown or a garland?', options: ['Nothing at all', 'A cap', 'A crown', 'A garland'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which dish takes its name from a Chinese phrase meaning mixed bits?', options: ['Chop suey', 'Dim sum', 'Spring roll', 'Chow mein'], answer: 0, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Jeans were originally sold under which name?', options: ['Miner’s trousers', 'Blue drills', 'Work breeches', 'Waist overalls'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which woman became the first chief minister of Rajasthan?', options: ['Rabri Devi', 'Sheila Dikshit', 'Vasundhara Raje', 'Sucheta Kripalani'], answer: 2, difficulty: 3, topic: 'General'),
];
