/// Hindi kahavatein and muhavare with the last word missing.
///
/// These are traditional sayings -- folk property, no author to credit and
/// nothing reproduced that belongs to anybody -- which is why they can carry
/// their real words where a song lyric cannot.
///
/// They are in the game because proverbs are held differently from facts.
/// They were learnt young, repeated for a lifetime, and come back as a whole
/// phrase rather than being assembled word by word, so they survive long
/// after names and dates have gone. Finishing one is also the kind of thing
/// he will have done at the dinner table for sixty years.
///
/// Written in Roman script to match the rest of the app, which has no
/// Devanagari font bundled.
library;

import 'choice_question.dart';

const List<ChoiceQuestion> kahavatQuestions = [
  ChoiceQuestion(prompt: 'Ab pachhtaye hot kya, jab chidiya chug gayi ______', options: ['khet', 'bagh', 'daana', 'aangan'], answer: 0),
  ChoiceQuestion(prompt: 'Naach na jaane aangan ______', options: ['tedha', 'ooncha', 'chhota', 'gila'], answer: 0),
  ChoiceQuestion(prompt: 'Jaise ko ______', options: ['taisa', 'vaisa', 'aisa', 'kaisa'], answer: 0),
  ChoiceQuestion(prompt: 'Aam ke aam, guthliyon ke ______', options: ['daam', 'kaam', 'naam', 'shaam'], answer: 0),
  ChoiceQuestion(prompt: 'Doodh ka jala chhaachh bhi phoonk phoonk kar ______', options: ['peeta hai', 'khaata hai', 'rakhta hai', 'laata hai'], answer: 0),
  ChoiceQuestion(prompt: 'Oonchi dukaan, pheeka ______', options: ['pakwan', 'makaan', 'saman', 'mehmaan'], answer: 0),
  ChoiceQuestion(prompt: 'Ek haath se taali nahin ______', options: ['bajti', 'lagti', 'milti', 'hoti'], answer: 0),
  ChoiceQuestion(prompt: 'Jal mein rehkar magar se bair ______', options: ['nahin', 'achha', 'theek', 'sahi'], answer: 0),
  ChoiceQuestion(prompt: 'Bandar kya jaane adrak ka ______', options: ['swaad', 'daam', 'rang', 'naam'], answer: 0),
  ChoiceQuestion(prompt: 'Khoda pahaad, nikla ______', options: ['chooha', 'saanp', 'sona', 'paani'], answer: 0),
  ChoiceQuestion(prompt: 'Naya naukar hiran ke ______', options: ['seeng', 'paanv', 'kaan', 'daant'], answer: 0),
  ChoiceQuestion(prompt: 'Chor ki daadhi mein ______', options: ['tinka', 'kaanta', 'dhaaga', 'patta'], answer: 0),
  ChoiceQuestion(prompt: 'Jiski laathi uski ______', options: ['bhains', 'gaai', 'zameen', 'baat'], answer: 0),
  ChoiceQuestion(prompt: 'Andhon mein kaana ______', options: ['raja', 'saathi', 'guru', 'pandit'], answer: 0),
  ChoiceQuestion(prompt: 'Ghar ka bhedi lanka ______', options: ['dhaye', 'jaaye', 'laaye', 'paaye'], answer: 0),
  ChoiceQuestion(prompt: 'Door ke dhol ______', options: ['suhaavne', 'puraane', 'bhaari', 'bekaar'], answer: 0),
  ChoiceQuestion(prompt: 'Jo garajte hain woh baraste ______', options: ['nahin', 'hain', 'zaroor', 'kabhi'], answer: 0),
  ChoiceQuestion(prompt: 'Saanp bhi mar jaye aur laathi bhi na ______', options: ['toote', 'jhuke', 'gire', 'mude'], answer: 0),
  ChoiceQuestion(prompt: 'Bin maange moti mile, maange mile na ______', options: ['bheek', 'daana', 'paani', 'roti'], answer: 0),
  ChoiceQuestion(prompt: 'Nau din chale adhai ______', options: ['kos', 'mile', 'ghante', 'gaon'], answer: 0),
  ChoiceQuestion(prompt: 'Ulta chor kotwal ko ______', options: ['daante', 'maare', 'bulaye', 'dhoonde'], answer: 0),
  ChoiceQuestion(prompt: 'Eent ka jawab ______', options: ['patthar', 'mitti', 'sona', 'paani'], answer: 0),
  ChoiceQuestion(prompt: 'Haathi ke daant khaane ke aur, dikhane ke ______', options: ['aur', 'wahi', 'kam', 'zyada'], answer: 0),
  ChoiceQuestion(prompt: 'Thoothe bartan zyada ______', options: ['bajte hain', 'tikte hain', 'chalte hain', 'bikte hain'], answer: 0),
  ChoiceQuestion(prompt: 'Kaal kare so aaj kar, aaj kare so ______', options: ['ab', 'kal', 'phir', 'tab'], answer: 0),
  ChoiceQuestion(prompt: 'Jaako raakhe saiyan, maar sake na ______', options: ['koy', 'joy', 'soy', 'roy'], answer: 0),
  ChoiceQuestion(prompt: 'Boya ped babool ka, aam kahan se ______', options: ['hoy', 'aay', 'paay', 'laay'], answer: 0),
  ChoiceQuestion(prompt: 'Dheere dheere re mana, dheere sab kuchh ______', options: ['hoy', 'jaay', 'aay', 'paay'], answer: 0),
  ChoiceQuestion(prompt: 'Bade bade dekhe hain, chhote kya ______', options: ['cheez hain', 'baat hai', 'kaam hai', 'naam hai'], answer: 0),
  ChoiceQuestion(prompt: 'Apni gali mein kutta bhi ______', options: ['sher hota hai', 'shaant hota hai', 'raja hota hai', 'tez hota hai'], answer: 0),
  ChoiceQuestion(prompt: 'Jahan chaah wahan ______', options: ['raah', 'baat', 'saath', 'haath'], answer: 0),
  ChoiceQuestion(prompt: 'Akela chana bhaad nahin ______', options: ['phod sakta', 'bhar sakta', 'khol sakta', 'tod sakta'], answer: 0),
  ChoiceQuestion(prompt: 'Ek anaar sau ______', options: ['bimaar', 'bazaar', 'taiyaar', 'parivaar'], answer: 0),
  ChoiceQuestion(prompt: 'Jitni chaadar ho utne hi pair ______', options: ['failao', 'uthao', 'chalao', 'dabao'], answer: 0),
  ChoiceQuestion(prompt: 'Sau sunaar ki, ek ______', options: ['lohaar ki', 'kumhaar ki', 'zamindaar ki', 'kisaan ki'], answer: 0),
  ChoiceQuestion(prompt: 'Ghar ki murgi daal ______', options: ['baraabar', 'se achhi', 'se mehngi', 'ke saath'], answer: 0),
  ChoiceQuestion(prompt: 'Jo bole so ______', options: ['nihaal', 'kamaal', 'khushaal', 'bemisaal'], answer: 0),
  ChoiceQuestion(prompt: 'Bakri ki maa kab tak ______', options: ['khair manayegi', 'ghaas khayegi', 'door rahegi', 'shor karegi'], answer: 0),
  ChoiceQuestion(prompt: 'Aasmaan se gira, khajoor mein ______', options: ['atka', 'latka', 'baitha', 'phansa'], answer: 0),
  ChoiceQuestion(prompt: 'Char din ki ______', options: ['chaandni', 'raushni', 'zindagi', 'khushi'], answer: 0),
  ChoiceQuestion(prompt: 'Jo jaaga so paaya, jo soya so ______', options: ['khoya', 'roya', 'boya', 'moya'], answer: 0),
  ChoiceQuestion(prompt: 'Haath kangan ko aarsi ______', options: ['kya', 'do', 'hai', 'lo'], answer: 0),
  ChoiceQuestion(prompt: 'Jis thaali mein khaana, usi mein ______', options: ['chhed karna', 'paani bharna', 'haath dhona', 'namak dalna'], answer: 0),
  ChoiceQuestion(prompt: 'Kheer khaane walon ko ______', options: ['hazaar bahane', 'ek bahana', 'koi bahana nahin', 'do bahane'], answer: 0),
  ChoiceQuestion(prompt: 'Bhains ke aage ______', options: ['been bajana', 'geet gaana', 'ghaas dalna', 'daud lagana'], answer: 0),
  ChoiceQuestion(prompt: 'Avval darja ki ______', options: ['bakwas', 'baat', 'baazi', 'bahadur'], answer: 0),
  ChoiceQuestion(prompt: 'Aage kuan peechhe ______', options: ['khaai', 'nadi', 'pahaad', 'raasta'], answer: 0),
  ChoiceQuestion(prompt: 'Jaan hai to jahaan ______', options: ['hai', 'tha', 'hoga', 'nahin'], answer: 0),
  ChoiceQuestion(prompt: 'Neki kar dariya mein ______', options: ['daal', 'jaa', 'baith', 'dhoond'], answer: 0),
  ChoiceQuestion(prompt: 'Hans chuge ga daana, kauwa moti ______', options: ['khaye ga', 'laye ga', 'paye ga', 'chhupaye ga'], answer: 0),
  ChoiceQuestion(prompt: 'Jaisa desh waisa ______', options: ['bhes', 'kaam', 'naam', 'raaj'], answer: 0),
  ChoiceQuestion(prompt: 'Man changa to kathauti mein ______', options: ['Ganga', 'Jamuna', 'paani', 'ganga jal'], answer: 0),
  ChoiceQuestion(prompt: 'Jal bin machhli, jeevan bin ______', options: ['praan', 'maan', 'gyaan', 'dhyaan'], answer: 0),
  ChoiceQuestion(prompt: 'Teli ka bail, ghar ka na ghaat ______', options: ['ka', 'par', 'mein', 'se'], answer: 0),
  ChoiceQuestion(prompt: 'Gud diye mare to zahar kyon ______', options: ['dena', 'khana', 'lena', 'rakhna'], answer: 0),
];
