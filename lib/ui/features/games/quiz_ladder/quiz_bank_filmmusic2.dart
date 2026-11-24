/// Hindi film music, from an online Bollywood music trivia source.
///
/// 100 questions for the Film music category. As with the other outside
/// sources, the facts are used and the wording, options and distractors are
/// written here.
///
/// Corrections and omissions worth recording:
///
///   * the source spells several names loosely -- Alisha Chinai, Raam Laxman,
///     Shahrukh -- and the usual spellings are used here;
///
///   * a handful of its questions turn on things no listener would know and
///     that read as filler in a quiz (how many awards an album won, how many
///     singers were on it, the exact release date of a soundtrack). Those are
///     left out in favour of questions about the music itself;
///
///   * questions the bank already asks are skipped: who composed
///     Mughal-e-Azam, which film "Pyar Hua Ikrar Hua" comes from, and which
///     actor Kishore Kumar sang for above all.
///
/// A good part of this source is about Hindi songs modelled on Western ones.
/// Those make unusually good quiz questions -- the answer is a singer or band
/// he is likely to know from the same years -- so they are kept as a group.
library;

import 'quiz_question.dart';

const List<QuizQuestion> filmMusic2Questions = [
  // ================================================ composers and their films
  QuizQuestion(question: 'Which composer wrote the music for the 1973 film Bobby?', options: ['Shankar-Jaikishan', 'R. D. Burman', 'Kalyanji-Anandji', 'Laxmikant-Pyarelal'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Maine Pyar Kiya?', options: ['Anu Malik', 'Jatin-Lalit', 'Ram Laxman', 'Nadeem-Shravan'], answer: 2, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which composer duo scored Kuch Kuch Hota Hai, Dilwale Dulhania Le Jayenge and Mohabbatein?', options: ['Jatin-Lalit', 'Nadeem-Shravan', 'Anand-Milind', 'Dilip Sen-Sameer Sen'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Main Prem Ki Deewani Hoon?', options: ['Jatin-Lalit', 'Himesh Reshammiya', 'Rajesh Roshan', 'Anu Malik'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer wrote the score for the 1959 film Dil Deke Dekho?', options: ['O. P. Nayyar', 'Madan Mohan', 'Usha Khanna', 'Naushad'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Lage Raho Munna Bhai?', options: ['Shantanu Moitra', 'Anu Malik', 'Vishal-Shekhar', 'Pritam'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer pair wrote the music for Dil Hai Ki Manta Nahin?', options: ['Jatin-Lalit', 'Anand-Milind', 'Laxmikant-Pyarelal', 'Nadeem-Shravan'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for the film Kya Kehna?', options: ['Jatin-Lalit', 'Uttam Singh', 'Rajesh Roshan', 'Anu Malik'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer wrote the music for Aa Gale Lag Jaa in 1973?', options: ['R. D. Burman', 'S. D. Burman', 'Kalyanji-Anandji', 'Ravindra Jain'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the songs of I Hate Luv Storys?', options: ['Pritam', 'Salim-Sulaiman', 'Shankar-Ehsaan-Loy', 'Vishal-Shekhar'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer wrote the music for the film Hamesha?', options: ['Jatin-Lalit', 'Dilip Sen-Sameer Sen', 'Anu Malik', 'Rajesh Roshan'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Who composed the music for Yeh Tera Ghar Yeh Mera Ghar?', options: ['Anand-Milind', 'Anu Malik', 'Himesh Reshammiya', 'Jatin-Lalit'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer scored Kahin Pyaar Na Ho Jaaye?', options: ['Anu Malik', 'Nadeem-Shravan', 'Sanjeev-Darshan', 'Himesh Reshammiya'], answer: 3, difficulty: 3, topic: 'Film music'),

  // ============================================= singers, voices and pairings
  QuizQuestion(question: 'Lata Mangeshkar is famously said never to have sung for which music director?', options: ['Madan Mohan', 'Roshan', 'O. P. Nayyar', 'Naushad'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Roshan, of the well-known film family, worked in cinema as what?', options: ['A music director', 'A playback singer', 'A lyricist', 'A choreographer'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which actor sang in his own voice for the film Silsila?', options: ['Shashi Kapoor', 'Sanjeev Kumar', 'Rishi Kapoor', 'Amitabh Bachchan'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which two singers recorded “Pyar Hua Ikrar Hua”?', options: ['Asha Bhosle and Manna Dey', 'Geeta Dutt and Mukesh', 'Lata Mangeshkar and Manna Dey', 'Lata Mangeshkar and Mukesh'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Kajra Re” for Bunty Aur Babli?', options: ['Alisha Chinai', 'Sunidhi Chauhan', 'Shreya Ghoshal', 'Alka Yagnik'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who sang “Crazy Kiya Re” in Dhoom 2?', options: ['Alisha Chinai', 'Shreya Ghoshal', 'Alka Yagnik', 'Sunidhi Chauhan'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Maahi Ve” for Kal Ho Naa Ho?', options: ['Sunidhi Chauhan', 'Kavita Krishnamurthy', 'Sadhana Sargam', 'Alka Yagnik'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which pair of singers recorded the title song of Kuch Kuch Hota Hai?', options: ['Udit Narayan and Alka Yagnik', 'Kumar Sanu and Alka Yagnik', 'Sonu Nigam and Shreya Ghoshal', 'Abhijeet and Kavita Krishnamurthy'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which pair of singers recorded “Tujhe Dekha To” from Dilwale Dulhania Le Jayenge?', options: ['Udit Narayan and Alka Yagnik', 'Abhijeet and Sadhana Sargam', 'Sonu Nigam and Lata Mangeshkar', 'Kumar Sanu and Lata Mangeshkar'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which pair sang “Humko Humise Chura Lo” in Mohabbatein?', options: ['Sonu Nigam and Shreya Ghoshal', 'Abhijeet and Kavita Krishnamurthy', 'Udit Narayan and Lata Mangeshkar', 'Kumar Sanu and Alka Yagnik'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer provided the playback for Shah Rukh Khan in Mohabbatein?', options: ['Udit Narayan', 'Kumar Sanu', 'Sonu Nigam', 'Abhijeet'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which two singers lead the Holi song “Soni Soni” in Mohabbatein?', options: ['Kumar Sanu and Alka Yagnik', 'Sonu Nigam and Sunidhi Chauhan', 'Abhijeet and Kavita Krishnamurthy', 'Udit Narayan and Jaspinder Narula'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Ho Gaya Hai Tujhko To Pyar Sajna” in Dilwale Dulhania Le Jayenge?', options: ['Abhijeet', 'Sonu Nigam', 'Udit Narayan', 'Kumar Sanu'], answer: 2, difficulty: 3, topic: 'Film music'),

  // ========================================= songs and the films they belong to
  QuizQuestion(question: 'The song “Kajra Re” belongs to which film?', options: ['Bunty Aur Babli', 'Dhoom 2', 'Omkara', 'Bluffmaster'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The songs “Mitwa” and “Rock and Roll Soniye” come from which film?', options: ['Kabhi Khushi Kabhie Gham', 'Kal Ho Naa Ho', 'Veer-Zaara', 'Kabhi Alvida Naa Kehna'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The song “Main Yahaan Hoon” is from which film?', options: ['Swades', 'Paheli', 'Veer-Zaara', 'Kal Ho Naa Ho'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “You Are My Soniya” is from which film?', options: ['Kabhi Khushi Kabhie Gham', 'Kaho Naa... Pyaar Hai', 'Mujhse Dosti Karoge', 'Main Prem Ki Deewani Hoon'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The song “Ladki Kyon” belongs to which film?', options: ['Salaam Namaste', 'Jab We Met', 'Bunty Aur Babli', 'Hum Tum'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Chhalka Re” is from which film?', options: ['Veer-Zaara', 'Dil Chahta Hai', 'Saathiya', 'Hum Tum'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Tumhe Jo Maine Dekha” is from which film?', options: ['Main Hoon Na', 'Om Shanti Om', 'Chalte Chalte', 'Baadshah'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Teri Ore” belongs to which film?', options: ['Namastey London', 'Welcome', 'Partner', 'Singh is Kinng'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Hey Ya” is from which film?', options: ['Wake Up Sid', 'Luck By Chance', 'Karthik Calling Karthik', 'Rock On!!'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Chori Kiya Re Jiya” is from which film?', options: ['Dabangg', 'Wanted', 'Ready', 'Bodyguard'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Dhan Te Nan” belongs to which film?', options: ['Omkara', 'Ishqiya', 'Dev.D', 'Kaminey'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Didi Tera Devar Deewana” is from which film?', options: ['Hum Saath-Saath Hain', 'Biwi No. 1', 'Hum Aapke Hain Koun', 'Maine Pyar Kiya'], answer: 2, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The song “Sajde Kiye Hain Lakhon” is from which film?', options: ['Khatta Meetha', 'Action Replayy', 'Housefull', 'De Dana Dan'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Jab Mila Tu” belongs to which film?', options: ['Anjaana Anjaani', 'Bachna Ae Haseeno', 'Love Aaj Kal', 'I Hate Luv Storys'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Tumse Hi Tumse” is from which 2010 film?', options: ['Band Baaja Baaraat', 'Aisha', 'Anjaana Anjaani', 'I Hate Luv Storys'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “I’m Dog Gone Crazy” is from which film?', options: ['Action Replayy', 'Khatta Meetha', 'Tees Maar Khan', 'Blue'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The title song “Saawariya” belongs to which film?', options: ['Guzaarish', 'Devdas', 'Black', 'Saawariya'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'The song “O Mere Sapnon Ke Saudagar” is from which film?', options: ['Saajan', 'Deewana', 'Dil Hai Ki Manta Nahin', 'Aashiqui'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Jeena Pyaar Se Jeena” comes from which film?', options: ['Yeh Tera Ghar Yeh Mera Ghar', 'Hera Pheri', 'Hungama', 'Garam Masala'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “O Priya O Priya” is from which film?', options: ['Hum Dil De Chuke Sanam', 'Tere Naam', 'Pyaar Kiya To Darna Kya', 'Kahin Pyaar Na Ho Jaaye'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Haan Haan Yeh Pyaar Hai” belongs to which film?', options: ['Badshah', 'Josh', 'Dillagi', 'Duplicate'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Koi Nahin Tere Jaisa” is from which film?', options: ['Keemat', 'Khiladi', 'Jurm', 'Aflatoon'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Khud Ko Kya Samajhti Hai” belongs to which film?', options: ['Keemat', 'Aflatoon', 'Baazigar', 'Khiladi'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Suno Zara” is from which film?', options: ['Jurm', 'Bada Ghar', 'Bada Din', 'Aankhen'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Kuch Kasmein” belongs to which film?', options: ['Aankhen', 'Bada Din', 'Keemat', 'Khiladi'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Neela Dupatta Peela Suit” is from which film?', options: ['Aflatoon', 'Keemat', 'Jurm', 'Hamesha'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The song “Tera Mujhse Hai Pehle Ka Naata Koi” is from which film?', options: ['Kati Patang', 'Caravan', 'Aa Gale Lag Jaa', 'Amar Prem'], answer: 2, difficulty: 3, topic: 'Film music'),

  // ===================================== Hindi songs modelled on Western ones
  QuizQuestion(question: 'The title song of Kya Kehna follows “Oh Carol”, written and sung by whom?', options: ['Neil Sedaka', 'Paul Anka', 'Bobby Darin', 'Cliff Richard'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: '“Aate Jaate” from Maine Pyar Kiya recalls which Stevie Wonder song?', options: ['Superstition', 'Isn’t She Lovely', 'Sir Duke', 'I Just Called To Say I Love You'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “I Just Called To Say I Love You”, echoed in “Aate Jaate”?', options: ['Michael Jackson', 'Smokey Robinson', 'Stevie Wonder', 'Lionel Richie'], answer: 2, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which band’s “We Will Rock You” was borrowed for a song in the film Aflatoon?', options: ['Queen', 'The Beatles', 'The Rolling Stones', 'Pink Floyd'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which singer’s “They Don’t Really Care About Us” lies behind “Neela Dupatta Peela Suit”?', options: ['Prince', 'Stevie Wonder', 'Lionel Richie', 'Michael Jackson'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Theme For A Dream”, the model for “Pal Pal” in Lage Raho Munna Bhai?', options: ['Jim Reeves', 'Pat Boone', 'Cliff Richard', 'Elvis Presley'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “But You Love Me Daddy”, the model for the Akele Hum Akele Tum title song?', options: ['Jim Reeves', 'Cliff Richard', 'Nat King Cole', 'Bobby Darin'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer’s “Bachelor Boy” lies behind “O Mere Sapnon Ke Saudagar”?', options: ['Elvis Presley', 'Jim Reeves', 'Neil Sedaka', 'Cliff Richard'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which group recorded “Sugartime”, the model for the Dil Deke Dekho title song?', options: ['The Supremes', 'The Ronettes', 'The McGuire Sisters', 'The Andrews Sisters'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer made “The Yellow Rose of Texas” famous in the film Viva Las Vegas?', options: ['Elvis Presley', 'Johnny Cash', 'Roy Orbison', 'Bobby Darin'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which group recorded “Nina, Pretty Ballerina”, echoed in “Jeena Pyaar Se Jeena”?', options: ['The Carpenters', 'Bee Gees', 'Boney M', 'ABBA'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which guitarist’s “Maria Maria” lies behind “O Priya O Priya”?', options: ['Mark Knopfler', 'Jimi Hendrix', 'Carlos Santana', 'Eric Clapton'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Can’t Take My Eyes Off You”, borrowed for a song in Dillagi?', options: ['Frankie Valli', 'Andy Williams', 'Tom Jones', 'Engelbert Humperdinck'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Oh, Pretty Woman”, used for a number in Kal Ho Naa Ho?', options: ['Elvis Presley', 'Chuck Berry', 'Del Shannon', 'Roy Orbison'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Come September”, whose tune turns up in more than one Hindi film song?', options: ['Dean Martin', 'Frank Sinatra', 'Bobby Darin', 'Perry Como'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “You Needed Me”, the model for “Suno Zara” in Bada Din?', options: ['Anne Murray', 'Karen Carpenter', 'Olivia Newton-John', 'Linda Ronstadt'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which band recorded “Nights in White Satin”, the model for “Kuch Kasmein”?', options: ['Procol Harum', 'The Hollies', 'The Zombies', 'The Moody Blues'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'The group Rednex, whose “Cotton-Eyed Joe” was borrowed for a Keemat song, came from which country?', options: ['Germany', 'The United States', 'Sweden', 'Ireland'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Nena’s song “99 Luftballons”, borrowed for a Khiladi number, protests against what?', options: ['Nuclear weapons', 'Factory work', 'Air travel', 'Television'], answer: 0, difficulty: 3, topic: 'Film music'),

  // =================================== albums: lyricists, labels and details
  QuizQuestion(question: 'Who wrote the lyrics for Dilwale Dulhania Le Jayenge?', options: ['Sameer', 'Javed Akhtar', 'Gulzar', 'Anand Bakshi'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Who wrote the lyrics for the songs of Mohabbatein?', options: ['Javed Akhtar', 'Gulzar', 'Anand Bakshi', 'Sameer'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Who wrote the lyrics for the songs of Kuch Kuch Hota Hai?', options: ['Sameer', 'Anand Bakshi', 'Javed Akhtar', 'Gulzar'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which music label released the soundtrack of Dilwale Dulhania Le Jayenge?', options: ['Sony Music', 'YRF Music', 'T-Series', 'Sa Re Ga Ma'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which music label released the soundtrack of Kuch Kuch Hota Hai?', options: ['YRF Music', 'Tips', 'Sony Music', 'Sa Re Ga Ma'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which music label released the soundtrack of Mohabbatein?', options: ['YRF Music', 'Sa Re Ga Ma', 'Sony Music', 'T-Series'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'By what name is the title song of Kuch Kuch Hota Hai better known?', options: ['Koi Mil Gaya', 'Ladki Badi Anjaani Hai', 'Saajanji Ghar Aaye', 'Tum Paas Aaye'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which is the wedding song of Kuch Kuch Hota Hai?', options: ['Didi Tera Devar Deewana', 'Yeh Ladka Hai Deewana', 'Saajanji Ghar Aaye', 'Mehndi Laga Ke Rakhna'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which is the famous wedding song of Dilwale Dulhania Le Jayenge?', options: ['Mehndi Laga Ke Rakhna', 'Saajanji Ghar Aaye', 'Didi Tera Devar Deewana', 'Dulhe Ka Sehra'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'During which Kuch Kuch Hota Hai song does Kajol fall from her bicycle?', options: ['Tum Paas Aaye', 'Koi Mil Gaya', 'Saajanji Ghar Aaye', 'Yeh Ladka Hai Deewana'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: '“Ladki Badi Anjaani Hai” borrows a violin phrase from “Rangeela Re”, a song of which film?', options: ['Jewel Thief', 'Aradhana', 'Prem Pujari', 'Guide'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'How many songs are there on the soundtrack of Dilwale Dulhania Le Jayenge?', options: ['Five', 'Seven', 'Nine', 'Eleven'], answer: 1, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Besides Dilwale Dulhania Le Jayenge, Jatin-Lalit and Anand Bakshi also worked together on which film?', options: ['Jab Pyaar Kisise Hota Hai', 'Kuch Kuch Hota Hai', 'Raja Hindustani', 'Pardes'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singers recorded “Chali Aayee”?', options: ['Alka Yagnik and Udit Narayan', 'Shreya Ghoshal and Sonu Nigam', 'Sunidhi Chauhan and Shaan', 'Chitra and KK'], answer: 3, difficulty: 3, topic: 'Film music'),

  // ===================== classics, for a listener who grew up with the radio
  QuizQuestion(question: 'Which composer is remembered for the music of Baiju Bawra and Mother India?', options: ['Anil Biswas', 'Roshan', 'Naushad', 'C. Ramchandra'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer duo is associated with Bobby, Amar Akbar Anthony and Karz?', options: ['Laxmikant-Pyarelal', 'Shankar-Jaikishan', 'Kalyanji-Anandji', 'Jatin-Lalit'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which playback singer is remembered above all for the songs of Raj Kapoor’s films?', options: ['Mohammed Rafi', 'Manna Dey', 'Talat Mahmood', 'Mukesh'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which singer is remembered for classical-based film songs such as “Laga Chunari Mein Daag”?', options: ['Mahendra Kapoor', 'Talat Mahmood', 'Manna Dey', 'Mukesh'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which music director worked most closely with the lyricist Sahir Ludhianvi on Pyaasa?', options: ['S. D. Burman', 'Naushad', 'Madan Mohan', 'Roshan'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Mera Joota Hai Japani” for Shree 420?', options: ['Mohammed Rafi', 'Manna Dey', 'Kishore Kumar', 'Mukesh'], answer: 3, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which music director is associated with the songs of Guide and Aradhana?', options: ['Shankar-Jaikishan', 'Naushad', 'S. D. Burman', 'R. D. Burman'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer was the usual playback voice for Shammi Kapoor?', options: ['Mohammed Rafi', 'Mukesh', 'Kishore Kumar', 'Manna Dey'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer duo gave the music for Don and Qurbani?', options: ['Laxmikant-Pyarelal', 'Shankar-Jaikishan', 'Jatin-Lalit', 'Kalyanji-Anandji'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which lyricist wrote “Yeh Dosti” and most of the songs of Sholay?', options: ['Sahir Ludhianvi', 'Majrooh Sultanpuri', 'Anand Bakshi', 'Gulzar'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer is remembered for “Chalte Chalte” from Pakeezah?', options: ['Lata Mangeshkar', 'Asha Bhosle', 'Geeta Dutt', 'Suman Kalyanpur'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer wrote the music for Pakeezah?', options: ['Naushad', 'Madan Mohan', 'Roshan', 'Ghulam Mohammed'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Aaj Phir Jeene Ki Tamanna Hai” from Guide?', options: ['Geeta Dutt', 'Suman Kalyanpur', 'Lata Mangeshkar', 'Asha Bhosle'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Ek Ajnabee Haseena Se” for the film Ajnabee?', options: ['Kishore Kumar', 'Mohammed Rafi', 'Mukesh', 'Manna Dey'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer gave the music for Umrao Jaan’s ghazals in 1981?', options: ['Jaidev', 'Madan Mohan', 'Ravi', 'Khayyam'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded the ghazals of Umrao Jaan in 1981?', options: ['Begum Akhtar', 'Suman Kalyanpur', 'Asha Bhosle', 'Lata Mangeshkar'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer is remembered for the music of Madhumati and Sujata?', options: ['Salil Chowdhury', 'Naushad', 'Roshan', 'C. Ramchandra'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Aaja Re Pardesi” from Madhumati?', options: ['Asha Bhosle', 'Geeta Dutt', 'Shamshad Begum', 'Lata Mangeshkar'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer wrote the music for Barsaat and Awara?', options: ['S. D. Burman', 'Laxmikant-Pyarelal', 'Shankar-Jaikishan', 'Naushad'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Awara Hoon”?', options: ['Mukesh', 'Mohammed Rafi', 'Manna Dey', 'Talat Mahmood'], answer: 0, difficulty: 2, topic: 'Film music'),
  QuizQuestion(question: 'Which lyricist wrote “Awara Hoon”?', options: ['Hasrat Jaipuri', 'Sahir Ludhianvi', 'Majrooh Sultanpuri', 'Shailendra'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “O Sajna Barkha Bahar Aayi” for Parakh?', options: ['Geeta Dutt', 'Suman Kalyanpur', 'Lata Mangeshkar', 'Asha Bhosle'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer is associated with the songs of Taj Mahal and Barsaat Ki Raat?', options: ['Roshan', 'Naushad', 'Madan Mohan', 'Khayyam'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Man Tarpat Hari Darshan Ko Aaj” from Baiju Bawra?', options: ['Manna Dey', 'Mukesh', 'Talat Mahmood', 'Mohammed Rafi'], answer: 3, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which composer duo wrote the music for Satyam Shivam Sundaram and Prem Rog?', options: ['Kalyanji-Anandji', 'Ravindra Jain', 'Laxmikant-Pyarelal', 'Shankar-Jaikishan'], answer: 2, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Raina Beeti Jaye” from Amar Prem?', options: ['Lata Mangeshkar', 'Asha Bhosle', 'Suman Kalyanpur', 'Geeta Dutt'], answer: 0, difficulty: 3, topic: 'Film music'),
  QuizQuestion(question: 'Which singer recorded “Chingari Koi Bhadke” from Amar Prem?', options: ['Mukesh', 'Mohammed Rafi', 'Manna Dey', 'Kishore Kumar'], answer: 3, difficulty: 3, topic: 'Film music'),
];
