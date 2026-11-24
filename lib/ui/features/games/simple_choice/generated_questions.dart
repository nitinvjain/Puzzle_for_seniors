/// The three games whose questions are built rather than written down:
/// which came first, the times-table drill, and odd one out.
library;

import 'dart:math';

import 'choice_question.dart';

// ---------------------------------------------------------------------------
// WHICH CAME FIRST
// ---------------------------------------------------------------------------

/// Something with a year attached.
class _Dated {
  final String label;
  final int year;
  const _Dated(this.label, this.year);
}

/// Everything here happened inside his lifetime or just before it, and almost
/// all of it between his fifteenth and fortieth year. That is deliberate:
/// memory for the years either side of thirty stays vivid when yesterday has
/// gone, so these are the dates he is most likely to be sure of.
const List<_Dated> _timeline = [
  // --------------------------------------------------------------- the films
  _Dated('The film Awara', 1951),
  _Dated('The film Shree 420', 1955),
  _Dated('The film Pyaasa', 1957),
  _Dated('The film Mother India', 1957),
  _Dated('The film Madhumati', 1958),
  _Dated('The film Kaagaz Ke Phool', 1959),
  _Dated('The film Mughal-e-Azam', 1960),
  _Dated('The film Chaudhvin Ka Chand', 1960),
  _Dated('The film Hum Dono', 1961),
  _Dated('The film Woh Kaun Thi', 1964),
  _Dated('The film Guide', 1965),
  _Dated('The film Teesri Manzil', 1966),
  _Dated('The film Aradhana', 1969),
  _Dated('The film Mera Naam Joker', 1970),
  _Dated('The film Kati Patang', 1970),
  _Dated('The film Anand', 1971),
  _Dated('The film Hare Rama Hare Krishna', 1971),
  _Dated('The film Pakeezah', 1972),
  _Dated('The film Amar Prem', 1972),
  _Dated('The film Zanjeer', 1973),
  _Dated('The film Bobby', 1973),
  _Dated('The film Yaadon Ki Baaraat', 1973),
  _Dated('The film Sholay', 1975),
  _Dated('The film Deewaar', 1975),
  _Dated('The film Aandhi', 1975),
  _Dated('The film Kabhi Kabhie', 1976),
  _Dated('The film Amar Akbar Anthony', 1977),
  _Dated('The film Don', 1978),
  _Dated('The film Satyam Shivam Sundaram', 1978),
  _Dated('The film Karz', 1980),
  _Dated('The film Umrao Jaan', 1981),
  _Dated('The film Namak Halaal', 1982),
  _Dated('The film Mr India', 1987),
  _Dated('The film Qayamat Se Qayamat Tak', 1988),
  _Dated('The film Maine Pyar Kiya', 1989),
  _Dated('The film Hum Aapke Hain Koun', 1994),
  _Dated('The film Dilwale Dulhania Le Jayenge', 1995),
  _Dated('The film Kuch Kuch Hota Hai', 1998),
  _Dated('The film Lagaan', 2001),
  _Dated('The film 3 Idiots', 2009),

  // ------------------------------------------------------------- the country
  _Dated('India’s independence', 1947),
  _Dated('The Constitution of India coming into force', 1950),
  _Dated('India’s first general election', 1952),
  _Dated('The reorganisation of the states by language', 1956),
  _Dated('The liberation of Goa', 1961),
  _Dated('The war with China', 1962),
  _Dated('The death of Jawaharlal Nehru', 1964),
  _Dated('The war with Pakistan over Kashmir', 1965),
  _Dated('The death of Lal Bahadur Shastri', 1966),
  _Dated('The war that led to Bangladesh', 1971),
  _Dated('The declaration of the Emergency', 1975),
  _Dated('The assassination of Indira Gandhi', 1984),
  _Dated('The assassination of Rajiv Gandhi', 1991),
  _Dated('The opening up of the Indian economy', 1991),
  _Dated('Bombay being renamed Mumbai', 1995),
  _Dated('The nuclear tests at Pokhran', 1998),
  _Dated('The Kargil conflict', 1999),
  _Dated('The opening of the Delhi Metro', 2002),

  // ------------------------------------------------------- sport and science
  _Dated('India’s first Test match', 1932),
  _Dated('Milkha Singh’s run at the Rome Olympics', 1960),
  _Dated('The first Cricket World Cup', 1975),
  _Dated('India winning the Cricket World Cup', 1983),
  _Dated('India winning the first Twenty20 World Cup', 2007),
  _Dated('India winning the Cricket World Cup at home', 2011),
  _Dated('The launch of Sputnik', 1957),
  _Dated('The first man on the Moon', 1969),
  _Dated('India’s first satellite, Aryabhata', 1975),
  _Dated('Rakesh Sharma’s flight into space', 1984),
  _Dated('The Chandrayaan-1 mission to the Moon', 2008),
  _Dated('The launch of the Mangalyaan mission to Mars', 2013),
];

/// Four things, one clearly earliest.
///
/// The gap between the earliest and the next is kept to at least five years,
/// so the answer never turns on remembering which of two things in the same
/// season came first -- that would be a memory test, which is the thing this
/// game is meant to avoid.
List<ChoiceQuestion> buildWhichCameFirst(Random random, int count) {
  final out = <ChoiceQuestion>[];
  final used = <String>{};
  var guard = 0;

  while (out.length < count && guard++ < count * 200) {
    final pick = <_Dated>[];
    final pool = [..._timeline]..shuffle(random);
    for (final item in pool) {
      if (pick.any((p) => (p.year - item.year).abs() < 5)) continue;
      pick.add(item);
      if (pick.length == 4) break;
    }
    if (pick.length < 4) continue;

    pick.sort((a, b) => a.year - b.year);
    if (pick[1].year - pick[0].year < 5) continue;
    final key = pick[0].label;
    if (!used.add(key)) continue;

    out.add(ChoiceQuestion(
      prompt: 'Which of these came first?',
      options: pick.map((p) => p.label).toList(),
      answer: 0,
    ));
  }
  return out;
}

// ---------------------------------------------------------------------------
// TIMES TABLES
// ---------------------------------------------------------------------------

/// Straight multiplication, up to the twenty times table.
///
/// For a man who taught maths for forty years this is not arithmetic so much
/// as reflex: it was drilled, then taught, then taught again for decades, and
/// that kind of knowing is the last to go. The point is not practice. It is
/// twelve seconds of being quick and right at something.
///
/// The wrong answers are the mistakes the table itself invites -- one row up,
/// one row down, the digits turned around -- so a right answer means he
/// actually knew it.
List<ChoiceQuestion> buildTables(Random random, int count) {
  final out = <ChoiceQuestion>[];
  final seen = <String>{};
  var guard = 0;

  while (out.length < count && guard++ < count * 200) {
    final a = 2 + random.nextInt(19); // 2..20
    final b = 2 + random.nextInt(19);
    final key = '$a x $b';
    if (!seen.add(key)) continue;

    final right = a * b;
    final candidates = <int>{
      right + a,
      right - a,
      right + b,
      right - b,
      right + 10,
      _reverseDigits(right),
    }..removeWhere((v) => v == right || v <= 0);
    if (candidates.length < 3) continue;

    final wrongs = candidates.toList()..shuffle(random);
    final options = [right.toString(), ...wrongs.take(3).map((e) => e.toString())];
    options.shuffle(random);

    out.add(ChoiceQuestion(
      prompt: '$a × $b',
      options: options,
      answer: options.indexOf(right.toString()),
    ));
  }
  return out;
}

int _reverseDigits(int n) {
  final s = n.toString().split('').reversed.join();
  return int.tryParse(s) ?? n + 1;
}

// ---------------------------------------------------------------------------
// ODD ONE OUT
// ---------------------------------------------------------------------------

/// Everyday categories. Three from one, one from another.
///
/// Sorting things into kinds is semantic memory, which holds up far longer
/// than remembering a list, and the answer reads in a second or two without
/// anything having to be held in mind.
const Map<String, List<String>> _categories = {
  'fruit': ['Mango', 'Banana', 'Apple', 'Guava', 'Papaya', 'Orange', 'Grapes', 'Pomegranate'],
  'vegetable': ['Potato', 'Brinjal', 'Cauliflower', 'Spinach', 'Carrot', 'Peas', 'Okra', 'Pumpkin'],
  'bird': ['Peacock', 'Sparrow', 'Parrot', 'Crow', 'Pigeon', 'Owl', 'Eagle', 'Koel'],
  'animal': ['Tiger', 'Elephant', 'Camel', 'Horse', 'Monkey', 'Deer', 'Buffalo', 'Goat'],
  'flower': ['Rose', 'Lotus', 'Marigold', 'Jasmine', 'Sunflower', 'Lily', 'Hibiscus', 'Tulip'],
  'colour': ['Red', 'Blue', 'Green', 'Yellow', 'Black', 'White', 'Purple', 'Orange'],
  'part of the body': ['Hand', 'Foot', 'Ear', 'Nose', 'Elbow', 'Shoulder', 'Knee', 'Finger'],
  'vehicle': ['Bus', 'Train', 'Rickshaw', 'Bicycle', 'Aeroplane', 'Scooter', 'Lorry', 'Boat'],
  'musical instrument': ['Sitar', 'Tabla', 'Flute', 'Harmonium', 'Sarod', 'Veena', 'Shehnai', 'Dholak'],
  'metal': ['Iron', 'Copper', 'Silver', 'Gold', 'Brass', 'Aluminium', 'Tin', 'Zinc'],
  'river': ['Ganga', 'Yamuna', 'Godavari', 'Narmada', 'Kaveri', 'Krishna', 'Brahmaputra', 'Sutlej'],
  'city': ['Delhi', 'Mumbai', 'Chennai', 'Kolkata', 'Jaipur', 'Lucknow', 'Patna', 'Bengaluru'],
  'month': ['January', 'March', 'June', 'August', 'October', 'December', 'April', 'September'],
  'relative': ['Mother', 'Father', 'Brother', 'Sister', 'Uncle', 'Aunt', 'Nephew', 'Cousin'],
  'piece of furniture': ['Chair', 'Table', 'Bed', 'Almirah', 'Stool', 'Bench', 'Sofa', 'Shelf'],
  'thing to wear': ['Shirt', 'Saree', 'Dhoti', 'Sweater', 'Shawl', 'Kurta', 'Cap', 'Shoes'],
  'tree': ['Banyan', 'Neem', 'Peepal', 'Mango tree', 'Coconut palm', 'Tamarind', 'Teak', 'Babul'],
  'sweet': ['Laddoo', 'Jalebi', 'Barfi', 'Rasgulla', 'Gulab jamun', 'Halwa', 'Peda', 'Kheer'],
  'spice': ['Turmeric', 'Cumin', 'Coriander', 'Cardamom', 'Clove', 'Pepper', 'Cinnamon', 'Mustard'],
  'day of the week': ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
};

List<ChoiceQuestion> buildOddOneOut(Random random, int count) {
  final names = _categories.keys.toList();
  final out = <ChoiceQuestion>[];
  final seen = <String>{};
  var guard = 0;

  while (out.length < count && guard++ < count * 200) {
    final home = names[random.nextInt(names.length)];
    var away = names[random.nextInt(names.length)];
    if (away == home) continue;

    // 'Orange' is both a fruit and a colour, and 'Monday morning' is not a
    // day: a word that sits in two of these lists would make the question
    // have two right answers, so pairs that share a word are thrown away.
    final homeWords = _categories[home]!;
    final awayWords = _categories[away]!;
    if (homeWords.toSet().intersection(awayWords.toSet()).isNotEmpty) continue;

    final three = ([...homeWords]..shuffle(random)).take(3).toList();
    final intruder = awayWords[random.nextInt(awayWords.length)];
    if (three.contains(intruder)) continue;

    final key = ([...three, intruder]..sort()).join('|');
    if (!seen.add(key)) continue;

    final options = [...three, intruder]..shuffle(random);
    out.add(ChoiceQuestion(
      prompt: 'Which one does not belong?',
      note: 'Three of these are the same kind of thing',
      options: options,
      answer: options.indexOf(intruder),
    ));
  }
  return out;
}
