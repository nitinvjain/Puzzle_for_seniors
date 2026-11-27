/// A second batch from the televised archive: thirteen more episode pages.
///
/// Same rule as quiz_bank_kbc_archive.dart. Facts taken, wording and every
/// option written here, and anything that depends on recent learning left
/// where it was -- which on these pages was most of it.
///
/// Five were dropped because the archive itself was wrong or unusable, not
/// because of the filter:
///
///   * one page answered a question about a Chief Minister with a state
///     that does not match the person it describes;
///   * one named a hill station for a geographical-indication strawberry
///     that belongs to a different one;
///   * one named the wrong UN Secretary-General as a Nobel laureate;
///   * one asked which tigress was known as Avni and gave the answer Avni;
///   * one asked for banknotes in order of size, where two of the four are
///     too close to separate.
///
/// Where a fetch flagged its own answer as doubtful, the item was dropped
/// rather than checked and kept. These are for a man who will believe what
/// the screen tells him.
///
/// Answer positions cycle 0, 1, 2, 3.
library;

import 'quiz_question.dart';

const List<QuizQuestion> kbcArchive2Questions = [
  QuizQuestion(question: 'Which of these north-eastern states does not share a border with Myanmar?', options: ['Meghalaya', 'Nagaland', 'Manipur', 'Mizoram'], answer: 0, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which Hindi expression means to lose one\'s temper?', options: ['Haath malna', 'Lal peela hona', 'Sir chadhna', 'Kaan bharna'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these organs does a person have only one of?', options: ['The kidney', 'The lung', 'The liver', 'The eye'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Nautanki, Tamasha and Jatra are all forms of what?', options: ['Classical dance', 'Temple music', 'Puppetry', 'Folk theatre'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'If someone is looking into a darpan, what are they looking at?', options: ['A mirror', 'A window', 'A lamp', 'A book'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which girl\'s name means morning in Hindi?', options: ['Sandhya', 'Usha', 'Nisha', 'Vasudha'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In which sport may a player not raise the stick above the shoulder?', options: ['Cricket', 'Golf', 'Hockey', 'Baseball'], answer: 2, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Which classic Hindi novel tells of a prince of Naugarh and a princess of Vijaygarh?', options: ['Devdas', 'Godaan', 'Gaban', 'Chandrakanta'], answer: 3, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'The Ramayana is divided into kands. What are the divisions of the Mahabharata called?', options: ['Parvas', 'Sargas', 'Adhyayas', 'Skandhas'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is fried rather than baked?', options: ['Naan', 'Puri', 'Bread', 'Biscuit'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Krishi Bhawan in Delhi houses which ministry?', options: ['Railways', 'Defence', 'Agriculture', 'Finance'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Citizens of which of these countries cannot picnic on a beach at home?', options: ['Sri Lanka', 'Bangladesh', 'Oman', 'Afghanistan'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'Kala namak, the salt used in chaat, is of which colour?', options: ['Black', 'Blue', 'Green', 'Red'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Pukhraj, manikya and gomed are kinds of what?', options: ['Spices', 'Gemstones', 'Fabrics', 'Grains'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'A shortage of which vitamin causes night blindness?', options: ['Vitamin C', 'Vitamin D', 'Vitamin A', 'Vitamin K'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'MICR and IFSC codes are printed on what?', options: ['A passport', 'A ration card', 'A railway ticket', 'A cheque'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'The gharial is named for the pot-like shape of which part of it?', options: ['Its snout', 'Its tail', 'Its back', 'Its feet'], answer: 0, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'An IMEI number identifies which device?', options: ['A television', 'A mobile telephone', 'A refrigerator', 'A motor car'], answer: 1, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Section 144, the order against unlawful assembly, comes from which code?', options: ['The Indian Penal Code', 'The Evidence Act', 'The Code of Criminal Procedure', 'The Constitution'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'In a blood group, what do the plus and minus signs refer to?', options: ['The haemoglobin count', 'The platelet count', 'The blood pressure', 'The Rh factor'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Sage Agastya is said to have told which mountain range not to grow until he returned?', options: ['The Vindhyas', 'The Aravallis', 'The Satpuras', 'The Nilgiris'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Bikram Sambat is the official calendar of which country?', options: ['Bhutan', 'Nepal', 'Sri Lanka', 'Myanmar'], answer: 1, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The sweet barfi takes its name from a Persian word meaning what?', options: ['Sugar', 'Milk', 'Snow', 'Gold'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'LAN is a kind of what?', options: ['Printing press', 'Camera lens', 'Radio band', 'Computer network'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Muharram, Safar, Rajab and Ramadan are what?', options: ['Months', 'Festivals', 'Prayers', 'Cities'], answer: 0, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which organ produces bile?', options: ['The kidney', 'The liver', 'The spleen', 'The pancreas'], answer: 1, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which Hindi phrase describes someone sweet in speech but harmful in intent?', options: ['Kaali zubaan', 'Khoti bhasha', 'Meethi chhuri', 'Sookha wada'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'What is the taste of pure water?', options: ['Slightly sweet', 'Slightly salty', 'Slightly sour', 'It has none'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which of these cities does not host a tennis Grand Slam?', options: ['Sydney', 'Melbourne', 'Paris', 'London'], answer: 0, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'In Hindu mythology, who was the son of Krishna and Rukmini?', options: ['Samba', 'Pradyumna', 'Abhimanyu', 'Aniruddha'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'The Cassini-Huygens mission was sent chiefly to study which planet?', options: ['Jupiter', 'Mars', 'Saturn', 'Venus'], answer: 2, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'In tailoring, a fall is stitched to which garment?', options: ['A turban', 'A shawl', 'A shirt', 'A saree'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Ballpoint, gel and fountain are kinds of what?', options: ['Pen', 'Pencil', 'Ink', 'Paper'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which two creatures race in the best known fable about persistence?', options: ['The fox and the crow', 'The hare and the tortoise', 'The lion and the mouse', 'The ant and the grasshopper'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'On the Internet, what does error 404 mean?', options: ['No connection', 'Access denied', 'Page not found', 'Server busy'], answer: 2, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which Sanskrit blessing wishes someone victory?', options: ['Ayushman bhava', 'Deerghayu bhava', 'Sukhi bhava', 'Vijayi bhava'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Which of these is a major kharif crop?', options: ['Paddy', 'Wheat', 'Mustard', 'Barley'], answer: 0, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'In the dohas, what does the word sumiran mean?', options: ['To forgive', 'To remember', 'To travel', 'To give'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Jharkhand was created on the birth anniversary of which tribal leader?', options: ['Sidhu Murmu', 'Tantya Bhil', 'Birsa Munda', 'Tilka Manjhi'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which creature can live for a week or more without its head?', options: ['The earthworm', 'The snail', 'The frog', 'The cockroach'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which poet wrote the line Sinhasan khali karo ki janta aati hai?', options: ['Ramdhari Singh Dinkar', 'Sumitranandan Pant', 'Mahadevi Verma', 'Harivansh Rai Bachchan'], answer: 0, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Bhishma, Karna and Dronacharya were all taught by whom?', options: ['Vishwamitra', 'Parashurama', 'Vasishtha', 'Kripacharya'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which freedom leader wrote the book India Divided?', options: ['Jawaharlal Nehru', 'Maulana Azad', 'Rajendra Prasad', 'Sardar Patel'], answer: 2, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Valluvar Kottam, a memorial to a poet, is in which state?', options: ['Kerala', 'Karnataka', 'Andhra Pradesh', 'Tamil Nadu'], answer: 3, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'Who was the first woman to sit on the throne of Delhi?', options: ['Razia Sultan', 'Nur Jahan', 'Chand Bibi', 'Rani Durgavati'], answer: 0, difficulty: 1, topic: 'History'),
  QuizQuestion(question: 'The yoga posture bhujangasana is named after which creature?', options: ['The eagle', 'The snake', 'The fish', 'The camel'], answer: 1, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'A masala dosa is usually filled with what?', options: ['Paneer', 'Cauliflower', 'Potato', 'Lentils'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'A reaction that gives out heat is called what?', options: ['Endothermic', 'Isothermal', 'Catalytic', 'Exothermic'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Afzal Khan, the general of Bijapur, was killed near which fort?', options: ['Pratapgarh', 'Raigad', 'Sinhagad', 'Panhala'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'A.P.J. Abdul Kalam studied aeronautical engineering at which institute?', options: ['IIT Bombay', 'Madras Institute of Technology', 'Banaras Hindu University', 'Roorkee'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In a car, ORVM stands for outside rear view what?', options: ['Monitor', 'Module', 'Mirror', 'Mount'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which number has a square root of twelve?', options: ['121', '169', '132', '144'], answer: 3, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which Indian state was formed in the twenty-first century?', options: ['Telangana', 'Haryana', 'Goa', 'Sikkim'], answer: 0, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'Which of these monuments is not in Delhi?', options: ['The Red Fort', 'The Gateway of India', 'Humayun\'s Tomb', 'The Qutub Minar'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Indigo Revolt of 1859 in Bengal was about which crop?', options: ['Jute', 'Tea', 'Indigo', 'Opium'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which particle did James Chadwick discover?', options: ['The proton', 'The electron', 'The positron', 'The neutron'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'Which of these is a branch of mathematics?', options: ['Trigonometry', 'Lexicography', 'Cartography', 'Philology'], answer: 0, difficulty: 1, topic: 'Maths'),
  QuizQuestion(question: 'Which of these is not a dairy product?', options: ['Butter', 'Honey', 'Ghee', 'Curd'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'In which decade was Mahatma Gandhi born?', options: ['The 1850s', 'The 1870s', 'The 1860s', 'The 1880s'], answer: 2, difficulty: 2, topic: 'History'),
  QuizQuestion(question: 'Which of these carries blood away from the heart?', options: ['A vein', 'A capillary', 'A nerve', 'An artery'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'AS Roma and Fiorentina are football clubs of which country?', options: ['Italy', 'Spain', 'Portugal', 'France'], answer: 0, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'King\'s Cross railway station is in which city?', options: ['Edinburgh', 'London', 'Dublin', 'Manchester'], answer: 1, difficulty: 1, topic: 'Geography'),
  QuizQuestion(question: 'The Borobudur temple is in which country?', options: ['Thailand', 'Cambodia', 'Indonesia', 'Sri Lanka'], answer: 2, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'The Indian Air Force motto Nabhah Sparsham Deeptam is taken from which text?', options: ['The Rig Veda', 'The Ramayana', 'The Upanishads', 'The Bhagavad Gita'], answer: 3, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Where in Delhi was Bahadur Shah Zafar arrested in 1857?', options: ['Humayun\'s Tomb', 'The Red Fort', 'Jama Masjid', 'Purana Qila'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In colloquial Hindi, which animal\'s name is used for the trigger of a gun?', options: ['Hathi', 'Ghoda', 'Sher', 'Baagh'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which common substance is made only of hydrogen and oxygen?', options: ['Salt', 'Sugar', 'Water', 'Chalk'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Kohima is the capital of which state?', options: ['Mizoram', 'Tripura', 'Manipur', 'Nagaland'], answer: 3, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'A ribbon of which colour is the worldwide symbol for breast cancer awareness?', options: ['Pink', 'Red', 'Yellow', 'Blue'], answer: 0, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Yashwantrao Chavan was the first Chief Minister of which state?', options: ['Gujarat', 'Maharashtra', 'Karnataka', 'Madhya Pradesh'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which of these travels fastest?', options: ['Sound', 'A jet aircraft', 'Light', 'A bullet'], answer: 2, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Rani Lakshmibai of Jhansi was born in which city?', options: ['Jhansi', 'Gwalior', 'Kanpur', 'Varanasi'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'The Chandra X-ray Observatory is named after which scientist?', options: ['Subrahmanyan Chandrasekhar', 'C.V. Raman', 'Homi Bhabha', 'Vikram Sarabhai'], answer: 0, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Ganesh Chaturthi falls in which month of the Hindu calendar?', options: ['Chaitra', 'Bhadrapada', 'Kartik', 'Shravan'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'Which of these islands is not in the Bay of Bengal?', options: ['Havelock', 'Little Andaman', 'Minicoy', 'Car Nicobar'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Mark Twain wrote that which city was older than history, tradition and legend together?', options: ['Patna', 'Ujjain', 'Madurai', 'Varanasi'], answer: 3, difficulty: 2, topic: 'General'),
  QuizQuestion(question: 'Which landmark case was heard by the largest bench the Supreme Court has ever assembled, of thirteen judges?', options: ['The Kesavananda Bharati case', 'The Shah Bano case', 'The Golaknath case', 'The Minerva Mills case'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'In the compound kaam-kaaj, what is the relation between the two words?', options: ['They are opposites', 'Both mean the same thing', 'One is a verb', 'One is a place'], answer: 1, difficulty: 3, topic: 'Culture'),
  QuizQuestion(question: 'What is traditionally applied along with kumkum when a tilak is put on?', options: ['Turmeric', 'Ash', 'Rice', 'Sandalwood paste'], answer: 2, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'How many queens did King Dasharatha have in the Ramayana?', options: ['Two', 'Four', 'Five', 'Three'], answer: 3, difficulty: 1, topic: 'Culture'),
  QuizQuestion(question: 'Which part of the aloe vera plant is used in ointments?', options: ['The leaves', 'The roots', 'The flowers', 'The seeds'], answer: 0, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'In which sport are players called raiders and defenders?', options: ['Kho kho', 'Kabaddi', 'Wrestling', 'Boxing'], answer: 1, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Which of these states is larger in area than West Bengal?', options: ['Kerala', 'Haryana', 'Chhattisgarh', 'Punjab'], answer: 2, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Which four-figure number is known as Kaprekar\'s constant?', options: ['1729', '1089', '2520', '6174'], answer: 3, difficulty: 3, topic: 'Maths'),
  QuizQuestion(question: 'Complete the Sikh call: Jo bole so nihal, ______', options: ['Sat Sri Akal', 'Waheguru ji', 'Deg Teg Fateh', 'Chardi Kala'], answer: 0, difficulty: 2, topic: 'Culture'),
  QuizQuestion(question: 'In an Indian kitchen, what is a belan used for?', options: ['Grinding spices', 'Rolling out dough', 'Straining tea', 'Lifting a pan'], answer: 1, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which sport is played indoors because even a light breeze affects it?', options: ['Basketball', 'Table tennis', 'Badminton', 'Squash'], answer: 2, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Which creature breathes through its skin?', options: ['The snail', 'The spider', 'The ant', 'The earthworm'], answer: 3, difficulty: 2, topic: 'Science'),
  QuizQuestion(question: 'At which South African station was Gandhi thrown off a train in 1893?', options: ['Pietermaritzburg', 'Durban', 'Pretoria', 'Johannesburg'], answer: 0, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which Mughal ruler gave Ram Mohan Roy the title Raja?', options: ['Bahadur Shah Zafar', 'Akbar II', 'Shah Alam II', 'Aurangzeb'], answer: 1, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Kala jamun, gulab jamun and shrikhand are all what?', options: ['Pickles', 'Breads', 'Sweets', 'Drinks'], answer: 2, difficulty: 1, topic: 'General'),
  QuizQuestion(question: 'Which of these settles at the bottom when stirred into water?', options: ['Salt', 'Sugar', 'Lemon juice', 'Sand'], answer: 3, difficulty: 1, topic: 'Science'),
  QuizQuestion(question: 'Which of these rivers does not rise from a glacier?', options: ['The Narmada', 'The Ganga', 'The Yamuna', 'The Brahmaputra'], answer: 0, difficulty: 2, topic: 'Geography'),
  QuizQuestion(question: 'How tall is the Statue of Unity?', options: ['108 metres', '182 metres', '240 metres', '151 metres'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'Bharatendu Harishchandra\'s Durlabh Bandhu was a translation of which play?', options: ['Hamlet', 'Macbeth', 'The Merchant of Venice', 'King Lear'], answer: 2, difficulty: 3, topic: 'General'),
  QuizQuestion(question: 'Which Nobel laureate of Indian origin is credited with building the first artificial gene?', options: ['C.V. Raman', 'S. Chandrasekhar', 'Venkatraman Ramakrishnan', 'Har Gobind Khorana'], answer: 3, difficulty: 3, topic: 'Science'),
  QuizQuestion(question: 'Which of these is a punch in boxing?', options: ['The uppercut', 'The backhand', 'The volley', 'The smash'], answer: 0, difficulty: 1, topic: 'Sport'),
  QuizQuestion(question: 'Alang in Gujarat is the world\'s largest centre for what?', options: ['Cutting diamonds', 'Breaking up ships', 'Weaving silk', 'Refining salt'], answer: 1, difficulty: 3, topic: 'Geography'),
  QuizQuestion(question: 'India\'s first woman Olympic medallist won her medal in which sport?', options: ['Badminton', 'Wrestling', 'Weightlifting', 'Boxing'], answer: 2, difficulty: 2, topic: 'Sport'),
  QuizQuestion(question: 'Sultan Ahmad Shah founded which city in 1411?', options: ['Surat', 'Bhopal', 'Hyderabad', 'Ahmedabad'], answer: 3, difficulty: 3, topic: 'History'),
  QuizQuestion(question: 'Which pair of famous buildings stands closest together?', options: ['The Taj Mahal and Fatehpur Sikri', 'The Taj Mahal and the Red Fort', 'The Qutub Minar and the Gateway of India', 'Sanchi and Khajuraho'], answer: 0, difficulty: 3, topic: 'Geography'),
];
