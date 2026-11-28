/// A hundred questions on the three things he knows best.
///
/// NJ asked for Jain dharma, teaching, and Baraut and Baoli. All three are
/// remote memory -- faith learnt as a child, a trade practised for a
/// working lifetime, a village lived in -- and remote memory is the last
/// thing vascular dementia takes. A man who cannot say what he had for
/// breakfast can still say which tehsil his village is in.
///
/// They carry their own topic labels, which the screen prints above each
/// question: JAIN DHARMA, TEACHING, BARAUT. The topic is a plain string
/// used for spacing questions apart within a round and for that label, so
/// new ones cost nothing.
///
/// Deliberately weighted easy -- 58 of the 100 at the first level. A wrong
/// answer ends the round, so a question tagged hard sits at a rung he may
/// never reach, and the whole point of these is that he meets them. Only
/// the genuinely obscure stay at the third level.
///
/// On the sources. The Jain questions are matters of settled doctrine and
/// tradition. The Baraut and Baghpat ones were looked up rather than
/// recalled: the district and its tehsils, the rivers, the crop, the
/// distances, Janta Vedic College, the Bada Jain Mandir's tirthankara,
/// Barnawa and the Lakshagriha, Chaudhary Charan Singh's seat, the Sinauli
/// burials, Sah Mal in 1857, and Subhas Chandra Bose coming to Baraut to
/// recruit. Two rest on the village's own account of itself rather than on
/// a hard source -- that Baoli was first called Bahubali, and the reading
/// of Baraut's name as the place of banyan trees -- and both are worded as
/// what is said rather than as fact. If NJ's father knows them otherwise,
/// his version is the better one and they should be changed.
///
/// Answer positions cycle 0, 1, 2, 3.
library;

import 'quiz_question.dart';

const List<QuizQuestion> homeQuestions = [
  QuizQuestion(question: 'How many tirthankaras are there in the present age?', options: ['Twenty-four', 'Twelve', 'Sixteen', 'Eighteen'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Who was the first tirthankara?', options: ['Mahavira', 'Rishabhanatha', 'Parshvanatha', 'Neminatha'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'By what other name is Rishabhanatha known?', options: ['Shantinatha', 'Ajitanatha', 'Adinatha', 'Suparshvanatha'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Who was the twenty-fourth and last tirthankara?', options: ['Parshvanatha', 'Rishabhanatha', 'Neminatha', 'Mahavira'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Who was the twenty-third tirthankara?', options: ['Parshvanatha', 'Mahavira', 'Neminatha', 'Mallinatha'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which emblem belongs to Bhagwan Mahavira?', options: ['The bull', 'The lion', 'The serpent', 'The elephant'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which emblem belongs to Bhagwan Parshvanatha?', options: ['The lion', 'The bull', 'The serpent', 'The deer'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which emblem belongs to Bhagwan Rishabhanatha?', options: ['The lion', 'The horse', 'The serpent', 'The bull'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which principle stands first in Jain conduct?', options: ['Ahimsa', 'Daan', 'Tapa', 'Puja'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What does the saying Ahimsa Parmo Dharma mean?', options: ['Truth is the highest religion', 'Non-violence is the highest religion', 'Charity is the highest religion', 'Knowledge is the highest religion'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which Jain doctrine holds that truth has many sides?', options: ['Aparigraha', 'Brahmacharya', 'Anekantavada', 'Samyak charitra'], answer: 2, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which Jain vow means not hoarding possessions?', options: ['Asteya', 'Satya', 'Ahimsa', 'Aparigraha'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which Jain vow means not taking what is not given?', options: ['Asteya', 'Satya', 'Aparigraha', 'Ahimsa'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'How many great vows does a Jain monk take?', options: ['Three', 'Five', 'Seven', 'Twelve'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What are the three jewels of Jainism?', options: ['Right speech, right thought and right action', 'Charity, penance and prayer', 'Right faith, right knowledge and right conduct', 'Body, mind and soul'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which prayer do Jains recite before all others?', options: ['The Bhaktamar Stotra', 'The Tattvartha Sutra', 'The Kalpa Sutra', 'The Namokar Mantra'], answer: 3, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'To how many supreme beings does the Namokar Mantra bow?', options: ['Five', 'Three', 'Four', 'Nine'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What are those five supreme beings called together?', options: ['The Panch Mahavrata', 'The Panch Parmeshthi', 'The Panch Anuvrata', 'The Panch Kalyanak'], answer: 1, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which words do Jains say to one another asking forgiveness?', options: ['Jai Jinendra', 'Namo Arihantanam', 'Michhami Dukkadam', 'Om Shanti'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which Jain festival is kept above all as a time of forgiveness?', options: ['Holi', 'Navratri', 'Baisakhi', 'Paryushan'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'How many days does the Digambara Das Lakshana festival last?', options: ['Ten', 'Eight', 'Five', 'Fifteen'], answer: 0, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which night do Jains keep as the nirvana of Bhagwan Mahavira?', options: ['Holi', 'Diwali', 'Dussehra', 'Shivratri'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'In which month of the Hindu calendar does Mahavir Jayanti fall?', options: ['Kartik', 'Shravan', 'Chaitra', 'Magh'], answer: 2, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What are the two great sects of Jainism?', options: ['Shaiva and Vaishnava', 'Nirgrantha and Ajivika', 'Sthanakvasi and Terapanthi', 'Digambara and Svetambara'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What is the soft whisk of peacock feathers a Digambara monk carries called?', options: ['A picchi', 'A kamandalu', 'A mala', 'A danda'], answer: 0, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Why does a Jain monk sweep the ground before him as he walks?', options: ['To keep the path clean', 'So as not to tread on small creatures', 'As a mark of humility', 'To mark his way'], answer: 1, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Whose great statue stands at Shravanabelagola?', options: ['Mahavira', 'Rishabhanatha', 'Bahubali', 'Parshvanatha'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Bahubali was the son of which tirthankara?', options: ['Mahavira', 'Parshvanatha', 'Neminatha', 'Rishabhanatha'], answer: 3, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'At which place did Bhagwan Mahavira attain nirvana?', options: ['Pavapuri', 'Vaishali', 'Sarnath', 'Girnar'], answer: 0, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'On which hill in Jharkhand did twenty of the tirthankaras attain moksha?', options: ['Girnar', 'Sammed Shikharji', 'Shatrunjaya', 'Mount Abu'], answer: 1, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'The Dilwara temples stand on which mountain?', options: ['Girnar', 'Shatrunjaya', 'Mount Abu', 'Parasnath'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'The Palitana temples, on Shatrunjaya hill, are in which state?', options: ['Rajasthan', 'Karnataka', 'Maharashtra', 'Gujarat'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Who wrote the Tattvartha Sutra?', options: ['Umaswami', 'Kundakunda', 'Hemachandra', 'Bhadrabahu'], answer: 0, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What does the Jain motto Parasparopagraho Jivanam mean?', options: ['All life is sacred', 'Souls render service to one another', 'Truth alone triumphs', 'Non-violence is the highest duty'], answer: 1, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Which word appears on the open palm in the Jain emblem?', options: ['Satya', 'Shanti', 'Ahimsa', 'Dharma'], answer: 2, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'In Jain thought, what is the word for the living soul?', options: ['Ajiva', 'Karma', 'Moksha', 'Jiva'], answer: 3, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'In Jain belief, what is the final release of the soul called?', options: ['Moksha', 'Karma', 'Samsara', 'Dharma'], answer: 0, difficulty: 1, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Why do many Jains not eat root vegetables?', options: ['They are hard to digest', 'Pulling up the root kills the whole plant', 'They are costly', 'They may not be offered in a temple'], answer: 1, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'Why do strict Jains finish their meal before sunset?', options: ['Because the food goes cold', 'Because it is the custom at temples', 'To avoid harming the tiny creatures that come out at night', 'To save lamp oil'], answer: 2, difficulty: 2, topic: 'Jain Dharma'),
  QuizQuestion(question: 'What is the four-month season called when Jain monks stay in one place?', options: ['Paryushan', 'Samvatsari', 'Ekadashi', 'Chaturmas'], answer: 3, difficulty: 3, topic: 'Jain Dharma'),
  QuizQuestion(question: 'The five steps of a lesson plan are named after which teacher of teachers?', options: ['Herbart', 'Froebel', 'Dewey', 'Pestalozzi'], answer: 0, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'Which maxim of teaching says a lesson should begin with what the pupil already knows?', options: ['From the whole to the part', 'From the known to the unknown', 'From far to near', 'From the difficult to the easy'], answer: 1, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'Which maxim says a child should handle real things before dealing in ideas?', options: ['From the general to the particular', 'From the part to the whole', 'From the concrete to the abstract', 'From the far to the near'], answer: 2, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'A lesson that goes from simple examples to a general rule is said to follow which method?', options: ['The deductive method', 'The lecture method', 'The project method', 'The inductive method'], answer: 3, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'A lesson that states the rule first and then applies it follows which method?', options: ['The deductive method', 'The inductive method', 'The heuristic method', 'The play-way method'], answer: 0, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'In mathematics, the method that begins from what is to be proved and works backwards is called what?', options: ['The synthetic method', 'The analytic method', 'The inductive method', 'The project method'], answer: 1, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'In mathematics, the method that begins from what is known and works forward to the result is called what?', options: ['The analytic method', 'The deductive method', 'The synthetic method', 'The heuristic method'], answer: 2, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'Which method has pupils learn by finding things out for themselves, as a small discoverer would?', options: ['The lecture method', 'The drill method', 'The dictation method', 'The heuristic method'], answer: 3, difficulty: 2, topic: 'Teaching'),
  QuizQuestion(question: 'Who gave teaching the project method?', options: ['Kilpatrick', 'Herbart', 'Montessori', 'Armstrong'], answer: 0, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'Who founded the kindergarten?', options: ['Montessori', 'Froebel', 'Dewey', 'Pestalozzi'], answer: 1, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'The method of teaching by putting one question after another is named after which philosopher?', options: ['Plato', 'Aristotle', 'Socrates', 'Confucius'], answer: 2, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the written plan a teacher prepares for one period called?', options: ['A syllabus', 'A timetable', 'A register', 'A lesson plan'], answer: 3, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is it called when a trainee teacher practises a single skill on a small group for a few minutes?', options: ['Micro-teaching', 'Team teaching', 'Remedial teaching', 'Supervised study'], answer: 0, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'A short test given during the term, to see how the teaching is going, is called what?', options: ['A summative test', 'A formative test', 'A board examination', 'An entrance test'], answer: 1, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'The examination at the end of the course, which decides the result, is called what?', options: ['A formative test', 'A diagnostic test', 'A summative examination', 'A unit test'], answer: 2, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is a test called that is set to find out exactly where a pupil\'s difficulty lies?', options: ['An aptitude test', 'An achievement test', 'A unit test', 'A diagnostic test'], answer: 3, difficulty: 2, topic: 'Teaching'),
  QuizQuestion(question: 'What is the extra teaching given afterwards to pupils who have not followed the lesson called?', options: ['Remedial teaching', 'Micro-teaching', 'Team teaching', 'Revision'], answer: 0, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'Bloom\'s levels of learning begin with which one?', options: ['Analysis', 'Knowledge', 'Evaluation', 'Application'], answer: 1, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'In teaching, what do the letters TLM stand for?', options: ['Total learning method', 'Teacher led marking', 'Teaching learning material', 'Timed lesson module'], answer: 2, difficulty: 3, topic: 'Teaching'),
  QuizQuestion(question: 'What is the part of the blackboard kept for the main points of the lesson called?', options: ['The margin', 'The working side', 'The heading', 'The blackboard summary'], answer: 3, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the list of topics to be covered in a year called?', options: ['The syllabus', 'The timetable', 'The register', 'The lesson plan'], answer: 0, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'In which book does a teacher mark who is present and who is absent?', options: ['The log book', 'The attendance register', 'The diary', 'The record book'], answer: 1, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the chart showing which class is taught in which period called?', options: ['The syllabus', 'The register', 'The timetable', 'The calendar'], answer: 2, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the work set to be done at home called?', options: ['Classwork', 'Fieldwork', 'Handiwork', 'Homework'], answer: 3, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is an examination taken by word of mouth called?', options: ['A viva voce', 'A written paper', 'A practical', 'A project'], answer: 0, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the duty of watching over an examination hall called?', options: ['Moderation', 'Invigilation', 'Evaluation', 'Supervision of studies'], answer: 1, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is the room where teachers sit between their periods called?', options: ['The common room', 'The waiting room', 'The staff room', 'The office'], answer: 2, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'What is repeated practice of the same kind of sum until it becomes easy called?', options: ['Revision', 'Dictation', 'Recitation', 'Drill'], answer: 3, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'Charts, models and the blackboard are known together as what?', options: ['Teaching aids', 'Stationery', 'Apparatus', 'Furniture'], answer: 0, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'Going over the whole year\'s work again before the examination is called what?', options: ['Drill', 'Revision', 'Recapitulation of the lesson', 'Remedial work'], answer: 1, difficulty: 1, topic: 'Teaching'),
  QuizQuestion(question: 'Baoli village lies in which tehsil?', options: ['Khekra', 'Baghpat', 'Baraut', 'Binauli'], answer: 2, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Baraut and Baoli are in which district?', options: ['Meerut', 'Muzaffarnagar', 'Ghaziabad', 'Baghpat'], answer: 3, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Baghpat district belongs to which division of Uttar Pradesh?', options: ['Meerut', 'Agra', 'Saharanpur', 'Moradabad'], answer: 0, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'In which year was Baghpat made a district of its own?', options: ['1975', '1997', '1985', '2001'], answer: 1, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Baghpat district was carved out of which district?', options: ['Muzaffarnagar', 'Ghaziabad', 'Meerut', 'Saharanpur'], answer: 2, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'About how far is Baoli village from Baraut?', options: ['Thirty kilometres', 'Fifteen kilometres', 'Fifty kilometres', 'Three kilometres'], answer: 3, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'About how far is Baraut from Delhi?', options: ['Fifty-five kilometres', 'A hundred and fifty kilometres', 'Two hundred kilometres', 'Twenty kilometres'], answer: 0, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'The name Baraut is said to come from which tree?', options: ['The peepal', 'The banyan', 'The mango', 'The neem'], answer: 1, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'The village of Baoli is said to have first been called by which name?', options: ['Baghpat', 'Barnawa', 'Bahubali', 'Binauli'], answer: 2, difficulty: 3, topic: 'Baraut'),
  QuizQuestion(question: 'Baghpat town stands on the bank of which river?', options: ['The Ganga', 'The Hindon', 'The Kali', 'The Yamuna'], answer: 3, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Which of these rivers also flows through Baghpat district?', options: ['The Hindon', 'The Gomti', 'The Betwa', 'The Chambal'], answer: 0, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Which crop is grown most in Baghpat district?', options: ['Rice', 'Sugarcane', 'Cotton', 'Tea'], answer: 1, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Baghpat district has mills for making what from its main crop?', options: ['Paper', 'Cement', 'Sugar', 'Cloth'], answer: 2, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'How many tehsils does Baghpat district have?', options: ['Five', 'Two', 'Seven', 'Three'], answer: 3, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Which of these is a tehsil of Baghpat district?', options: ['Khekra', 'Sardhana', 'Hapur', 'Deoband'], answer: 0, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'What was the old name of Baghpat?', options: ['Indraprastha', 'Vyaghraprastha', 'Hastinapur', 'Varanavata'], answer: 1, difficulty: 3, topic: 'Baraut'),
  QuizQuestion(question: 'Baghpat district is widely known for making which household goods?', options: ['Shoes', 'Glassware', 'Bedsheets and towels', 'Brassware'], answer: 2, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Janta Vedic College at Baraut was first opened in 1917 as what?', options: ['A college', 'A library', 'A training school', 'A high school'], answer: 3, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Janta Vedic College, Baraut, is affiliated to which university?', options: ['Chaudhary Charan Singh University', 'Lucknow University', 'Aligarh Muslim University', 'Banaras Hindu University'], answer: 0, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'The Bada Jain Mandir at Baraut is dedicated to which tirthankara?', options: ['Mahavira', 'Chandraprabhu', 'Parshvanatha', 'Adinatha'], answer: 1, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Barnawa, in Baghpat district, is held to be the Lakshagriha of which epic?', options: ['The Ramayana', 'The Bhagavata', 'The Mahabharata', 'The Raghuvamsha'], answer: 2, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'What was Barnawa called in the Mahabharata?', options: ['Vyaghraprastha', 'Khandavaprastha', 'Ekachakra', 'Varanavata'], answer: 3, difficulty: 3, topic: 'Baraut'),
  QuizQuestion(question: 'Which Prime Minister of India sat in Parliament for Baghpat?', options: ['Chaudhary Charan Singh', 'Lal Bahadur Shastri', 'Morarji Desai', 'Chandra Shekhar'], answer: 0, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Chaudhary Charan Singh is remembered above all as the leader of whom?', options: ['The mill workers', 'The farmers', 'The students', 'The traders'], answer: 1, difficulty: 1, topic: 'Baraut'),
  QuizQuestion(question: 'Ajit Singh, long the member for Baghpat, was whose son?', options: ['Lal Bahadur Shastri', 'Jagjivan Ram', 'Chaudhary Charan Singh', 'Charan Das'], answer: 2, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Sinauli in Baghpat district became famous for the digging up of what?', options: ['A Mughal fort', 'A Buddhist stupa', 'A gold hoard', 'Ancient burials with carts and coffins'], answer: 3, difficulty: 3, topic: 'Baraut'),
  QuizQuestion(question: 'About how old are the Sinauli burials reckoned to be?', options: ['About four thousand years', 'About five hundred years', 'About a thousand years', 'About two hundred years'], answer: 0, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Who led the rising of 1857 in the Baghpat country?', options: ['Mangal Pandey', 'Sah Mal', 'Tatya Tope', 'Kunwar Singh'], answer: 1, difficulty: 3, topic: 'Baraut'),
  QuizQuestion(question: 'Which leader came to Baraut to enlist men for the Indian National Army?', options: ['Jawaharlal Nehru', 'Sardar Patel', 'Subhas Chandra Bose', 'Bhagat Singh'], answer: 2, difficulty: 2, topic: 'Baraut'),
  QuizQuestion(question: 'Which dialect is spoken around Baraut?', options: ['Awadhi', 'Bhojpuri', 'Braj', 'Khariboli'], answer: 3, difficulty: 2, topic: 'Baraut'),
];
