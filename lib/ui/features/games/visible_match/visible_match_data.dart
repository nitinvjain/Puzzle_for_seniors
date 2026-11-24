/// The pairs for the matching game.
///
/// Each set holds pairs that go together in a way he has known for decades --
/// a state and its capital, a singer and a song, an instrument and the player
/// it is bound up with. Four are drawn from one set for each board, so the
/// four left-hand tiles always belong to the same kind of question and there
/// is only ever one thing being asked.
library;

class MatchPair {
  final String left;
  final String right;
  const MatchPair(this.left, this.right);
}

class MatchSet {
  /// Shown above the board, so the task is stated rather than inferred.
  final String prompt;
  final List<MatchPair> pairs;
  const MatchSet(this.prompt, this.pairs);
}

const List<MatchSet> matchSets = [
  MatchSet('Match each state to its capital', [
    MatchPair('Rajasthan', 'Jaipur'),
    MatchPair('Kerala', 'Thiruvananthapuram'),
    MatchPair('Gujarat', 'Gandhinagar'),
    MatchPair('Assam', 'Dispur'),
    MatchPair('Bihar', 'Patna'),
    MatchPair('Odisha', 'Bhubaneswar'),
    MatchPair('Karnataka', 'Bengaluru'),
    MatchPair('Tamil Nadu', 'Chennai'),
    MatchPair('West Bengal', 'Kolkata'),
    MatchPair('Maharashtra', 'Mumbai'),
    MatchPair('Madhya Pradesh', 'Bhopal'),
    MatchPair('Punjab', 'Chandigarh'),
    MatchPair('Uttar Pradesh', 'Lucknow'),
    MatchPair('Telangana', 'Hyderabad'),
  ]),
  MatchSet('Match each musician to the instrument', [
    // Each right-hand value appears once in a set, so a board can never show
    // the same tile twice: Amjad Ali Khan and Ali Akbar Khan both played the
    // sarod, and having both here would make one board unanswerable.
    MatchPair('Ravi Shankar', 'Sitar'),
    MatchPair('Bismillah Khan', 'Shehnai'),
    MatchPair('Zakir Hussain', 'Tabla'),
    MatchPair('Amjad Ali Khan', 'Sarod'),
    MatchPair('Hariprasad Chaurasia', 'Bansuri'),
    MatchPair('Shivkumar Sharma', 'Santoor'),
    MatchPair('Vilayat Khan', 'Surbahar'),
    MatchPair('Kishan Maharaj', 'Pakhawaj'),
  ]),
  MatchSet('Match each film to its year', [
    MatchPair('Awara', '1951'),
    MatchPair('Mughal-e-Azam', '1960'),
    MatchPair('Guide', '1965'),
    MatchPair('Aradhana', '1969'),
    MatchPair('Sholay', '1975'),
    MatchPair('Amar Akbar Anthony', '1977'),
    MatchPair('Umrao Jaan', '1981'),
    MatchPair('Maine Pyar Kiya', '1989'),
    MatchPair('Lagaan', '2001'),
  ]),
  MatchSet('Match each film to its director', [
    MatchPair('Mughal-e-Azam', 'K. Asif'),
    MatchPair('Pather Panchali', 'Satyajit Ray'),
    MatchPair('Mother India', 'Mehboob Khan'),
    MatchPair('Sholay', 'Ramesh Sippy'),
    MatchPair('Guide', 'Vijay Anand'),
    MatchPair('Pyaasa', 'Guru Dutt'),
    MatchPair('Salaam Bombay', 'Mira Nair'),
    MatchPair('Lagaan', 'Ashutosh Gowariker'),
  ]),
  MatchSet('Match each river to a city on its banks', [
    MatchPair('Ganga', 'Varanasi'),
    MatchPair('Yamuna', 'Delhi'),
    MatchPair('Hooghly', 'Kolkata'),
    MatchPair('Sabarmati', 'Ahmedabad'),
    MatchPair('Musi', 'Hyderabad'),
    MatchPair('Narmada', 'Jabalpur'),
    MatchPair('Gomti', 'Lucknow'),
    MatchPair('Adyar', 'Chennai'),
  ]),
  MatchSet('Match each leader to how they are remembered', [
    MatchPair('Sardar Patel', 'The Iron Man of India'),
    MatchPair('Bal Gangadhar Tilak', 'Lokmanya'),
    MatchPair('Subhas Chandra Bose', 'Netaji'),
    MatchPair('Dadabhai Naoroji', 'The Grand Old Man of India'),
    MatchPair('Lal Bahadur Shastri', 'Jai Jawan Jai Kisan'),
    MatchPair('Rabindranath Tagore', 'Gurudev'),
    MatchPair('Khan Abdul Ghaffar Khan', 'The Frontier Gandhi'),
    MatchPair('Milkha Singh', 'The Flying Sikh'),
  ]),
  MatchSet('Match each dance form to its state', [
    MatchPair('Bharatanatyam', 'Tamil Nadu'),
    MatchPair('Kathakali', 'Kerala'),
    MatchPair('Odissi', 'Odisha'),
    MatchPair('Kuchipudi', 'Andhra Pradesh'),
    MatchPair('Bihu', 'Assam'),
    MatchPair('Garba', 'Gujarat'),
    MatchPair('Bhangra', 'Punjab'),
    MatchPair('Manipuri', 'Manipur'),
  ]),
  MatchSet('Match each festival to what it celebrates', [
    MatchPair('Diwali', 'Lights'),
    MatchPair('Holi', 'Colours'),
    MatchPair('Onam', 'The harvest in Kerala'),
    MatchPair('Pongal', 'The harvest in Tamil Nadu'),
    MatchPair('Raksha Bandhan', 'Brothers and sisters'),
    MatchPair('Baisakhi', 'The harvest in Punjab'),
    MatchPair('Eid-ul-Fitr', 'The end of Ramadan'),
    MatchPair('Makar Sankranti', 'Kites and the turning sun'),
  ]),
];
