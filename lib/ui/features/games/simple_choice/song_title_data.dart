/// Song titles with a word missing.
///
/// Why titles and not lines from the verse: I don't reproduce song lyrics,
/// and a game built on filling in the next word of a verse is exactly that.
/// Hindi film songs are almost always known by their opening phrase, which is
/// also the title, so completing the title asks the same thing of him and
/// draws on the same memory -- the worked example asked for, "Mere Sapno Ki
/// ___", is a title.
///
/// Weighted hard to the 1950s to the early 1980s. Melody and the words that
/// ride on it are among the last things dementia takes, and what is most
/// deeply laid down is what he heard between about fifteen and thirty.
///
/// The note under each one names the film, which is a kindness rather than a
/// clue: it places him in the right year before he has to reach for anything.
library;

import 'choice_question.dart';

const List<ChoiceQuestion> songTitleQuestions = [
  ChoiceQuestion(prompt: 'Mere Sapno Ki ______', note: 'from Aradhana', options: ['Rani', 'Dulhan', 'Yaadein', 'Baatein'], answer: 0),
  ChoiceQuestion(prompt: 'Roop Tera ______', note: 'from Aradhana', options: ['Mastana', 'Deewana', 'Suhana', 'Purana'], answer: 0),
  ChoiceQuestion(prompt: 'Kora Kagaz Tha Yeh Man ______', note: 'from Aradhana', options: ['Mera', 'Tera', 'Apna', 'Sapna'], answer: 0),
  ChoiceQuestion(prompt: 'Yeh Dosti Hum Nahin ______', note: 'from Sholay', options: ['Todenge', 'Chhodenge', 'Modenge', 'Bhoolenge'], answer: 0),
  ChoiceQuestion(prompt: 'Koi Haseena Jab Rooth ______', note: 'from Sholay', options: ['Jaati Hai', 'Jaata Hai', 'Gayi Hai', 'Jaaye Re'], answer: 0),
  ChoiceQuestion(prompt: 'Holi Ke Din Dil Khil ______', note: 'from Sholay', options: ['Jaate Hain', 'Jaata Hai', 'Gaye The', 'Jaayenge'], answer: 0),
  ChoiceQuestion(prompt: 'Pyar Hua Ikrar ______', note: 'from Shree 420', options: ['Hua', 'Kiya', 'Tha', 'Hai'], answer: 0),
  ChoiceQuestion(prompt: 'Mera Joota Hai ______', note: 'from Shree 420', options: ['Japani', 'Rusi', 'Angrezi', 'Hindustani'], answer: 0),
  ChoiceQuestion(prompt: 'Ramaiya ______', note: 'from Shree 420', options: ['Vastavaiya', 'Jaaneman', 'Sajanwa', 'Balamwa'], answer: 0),
  ChoiceQuestion(prompt: 'Awara ______', note: 'from Awara', options: ['Hoon', 'Hain', 'Tha', 'Dil'], answer: 0),
  ChoiceQuestion(prompt: 'Chaudhvin Ka Chand ______', note: 'from Chaudhvin Ka Chand', options: ['Ho', 'Hai', 'Tha', 'Re'], answer: 0),
  ChoiceQuestion(prompt: 'Lag Ja ______', note: 'from Woh Kaun Thi', options: ['Gale', 'Paas', 'Saath', 'Door'], answer: 0),
  ChoiceQuestion(prompt: 'Naina Barse Rim ______', note: 'from Woh Kaun Thi', options: ['Jhim', 'Jhoom', 'Chhim', 'Rim'], answer: 0),
  ChoiceQuestion(prompt: 'Ae Mere Watan Ke ______', note: 'a patriotic song of 1963', options: ['Logon', 'Veeron', 'Beton', 'Sapoton'], answer: 0),
  ChoiceQuestion(prompt: 'Ek Pyar Ka Nagma ______', note: 'from Shor', options: ['Hai', 'Tha', 'Re', 'Ho'], answer: 0),
  ChoiceQuestion(prompt: 'Kahin Door Jab Din ______', note: 'from Anand', options: ['Dhal Jaye', 'Nikle Ga', 'Beet Jaye', 'Aaye Ga'], answer: 0),
  ChoiceQuestion(prompt: 'Zindagi Kaisi Hai ______', note: 'from Anand', options: ['Paheli', 'Saheli', 'Albeli', 'Akeli'], answer: 0),
  ChoiceQuestion(prompt: 'Chingari Koi ______', note: 'from Amar Prem', options: ['Bhadke', 'Chamke', 'Nikle', 'Jalaye'], answer: 0),
  ChoiceQuestion(prompt: 'Raina Beeti ______', note: 'from Amar Prem', options: ['Jaye', 'Gayi', 'Hai', 'Re'], answer: 0),
  ChoiceQuestion(prompt: 'Piya Tose Naina Lage ______', note: 'from Guide', options: ['Re', 'Hai', 'Ji', 'Na'], answer: 0),
  ChoiceQuestion(prompt: 'Aaj Phir Jeene Ki ______', note: 'from Guide', options: ['Tamanna Hai', 'Baari Hai', 'Khushi Hai', 'Aasha Hai'], answer: 0),
  ChoiceQuestion(prompt: 'Gaata Rahe Mera ______', note: 'from Guide', options: ['Dil', 'Man', 'Geet', 'Saaz'], answer: 0),
  ChoiceQuestion(prompt: 'Allah Tero ______', note: 'from Hum Dono', options: ['Naam', 'Dhyan', 'Daan', 'Gyan'], answer: 0),
  ChoiceQuestion(prompt: 'Abhi Na Jao Chhod ______', note: 'from Hum Dono', options: ['Kar', 'Mujhe', 'Yahan', 'Humein'], answer: 0),
  ChoiceQuestion(prompt: 'Aaja Re ______', note: 'from Madhumati', options: ['Pardesi', 'Sanwariya', 'Banwariya', 'Musafir'], answer: 0),
  ChoiceQuestion(prompt: 'Suhana Safar Aur Yeh Mausam ______', note: 'from Madhumati', options: ['Haseen', 'Rangeen', 'Sunehra', 'Suhana'], answer: 0),
  ChoiceQuestion(prompt: 'Jaane Woh Kaise Log ______', note: 'from Pyaasa', options: ['The', 'Hain', 'Honge', 'Aaye'], answer: 0),
  ChoiceQuestion(prompt: 'Yeh Duniya Agar Mil Bhi ______', note: 'from Pyaasa', options: ['Jaye', 'Gayi', 'Jaaye To', 'Jaata'], answer: 0),
  ChoiceQuestion(prompt: 'Waqt Ne Kiya Kya Haseen ______', note: 'from Kaagaz Ke Phool', options: ['Sitam', 'Karam', 'Bharam', 'Sanam'], answer: 0),
  ChoiceQuestion(prompt: 'Pyar Kiya To Darna ______', note: 'from Mughal-e-Azam', options: ['Kya', 'Nahin', 'Mat', 'Hai'], answer: 0),
  ChoiceQuestion(prompt: 'Mohe Panghat Pe Nandlal Chhed ______', note: 'from Mughal-e-Azam', options: ['Gayo Re', 'Diyo Re', 'Rahyo Re', 'Jaayo Re'], answer: 0),
  ChoiceQuestion(prompt: 'Man Tarpat Hari Darshan Ko ______', note: 'from Baiju Bawra', options: ['Aaj', 'Raat', 'Shaam', 'Bhor'], answer: 0),
  ChoiceQuestion(prompt: 'O Duniya Ke ______', note: 'from Baiju Bawra', options: ['Rakhwale', 'Matwale', 'Diwane', 'Chahne Wale'], answer: 0),
  ChoiceQuestion(prompt: 'Tu Ganga Ki ______', note: 'from Baiju Bawra', options: ['Mauj', 'Dhara', 'Lehar', 'Rawani'], answer: 0),
  ChoiceQuestion(prompt: 'Ajeeb Dastan Hai ______', note: 'from Dil Apna Aur Preet Parai', options: ['Yeh', 'Woh', 'Meri', 'Teri'], answer: 0),
  ChoiceQuestion(prompt: 'Chalte Chalte Mere Yeh ______', note: 'from Pakeezah', options: ['Geet', 'Saath', 'Raasta', 'Safar'], answer: 0),
  ChoiceQuestion(prompt: 'Inhi Logon Ne Le Lina ______', note: 'from Pakeezah', options: ['Dupatta Mera', 'Jeevan Mera', 'Sapna Mera', 'Chain Mera'], answer: 0),
  ChoiceQuestion(prompt: 'Mausam Hai ______', note: 'from Pakeezah', options: ['Aashiqana', 'Suhana', 'Deewana', 'Mastana'], answer: 0),
  ChoiceQuestion(prompt: 'Dum Maro ______', note: 'from Hare Rama Hare Krishna', options: ['Dum', 'Jam', 'Gham', 'Hum'], answer: 0),
  ChoiceQuestion(prompt: 'Chura Liya Hai Tumne Jo ______', note: 'from Yaadon Ki Baaraat', options: ['Dil Ko', 'Man Ko', 'Chain Ko', 'Sapna'], answer: 0),
  ChoiceQuestion(prompt: 'Parda Hai ______', note: 'from Amar Akbar Anthony', options: ['Parda', 'Pardesi', 'Purana', 'Pukara'], answer: 0),
  ChoiceQuestion(prompt: 'My Name Is Anthony ______', note: 'from Amar Akbar Anthony', options: ['Gonsalves', 'Fernandes', 'D’Souza', 'Pereira'], answer: 0),
  ChoiceQuestion(prompt: 'Khaike Paan Banaras ______', note: 'from Don', options: ['Wala', 'Jaisa', 'Vaala Re', 'Kaala'], answer: 0),
  ChoiceQuestion(prompt: 'Yeh Mera Dil Yaar Ka ______', note: 'from Don', options: ['Deewana', 'Parwana', 'Begana', 'Afsana'], answer: 0),
  ChoiceQuestion(prompt: 'O Mere Dil Ke ______', note: 'from Mere Jeevan Saathi', options: ['Chain', 'Raja', 'Saathi', 'Sahare'], answer: 0),
  ChoiceQuestion(prompt: 'Yeh Shaam ______', note: 'from Kati Patang', options: ['Mastani', 'Suhani', 'Deewani', 'Purani'], answer: 0),
  ChoiceQuestion(prompt: 'Pyar Deewana Hota ______', note: 'from Kati Patang', options: ['Hai', 'Tha', 'Re', 'Nahin'], answer: 0),
  ChoiceQuestion(prompt: 'Jis Gali Mein Tera ______', note: 'from Kati Patang', options: ['Ghar', 'Dil', 'Naam', 'Saaya'], answer: 0),
  ChoiceQuestion(prompt: 'Bahon Mein Chale ______', note: 'from Anamika', options: ['Aao', 'Jaao', 'Raho', 'Laao'], answer: 0),
  ChoiceQuestion(prompt: 'Aap Ki Nazron Ne ______', note: 'from Anpadh', options: ['Samjha', 'Dekha', 'Pukara', 'Bulaya'], answer: 0),
  ChoiceQuestion(prompt: 'Tere Bina Zindagi Se ______', note: 'from Aandhi', options: ['Koi', 'Kuchh', 'Kabhi', 'Mera'], answer: 0),
  ChoiceQuestion(prompt: 'Is Mod Se Jaate ______', note: 'from Aandhi', options: ['Hain', 'Ho', 'The', 'Hum'], answer: 0),
  ChoiceQuestion(prompt: 'In Aankhon Ki Masti ______', note: 'from Umrao Jaan', options: ['Ke', 'Mein', 'Se', 'Ka'], answer: 0),
  ChoiceQuestion(prompt: 'Dil Cheez Kya ______', note: 'from Umrao Jaan', options: ['Hai', 'Tha', 'Ho', 'Re'], answer: 0),
  ChoiceQuestion(prompt: 'Yeh Kya Jagah Hai ______', note: 'from Umrao Jaan', options: ['Doston', 'Yaaron', 'Sajno', 'Humdam'], answer: 0),
  ChoiceQuestion(prompt: 'Satyam Shivam ______', note: 'from Satyam Shivam Sundaram', options: ['Sundaram', 'Sanatan', 'Shaswat', 'Sahajam'], answer: 0),
  ChoiceQuestion(prompt: 'Zindagi Ek Safar Hai ______', note: 'from Andaz', options: ['Suhana', 'Purana', 'Deewana', 'Begana'], answer: 0),
  ChoiceQuestion(prompt: 'Rimjhim Gire ______', note: 'from Manzil', options: ['Sawan', 'Badal', 'Barkha', 'Paani'], answer: 0),
  ChoiceQuestion(prompt: 'Pal Pal Dil Ke ______', note: 'from Blackmail', options: ['Paas', 'Saath', 'Andar', 'Kareeb'], answer: 0),
  ChoiceQuestion(prompt: 'Kabhi Kabhie Mere Dil Mein ______', note: 'from Kabhi Kabhie', options: ['Khayal Aata Hai', 'Sawaal Aata Hai', 'Malaal Aata Hai', 'Jamaal Aata Hai'], answer: 0),
  ChoiceQuestion(prompt: 'Main Pal Do Pal Ka ______', note: 'from Kabhi Kabhie', options: ['Shayar', 'Musafir', 'Saathi', 'Rahi'], answer: 0),
  ChoiceQuestion(prompt: 'Ek Ajnabee Haseena ______', note: 'from Ajnabee', options: ['Se', 'Ne', 'Ko', 'Ka'], answer: 0),
  ChoiceQuestion(prompt: 'Mere Naina Sawan ______', note: 'from Mehbooba', options: ['Bhadon', 'Barkha', 'Badal', 'Bahaar'], answer: 0),
  ChoiceQuestion(prompt: 'Aaj Rapat Jaayen To ______', note: 'from Namak Halaal', options: ['Hamein Na Uthaiyo', 'Hamein Mat Girana', 'Tum Haath Badhana', 'Hamein Bhool Jaana'], answer: 0),
  ChoiceQuestion(prompt: 'Pag Ghungroo Baandh ______', note: 'from Namak Halaal', options: ['Meera Nachi Thi', 'Radha Nachi Thi', 'Sakhi Nachi Thi', 'Bela Nachi Thi'], answer: 0),
  ChoiceQuestion(prompt: 'Om Shanti ______', note: 'from Karz', options: ['Om', 'Hari', 'Shanti', 'Namah'], answer: 0),
  ChoiceQuestion(prompt: 'Ek Haseena ______', note: 'from Karz', options: ['Thi', 'Hai', 'Ho', 'Ne'], answer: 0),
  ChoiceQuestion(prompt: 'Tum Jo Mil Gaye ______', note: 'from Hanste Zakhm', options: ['Ho', 'Hain', 'The', 'Re'], answer: 0),
  ChoiceQuestion(prompt: 'Zindagi Ka ______', note: 'from Safar', options: ['Safar', 'Sahara', 'Sapna', 'Sawaal'], answer: 0),
  ChoiceQuestion(prompt: 'Kuch Kuch Hota ______', note: 'from Kuch Kuch Hota Hai', options: ['Hai', 'Tha', 'Re', 'Ho'], answer: 0),
  ChoiceQuestion(prompt: 'Mehndi Laga Ke ______', note: 'from Dilwale Dulhania Le Jayenge', options: ['Rakhna', 'Aana', 'Jaana', 'Dena'], answer: 0),
  ChoiceQuestion(prompt: 'Tujhe Dekha To Yeh Jaana ______', note: 'from Dilwale Dulhania Le Jayenge', options: ['Sanam', 'Balam', 'Sajan', 'Humdum'], answer: 0),
  ChoiceQuestion(prompt: 'Dil To Pagal ______', note: 'from Dil To Pagal Hai', options: ['Hai', 'Tha', 'Ho', 'Re'], answer: 0),
  ChoiceQuestion(prompt: 'Yaadon Ki ______', note: 'the title song of a 1973 film', options: ['Baaraat', 'Bahaar', 'Baatein', 'Barsaat'], answer: 0),
  ChoiceQuestion(prompt: 'Mera Naam ______', note: 'from the 1970 Raj Kapoor film', options: ['Joker', 'Raju', 'Shankar', 'Anari'], answer: 0),
  ChoiceQuestion(prompt: 'Jeena Yahan Marna ______', note: 'from Mera Naam Joker', options: ['Yahan', 'Wahan', 'Kahan', 'Vahin'], answer: 0),
];
