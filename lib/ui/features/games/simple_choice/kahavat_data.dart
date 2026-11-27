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

  // ---------------------------------------------------------------------
  // Added from a public collection of lokoktiyan NJ pointed me at. Same
  // rule as the rest of the file: the sayings themselves are folk property
  // and carry their real words, while the three wrong options are written
  // here -- they have to rhyme or scan closely enough to be a real choice,
  // which no source provides.
  //
  // Only full proverbs were taken. The collection is mostly muhavare --
  // "aag babula hona", "kaan bharna" -- which are phrases rather than
  // sayings with an ending to supply, and make a poor question.
  //
  // The second source NJ gave is a scanned idiom list whose OCR has eaten
  // the Devanagari ("एक हाथ सेताली नहींबजती"), so nothing was taken from it
  // rather than guess at broken words.
  ChoiceQuestion(prompt: 'Doobte ko tinke ka ______', options: ['sahara', 'kinara', 'ishara', 'nazara'], answer: 0),
  ChoiceQuestion(prompt: 'Naam bade, darshan ______', options: ['chote', 'bade', 'achhe', 'saste'], answer: 0),
  ChoiceQuestion(prompt: 'Ek aur ek ______', options: ['gyarah', 'do', 'barah', 'teen'], answer: 0),
  ChoiceQuestion(prompt: 'Daane daane par likha hai khaane wale ka ______', options: ['naam', 'kaam', 'daam', 'gaon'], answer: 0),
  ChoiceQuestion(prompt: 'Karela, oopar se neem ______', options: ['chadha', 'gira', 'khada', 'pada'], answer: 0),
  ChoiceQuestion(prompt: 'Naya nau din, purana sau ______', options: ['din', 'saal', 'baar', 'pal'], answer: 0),
  ChoiceQuestion(prompt: 'Sir mundaate hi ole ______', options: ['pade', 'gire', 'ude', 'ruke'], answer: 0),
  ChoiceQuestion(prompt: 'Aa bail mujhe ______', options: ['maar', 'haar', 'pukaar', 'dulaar'], answer: 0),
  ChoiceQuestion(prompt: 'Neem hakeem khatra ______', options: ['jaan', 'kaan', 'shaan', 'makaan'], answer: 0),
  ChoiceQuestion(prompt: 'Bhookhe bhajan na hoye ______', options: ['Gopala', 'Nandlala', 'Murari', 'Banwari'], answer: 0),
  ChoiceQuestion(prompt: 'Loha lohe ko ______', options: ['kaatta hai', 'jodta hai', 'chhodta hai', 'dhota hai'], answer: 0),
  ChoiceQuestion(prompt: 'Muft ka chandan, ghis mere ______', options: ['Nandan', 'Sajan', 'Madan', 'Vandan'], answer: 0),
  ChoiceQuestion(prompt: 'Jin khoja tin ______', options: ['paaiyan', 'khoyin', 'soyin', 'boyin'], answer: 0),
  ChoiceQuestion(prompt: 'Ek panth do ______', options: ['kaaj', 'raaj', 'saaj', 'aaj'], answer: 0),
  ChoiceQuestion(prompt: 'Saat pushton ki ______', options: ['kamai', 'padhai', 'ladai', 'sagai'], answer: 0),
  ChoiceQuestion(prompt: 'Na rahega baans, na bajegi ______', options: ['bansuri', 'chudi', 'ghanti', 'sitar'], answer: 0),
  ChoiceQuestion(prompt: 'Man ka haara haar hai, man ka jeeta ______', options: ['jeet', 'haar', 'khel', 'daanv'], answer: 0),
  ChoiceQuestion(prompt: 'Haathi chale bazaar, kutte bhaunke ______', options: ['hazaar', 'bekaar', 'do chaar', 'lagaatar'], answer: 0),
  ChoiceQuestion(prompt: 'Samay bada ______', options: ['balwan', 'dhanwan', 'gunwan', 'pehelwan'], answer: 0),
  ChoiceQuestion(prompt: 'Munh mein Ram, bagal mein ______', options: ['chhuri', 'puri', 'nagri', 'bansuri'], answer: 0),
  ChoiceQuestion(prompt: 'Doodh ka doodh, paani ka ______', options: ['paani', 'daana', 'khaana', 'maana'], answer: 0),
  ChoiceQuestion(prompt: 'Raai ka ______ banana', options: ['pahaad', 'mahal', 'kinara', 'basera'], answer: 0),
  ChoiceQuestion(prompt: 'Kaath ki haandi baar baar nahin ______', options: ['chadhti', 'tootti', 'bikti', 'banti'], answer: 0),
  ChoiceQuestion(prompt: 'Aasteen ka ______', options: ['saanp', 'chor', 'dost', 'raaja'], answer: 0),
  ChoiceQuestion(prompt: 'Zameen aasmaan ka ______', options: ['farak', 'rishta', 'naata', 'sapna'], answer: 0),
  ChoiceQuestion(prompt: 'Saanp nikal gaya, ab ______ peetna', options: ['lakeer', 'zameen', 'chhaati', 'dhol'], answer: 0),
  ChoiceQuestion(prompt: 'Ek teer se do ______', options: ['shikaar', 'vaar', 'prahaar', 'hathiyaar'], answer: 0),
  ChoiceQuestion(prompt: 'Ghar phoonk tamasha ______', options: ['dekhna', 'karna', 'banana', 'sunana'], answer: 0),
  ChoiceQuestion(prompt: 'Andhe ke haath ______ lagna', options: ['bater', 'moti', 'khazana', 'laathi'], answer: 0),
  ChoiceQuestion(prompt: 'Kachcha ghada jaldi ______', options: ['toota hai', 'bharta hai', 'sookhta hai', 'bikta hai'], answer: 0),
  ChoiceQuestion(prompt: 'Jaisa booge waisa ______', options: ['kaatoge', 'paoge', 'khaoge', 'laoge'], answer: 0),
  ChoiceQuestion(prompt: 'Oont ke munh mein ______', options: ['jeera', 'kheera', 'laddoo', 'chaara'], answer: 0),
  ChoiceQuestion(prompt: 'Khisiyani billi khamba ______', options: ['noche', 'chadhe', 'tode', 'dekhe'], answer: 0),
  ChoiceQuestion(prompt: 'Thotha chana baaje ______', options: ['ghana', 'purana', 'sunehra', 'anjana'], answer: 0),
  ChoiceQuestion(prompt: 'Adhjal gagri chhalakat ______', options: ['jaaye', 'rahe', 'gire', 'bahe'], answer: 0),
  ChoiceQuestion(prompt: 'Daal mein kuchh ______', options: ['kaala', 'meetha', 'gila', 'sookha'], answer: 0),

  // ---------------------------------------------------------------------
  // From a second collection NJ pointed me at, an English-proverb list
  // with the Hindi kahavat beside each one. Only the Hindi was taken.
  //
  // Left out of it:
  //
  //   * "bandar kya jaane cocacola ka swaad" -- a modern rewrite of the
  //     adrak original, which is already in this file.
  //   * "nazar hati, durghatna ghati" -- a road-safety slogan, not a
  //     kahavat.
  //   * "bhaagte bhutni ke baal" -- a garbling of "bhaagte bhoot ki
  //     langoti hi sahi".
  //   * "garib ki joru sabki bhabhi" -- unkind, and not something to put
  //     in front of him.
  //   * a dozen more that only reworded sayings already here.
  //
  // The 150-proverb page at njitm.com could not be read: it returned a
  // server error twice. Nothing from it is in this file.
  ChoiceQuestion(prompt: 'Jaisa karoge, waisa ______', options: ['bharoge', 'paoge', 'khaoge', 'laoge'], answer: 0),
  ChoiceQuestion(prompt: 'Karat karat abhyas ke, jadmati hot ______', options: ['sujan', 'pavan', 'magan', 'gagan'], answer: 0),
  ChoiceQuestion(prompt: 'Chhota munh, badi ______', options: ['baat', 'raat', 'ghaat', 'saath'], answer: 0),
  ChoiceQuestion(prompt: 'Aamdani atthanni, kharcha ______', options: ['rupaiya', 'sawaiya', 'bhaiya', 'kanhaiya'], answer: 0),
  ChoiceQuestion(prompt: 'Sukh ke sab saathi, dukh mein na ______', options: ['koi', 'doi', 'soi', 'roi'], answer: 0),
  ChoiceQuestion(prompt: 'Jungle mein mor nacha, kisne ______', options: ['dekha', 'sikha', 'likha', 'rakha'], answer: 0),
  ChoiceQuestion(prompt: 'Bagal mein chhora, shehar mein ______', options: ['dhindhora', 'sapera', 'basera', 'savera'], answer: 0),
  ChoiceQuestion(prompt: 'Lalach buri ______', options: ['bala', 'kala', 'shaala', 'maala'], answer: 0),
  ChoiceQuestion(prompt: 'Andha kya chahe, do ______', options: ['aankhen', 'baahein', 'raahein', 'chaahein'], answer: 0),
  ChoiceQuestion(prompt: 'Aadmi apne ______ se pehchana jata hai', options: ['karmon', 'kapdon', 'shabdon', 'naamon'], answer: 0),
  ChoiceQuestion(prompt: 'Apna haath ______', options: ['Jagannath', 'Raghunath', 'Vishwanath', 'Somnath'], answer: 0),
  ChoiceQuestion(prompt: '______ ka kutta, na ghar ka na ghaat ka', options: ['Dhobi', 'Maali', 'Baniye', 'Panditji'], answer: 0),
  ChoiceQuestion(prompt: 'Kahan Raja Bhoj, kahan Gangu ______', options: ['teli', 'maali', 'dhobi', 'baniya'], answer: 0),
  ChoiceQuestion(prompt: 'Ghoda ghaas se dosti karega to khayega ______', options: ['kya', 'kahan', 'kaise', 'kab'], answer: 0),
  ChoiceQuestion(prompt: 'Jhooth ke paanv ______', options: ['nahin hote', 'lambe hote', 'chhote hote', 'bade hote'], answer: 0),
  ChoiceQuestion(prompt: 'Laaton ke bhoot ______ se nahin maante', options: ['baaton', 'haathon', 'aankhon', 'pairon'], answer: 0),
  ChoiceQuestion(prompt: 'Laut ke buddhu ghar ko ______', options: ['aaye', 'jaaye', 'gaaye', 'laaye'], answer: 0),
  ChoiceQuestion(prompt: 'Akal badi ya ______', options: ['bhains', 'gaay', 'ghoda', 'haathi'], answer: 0),
  ChoiceQuestion(prompt: 'Billi ke gale mein ghanti kaun ______', options: ['baandhe', 'khole', 'dekhe', 'sune'], answer: 0),
  ChoiceQuestion(prompt: 'Kaante se kaanta ______', options: ['nikalta hai', 'tootta hai', 'chubhta hai', 'jhukta hai'], answer: 0),
  ChoiceQuestion(prompt: 'Angoor ______ hain', options: ['khatte', 'meethe', 'sookhe', 'kachche'], answer: 0),
  ChoiceQuestion(prompt: 'Jaisa raja waisi ______', options: ['praja', 'saja', 'laaj', 'raah'], answer: 0),
  ChoiceQuestion(prompt: 'Hatheli par sarson ______', options: ['jamana', 'ugana', 'bichhana', 'sukhana'], answer: 0),
  ChoiceQuestion(prompt: 'Andher nagari, chaupat ______', options: ['raja', 'praja', 'nagri', 'sajja'], answer: 0),
  ChoiceQuestion(prompt: 'Jhooth bole kauwa ______', options: ['kaate', 'gaaye', 'ude', 'aaye'], answer: 0),
  ChoiceQuestion(prompt: 'Bandar ke haath mein ______', options: ['talwar', 'tasveer', 'kitaab', 'chaabi'], answer: 0),
];
