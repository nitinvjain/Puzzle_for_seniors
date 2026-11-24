/// Hindi cinema questions, from an online Bollywood trivia list.
///
/// As with the other outside sources, the facts are used and the wording,
/// options and distractors are written here.
///
/// The source needed more correcting than the others, because it is
/// user-contributed rather than edited:
///
///   * names are misspelt throughout -- Ram Gopal Varma, Hrithik Roshan,
///     Kamal Haasan, Sohail Khan, Saawariya, Ajay Devgn and Basanti's mare
///     Dhanno are all spelt wrongly there and are corrected here;
///
///   * one question asks who played Roma in Don without saying which Don.
///     It was Zeenat Aman in 1978 and Priyanka Chopra in the 2006 remake, so
///     the year is stated here and both films get a question of their own;
///
///   * two questions are asked twice over in the list (Baadshah, and Akbar in
///     Mughal-e-Azam) and appear once here;
///
///   * a few are left out: an "actor of the decade" question that is a matter
///     of opinion rather than fact, a debut credit I could not satisfy myself
///     was right, and two items of gossip about named living people, one of
///     them about a criminal case that was overturned on appeal.
///
/// Questions the bank already asks are also skipped: Satyajit Ray's honorary
/// Oscar, who made Pather Panchali, Lagaan's Oscar nomination and its sport,
/// and the star of Aradhana.
library;

import 'quiz_question.dart';

const List<QuizQuestion> bollywoodQuestions = [
  // ------------------------------------------------- the early and classic
  QuizQuestion(question: 'Who directed Raja Harishchandra, released in 1913?', options: ['Ardeshir Irani', 'Himanshu Rai', 'V. Shantaram', 'Dhundiraj Govind Phalke'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actress starred opposite Raj Kapoor in Barsaat in 1949?', options: ['Meena Kumari', 'Suraiya', 'Madhubala', 'Nargis'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Raj Kapoor, the showman of Hindi cinema, was the son of which actor?', options: ['Motilal', 'Ashok Kumar', 'Sohrab Modi', 'Prithviraj Kapoor'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Who played Emperor Akbar in Mughal-e-Azam?', options: ['Dilip Kumar', 'Sohrab Modi', 'Ashok Kumar', 'Prithviraj Kapoor'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which of these actors did NOT appear in Mother India?', options: ['Sunil Dutt', 'Rajendra Kumar', 'Nargis', 'Dilip Kumar'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who directed the 1965 film Guide?', options: ['Dev Anand', 'Chetan Anand', 'Bimal Roy', 'Vijay Anand'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who was the heroine of the 1969 film Aradhana?', options: ['Mumtaz', 'Asha Parekh', 'Waheeda Rehman', 'Sharmila Tagore'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which director made Salaam Bombay, released in 1988?', options: ['Shyam Benegal', 'Govind Nihalani', 'Ketan Mehta', 'Mira Nair'], answer: 3, difficulty: 2, topic: 'Films'),

  // ------------------------------------------------------------ double roles
  QuizQuestion(question: 'Which actor played the double role in Ram Aur Shyam in 1967?', options: ['Dev Anand', 'Raaj Kumar', 'Shammi Kapoor', 'Dilip Kumar'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actress played twin sisters in the 1989 film Chaalbaaz?', options: ['Madhuri Dixit', 'Jaya Prada', 'Meenakshi Seshadri', 'Sridevi'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actress had a double role in the 1976 film Mehbooba?', options: ['Rekha', 'Zeenat Aman', 'Parveen Babi', 'Hema Malini'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actress played a double role in the 1971 film Sharmeelee?', options: ['Asha Parekh', 'Saira Banu', 'Mumtaz', 'Raakhee'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor played two air force pilots in Aradhana?', options: ['Dharmendra', 'Jeetendra', 'Shashi Kapoor', 'Rajesh Khanna'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor played the double role in the 1978 film Don?', options: ['Vinod Khanna', 'Shatrughan Sinha', 'Feroz Khan', 'Amitabh Bachchan'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actor played two men of different nationalities in the 1968 film Humsaya?', options: ['Biswajit', 'Manoj Kumar', 'Sanjeev Kumar', 'Joy Mukherjee'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which south Indian actor played a double role in Appu Raja?', options: ['Rajinikanth', 'Mohanlal', 'Chiranjeevi', 'Kamal Haasan'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor made his leading debut in a double role in Kaho Naa... Pyaar Hai?', options: ['Abhishek Bachchan', 'Arjun Rampal', 'Fardeen Khan', 'Hrithik Roshan'], answer: 3, difficulty: 2, topic: 'Films'),

  // ------------------------------------------------------------------ Sholay
  QuizQuestion(question: 'What is the name of Basanti’s mare in Sholay?', options: ['Chetak', 'Badal', 'Sitara', 'Dhanno'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Who wrote the script and dialogue of Sholay?', options: ['Gulzar', 'Kader Khan', 'Rahi Masoom Raza', 'Salim–Javed'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which of Sholay’s two friends dies at the end of the film?', options: ['The one played by Dharmendra', 'Neither of them', 'Both of them', 'The one played by Amitabh Bachchan'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Complete Gabbar’s line from Sholay: “Ye ______ mujhe de de Thakur.”', options: ['ghoda', 'paisa', 'bandook', 'haath'], answer: 3, difficulty: 2, topic: 'Films'),

  // -------------------------------------------------- Amitabh Bachchan
  QuizQuestion(question: 'Which actor is known as the angry young man of Hindi cinema?', options: ['Vinod Khanna', 'Shatrughan Sinha', 'Sunil Dutt', 'Amitabh Bachchan'], answer: 3, difficulty: 1, topic: 'Films'),
  QuizQuestion(question: 'Which Indian actor was voted the BBC’s Star of the Millennium?', options: ['Amitabh Bachchan', 'Dilip Kumar', 'Raj Kapoor', 'Shah Rukh Khan'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actor played God in the film God Tussi Great Ho?', options: ['Anupam Kher', 'Paresh Rawal', 'Naseeruddin Shah', 'Amitabh Bachchan'], answer: 3, difficulty: 3, topic: 'Films'),

  // ---------------------------------------------------- films and their makers
  QuizQuestion(question: 'Who directed the 1998 film Satya?', options: ['Ram Gopal Varma', 'Mahesh Bhatt', 'Vidhu Vinod Chopra', 'Sudhir Mishra'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who directed the 2000 film Pukar?', options: ['Subhash Ghai', 'J. P. Dutta', 'Priyadarshan', 'Rajkumar Santoshi'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who directed Singh is Kinng?', options: ['Anees Bazmee', 'Priyadarshan', 'David Dhawan', 'Rohit Shetty'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which 2009 film written and directed by Anurag Kashyap starred Abhay Deol?', options: ['Gulaal', 'Black Friday', 'No Smoking', 'Dev.D'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Karan Johar’s second film as director, with a very large star cast, was which one?', options: ['Kabhi Khushi Kabhie Gham', 'Kal Ho Naa Ho', 'Kabhi Alvida Naa Kehna', 'Student of the Year'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which pair of actors produced the film Phir Bhi Dil Hai Hindustani?', options: ['Aamir Khan and Kiran Rao', 'Salman Khan and Sohail Khan', 'Ajay Devgn and Kajol', 'Shah Rukh Khan and Juhi Chawla'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who produced the film Dabangg?', options: ['Arbaaz Khan', 'Salman Khan', 'Sajid Nadiadwala', 'Boney Kapoor'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which 2001 film was the first production of Aamir Khan’s own company?', options: ['Dil Chahta Hai', 'Taare Zameen Par', 'Jaane Tu Ya Jaane Na', 'Lagaan'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Who directed 3 Idiots?', options: ['Rajkumar Hirani', 'Farhan Akhtar', 'Ashutosh Gowariker', 'Imtiaz Ali'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which 1988 film with Aamir Khan and Juhi Chawla revived the romantic film in Hindi cinema?', options: ['Maine Pyar Kiya', 'Love Story', 'Betaab', 'Qayamat Se Qayamat Tak'], answer: 3, difficulty: 2, topic: 'Films'),

  // -------------------------------------------------------- characters, roles
  QuizQuestion(question: 'Who played Roma in the 1978 film Don?', options: ['Zeenat Aman', 'Parveen Babi', 'Hema Malini', 'Rekha'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who played Roma in the 2006 remake of Don?', options: ['Kareena Kapoor', 'Lara Dutta', 'Rani Mukerji', 'Priyanka Chopra'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'What was the name of the alien in Koi... Mil Gaya?', options: ['Jadoo', 'Chitti', 'Gogo', 'Appu'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'What is the name of the robot played by Rajinikanth in the film Robot?', options: ['Jadoo', 'Vaseegaran', 'Bhima', 'Chitti'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'What is the name of the villain in the film Dhoom?', options: ['Kabir', 'Aryan', 'Jai', 'Vishnu'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who is the ruthless criminal in the film Force?', options: ['Kabir', 'Kancha', 'Rana', 'Vishnu'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who is the British officer who is the antagonist of Lagaan?', options: ['Captain Andrew Russell', 'Colonel Boyer', 'Major Warren', 'Captain Elizabeth Gale'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'What military rank does Ram Prasad Sharma hold in Main Hoon Na?', options: ['Captain', 'Colonel', 'Lieutenant', 'Major'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'What is the name of Shah Rukh Khan’s character in the 1999 film Baadshah?', options: ['Baadshah', 'Raj', 'Rahul', 'Vijay'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'In Maine Pyar Kiya, what is the name of Prem’s friend?', options: ['Kishan', 'Ranjeet', 'Babloo', 'Manohar'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Jab We Met, what is the name of Geet’s sister?', options: ['Roop', 'Preeti', 'Simran', 'Pooja'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which character does Kareena Kapoor give her voice to in Roadside Romeo?', options: ['Chhamiya', 'Mini', 'Guddi', 'Laila'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In which village does Billu live, in the film Billu?', options: ['Budhbuda', 'Charanpur', 'Ramgarh', 'Madhopur'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who plays Zoya in the 2008 film Jannat?', options: ['Bipasha Basu', 'Esha Gupta', 'Mugdha Godse', 'Sonal Chauhan'], answer: 3, difficulty: 3, topic: 'Films'),

  // ---------------------------------------------------- films within films
  QuizQuestion(question: 'In Swades, which film are the villagers of Charanpur watching when the power fails?', options: ['Yaadon Ki Baaraat', 'Sholay', 'Bobby', 'Mother India'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Satya, which film is playing when the stampede happens?', options: ['Sholay', 'Deewaar', 'Karma', 'Border'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Akayla, which film is Vijay watching when he realises Braganza has a twin?', options: ['Seeta Aur Geeta', 'Ram Aur Shyam', 'Chaalbaaz', 'Do Kaliyaan'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Hulchul, which film is Anjali’s family watching when Jai climbs in at the window?', options: ['Sholay', 'Qayamat Se Qayamat Tak', 'Love Story', 'Bobby'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Mere Yaar Ki Shaadi Hai, which film are Sanjay and Ria watching?', options: ['Maine Pyar Kiya', 'Hum Aapke Hain Koun', 'Dil To Pagal Hai', 'Bobby'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Dhoom 2, which animated film is being watched?', options: ['Finding Nemo', 'Toy Story', 'Shrek', 'Cars'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Rang Birangi, Deven takes his idea from which other film about a straying husband?', options: ['Pati Patni Aur Woh', 'Chupke Chupke', 'Golmaal', 'Khubsoorat'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Naseeb, the song “John Jaani Janardhan” is set at the silver jubilee party of which film?', options: ['Amar Akbar Anthony', 'Suhaag', 'Parvarish', 'Dharam Veer'], answer: 3, difficulty: 3, topic: 'Films'),

  // ------------------------------------------------------- actors and careers
  QuizQuestion(question: 'Which actor made the “No. 1” comedies of the 1990s, among them Coolie No. 1?', options: ['Govinda', 'Chunky Pandey', 'Johnny Lever', 'Kader Khan'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actor won awards for Sparsh, Paar and Iqbal?', options: ['Om Puri', 'Shabana Azmi’s co-star Farooq Shaikh', 'Pankaj Kapur', 'Naseeruddin Shah'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor made his debut in the 2007 film Saawariya?', options: ['Ranbir Kapoor', 'Imran Khan', 'Harman Baweja', 'Neil Nitin Mukesh'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which Indian actress served on the Cannes film festival jury in 2003?', options: ['Rani Mukerji', 'Tabu', 'Shabana Azmi', 'Aishwarya Rai'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which two brothers acted together in the film Veer?', options: ['Salman and Sohail Khan', 'Aamir and Faisal Khan', 'Saif and Ibrahim Ali Khan', 'Arbaaz and Sohail Khan'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who plays the male lead in Delhi 6?', options: ['Ranbir Kapoor', 'Shahid Kapoor', 'Saif Ali Khan', 'Abhishek Bachchan'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor plays the lead in the film Luck?', options: ['Imran Khan', 'Shahid Kapoor', 'Ranbir Kapoor', 'Abhay Deol'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actress plays the supermodel in Kambakkht Ishq?', options: ['Katrina Kaif', 'Priyanka Chopra', 'Deepika Padukone', 'Kareena Kapoor'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Who plays the female lead in Fashion?', options: ['Priyanka Chopra', 'Kangana Ranaut', 'Mugdha Godse', 'Bipasha Basu'], answer: 0, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Who is the female lead of Chandni Chowk to China?', options: ['Katrina Kaif', 'Asin', 'Sonam Kapoor', 'Deepika Padukone'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actress plays Ajay Devgn’s wife in Golmaal Returns?', options: ['Kareena Kapoor', 'Amrita Arora', 'Celina Jaitly', 'Rimi Sen'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor plays the lead in the film Straight?', options: ['Rajat Kapoor', 'Ranvir Shorey', 'Kay Kay Menon', 'Vinay Pathak'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Kidnap, who kidnaps the character played by Minissha Lamba?', options: ['Imran Khan', 'Sanjay Dutt', 'Vidyut Jammwal', 'Arjun Rampal'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which of these stars did NOT appear in Kabhi Khushi Kabhie Gham?', options: ['Shah Rukh Khan', 'Hrithik Roshan', 'Kajol', 'Salman Khan'], answer: 3, difficulty: 2, topic: 'Films'),
  QuizQuestion(question: 'Which actor plays Major Jaidev Rajvansh in Pukar?', options: ['Anil Kapoor', 'Jackie Shroff', 'Sunny Deol', 'Sanjay Dutt'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which actor played the judge in the 1983 film Justice Chaudhury?', options: ['Rajesh Khanna', 'Shatrughan Sinha', 'Vinod Mehra', 'Jeetendra'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Luck By Chance, which profession is Farhan Akhtar’s character trying to enter?', options: ['Acting', 'Direction', 'Music', 'Journalism'], answer: 0, difficulty: 3, topic: 'Films'),

  // -------------------------------------------------------------- the industry
  QuizQuestion(question: 'In which city is the Hindi film industry known as Bollywood based?', options: ['Delhi', 'Kolkata', 'Chennai', 'Mumbai'], answer: 3, difficulty: 1, topic: 'Films'),
  QuizQuestion(question: 'Bollywood films are made chiefly in which language?', options: ['Hindi', 'Tamil', 'Bengali', 'Marathi'], answer: 0, difficulty: 1, topic: 'Films'),
  QuizQuestion(question: 'Which film was India’s entry for the Academy Award for Best Foreign Film in 1957–58?', options: ['Do Bigha Zamin', 'Pyaasa', 'Jagte Raho', 'Mother India'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'The 2008 film Hello was adapted from which novel?', options: ['One Night @ the Call Center', 'Five Point Someone', 'The 3 Mistakes of My Life', 'Two States'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In which language was Mani Ratnam’s 1992 film Roja originally made?', options: ['Telugu', 'Hindi', 'Malayalam', 'Tamil'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which 2009 Hindi film took the September 11 attacks as its subject?', options: ['New York', 'Kurbaan', 'My Name Is Khan', 'Fanaa'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'Which 2009 film starring Deepika Padukone and Saif Ali Khan sets a present-day romance beside one from the past?', options: ['Cocktail', 'Tamasha', 'Bachna Ae Haseeno', 'Love Aaj Kal'], answer: 3, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'In Rock On!!, which music channel runs the band competition?', options: ['Channel V', 'MTV India', 'Zoom', '9XM'], answer: 0, difficulty: 3, topic: 'Films'),
  QuizQuestion(question: 'What kind of film is Hungama?', options: ['A war film', 'A thriller', 'A biography', 'A comedy'], answer: 3, difficulty: 2, topic: 'Films'),
];
