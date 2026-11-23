/// Fuller "How to Play" text for the senior build.
///
/// The stock help dialog shows a single-sentence subtitle, which assumes the
/// player can work the rest out by experimenting. That assumption does not
/// hold for someone who may be opening the game for the first time every time,
/// so each entry here gives a plain-language goal, two to four concrete steps,
/// and one worked example.
///
/// Writing guidance for anyone extending this:
///   * short sentences, everyday words, no jargon unless the game is about the
///     jargon (Roman numerals, modulo);
///   * steps describe what to DO with a finger, not what the game "is";
///   * the example uses real numbers and states the answer, so it can be
///     read and understood without touching anything.
library;

class GameRules {
  /// One sentence: what counts as success.
  final String goal;

  /// Two to four actions, in the order the player performs them.
  final List<String> steps;

  /// A worked example with real values, including the answer.
  final String example;

  const GameRules({
    required this.goal,
    required this.steps,
    required this.example,
  });
}

/// Keyed by `GameMetadata.id`. A game with no entry falls back to the stock
/// subtitle, so this map can be filled in a category at a time.
const Map<String, GameRules> gameRules = {
  // ---------------------------------------------------------------- arithmetic
  'quick_math': GameRules(
    goal: 'Answer each arithmetic question correctly.',
    steps: [
      'A sum appears in the middle of the screen.',
      'Work it out in your head.',
      'Tap the button showing the right answer.',
    ],
    example: 'The screen shows  7 × 6 = ?  — tap 42.',
  ),
  'calculation_sprint': GameRules(
    goal: 'Solve each equation as it appears.',
    steps: [
      'One equation is shown at a time.',
      'Tap the answer you think is correct.',
      'A new equation appears straight away.',
    ],
    example: 'The screen shows  15 + 27 = ?  — tap 42.',
  ),
  'arithmetic_chain': GameRules(
    goal: 'Keep a running total in your head as numbers arrive.',
    steps: [
      'Numbers and signs appear one after another.',
      'Add or subtract each one to your running total.',
      'At the end, tap the final total.',
    ],
    example: 'Start 10, then +5, then −3. The total is 12.',
  ),
  'numerical_estimation': GameRules(
    goal: 'Pick the answer that is closest, without working it out exactly.',
    steps: [
      'A calculation appears that is awkward to do precisely.',
      'Judge roughly how big the answer should be.',
      'Tap the closest of the choices offered.',
    ],
    example: '198 × 21 is close to 200 × 20 = 4000, so pick about 4158.',
  ),
  'countdown_math': GameRules(
    goal: 'Reach the target number using the numbers given.',
    steps: [
      'You are given several numbers and a three-digit target.',
      'Combine them with +, −, × and ÷ to reach the target.',
      'You need not use every number.',
    ],
    example: 'Target 342 from 50, 7, 6, 2:  50 × 7 = 350, then − 6 − 2 = 342.',
  ),
  'target_number': GameRules(
    goal: 'Use all four numbers once each to reach the target.',
    steps: [
      'Four numbers are shown.',
      'Combine them with +, −, × and ÷.',
      'Every number must be used exactly once.',
    ],
    example: 'From 4, 7, 8, 8 reach 24:  (8 ÷ 8 + 7) × 4 ÷ … — or 4 × 8 − 8 = 24.',
  ),
  'target_10': GameRules(
    goal: 'Clear tiles by picking ones that add up to ten.',
    steps: [
      'The board is full of number tiles.',
      'Tap two or more tiles that together make exactly 10.',
      'They disappear and new tiles drop in.',
    ],
    example: 'Tap 6 and 4. Or tap 5, 3 and 2 — those also make 10.',
  ),
  'missing_operator': GameRules(
    goal: 'Put the right sign into the equation so it comes out true.',
    steps: [
      'An equation is shown with one sign missing.',
      'Decide whether it needs +, −, × or ÷.',
      'Tap that sign.',
    ],
    example: '6 ? 3 = 18 — the answer is ×, because 6 × 3 = 18.',
  ),
  'sum_pyramid': GameRules(
    goal: 'Fill the pyramid so each block equals the two blocks below it added together.',
    steps: [
      'Start from a row where two blocks beside each other are both filled.',
      'Add them, and write the total in the block resting on top.',
      'Work upwards until the pyramid is complete.',
    ],
    example: 'If two blocks show 4 and 7, the block above them is 11.',
  ),
  'sum_snake': GameRules(
    goal: 'Trace a path through the grid that adds up to the target.',
    steps: [
      'A target total is shown above the grid.',
      'Drag from one number to the next, through touching squares.',
      'Release when your path adds up to the target.',
    ],
    example: 'Target 12: drag across 5, then 3, then 4 — together they make 12.',
  ),
  'math_path': GameRules(
    goal: 'Find a route through the grid whose numbers add up to the target.',
    steps: [
      'The target total is shown above the grid.',
      'Tap squares in order to build a path.',
      'The path is correct when the numbers add up exactly.',
    ],
    example: 'Target 15 from 6, 4, 5 along the path — 6 + 4 + 5 = 15.',
  ),
  'math_maze': GameRules(
    goal: 'Trace a path through the grid that works out to the target.',
    steps: [
      'Start at the top-left square and finish at the bottom-right.',
      'Move one square at a time, applying each sign as you reach it.',
      'Your running total at the end must equal the target shown.',
    ],
    example: 'Starting at 5, then passing + 3 and × 2, your total is 16.',
  ),
  'number_bonds': GameRules(
    goal: 'Join numbers together so they make the target sum.',
    steps: [
      'Circles of numbers are shown, with a target in the middle.',
      'Tap two numbers that add up to the target.',
      'They link together, and you move on to the next pair.',
    ],
    example: 'Target 10: link 7 and 3.',
  ),
  'math_guess': GameRules(
    goal: 'Work out the hidden number from the hints you are given.',
    steps: [
      'Type a number and submit it.',
      'The game says whether the hidden number is higher or lower.',
      'Use that to narrow down your next guess.',
    ],
    example: 'You guess 50 and it says "lower", so try 25 next.',
  ),

  // ------------------------------------------------------------------- number
  'prime_hunter': GameRules(
    goal: 'Decide whether each number is prime or composite.',
    steps: [
      'A prime number can only be divided by 1 and itself.',
      'A composite number has other divisors too.',
      'Swipe LEFT for prime, swipe RIGHT for composite.',
    ],
    example: '7 divides only by 1 and 7, so swipe left. 9 = 3 × 3, so swipe right.',
  ),
  'prime_gap_hunt': GameRules(
    goal: 'Work out the gap between two prime numbers in a row.',
    steps: [
      'Two consecutive primes are shown.',
      'Subtract the smaller from the larger.',
      'Tap that difference.',
    ],
    example: 'Between 17 and 19 the gap is 19 − 17 = 2.',
  ),
  'prime_factor_trees': GameRules(
    goal: 'Break a number down into the primes it is made of.',
    steps: [
      'Start with the number at the top.',
      'Split it into two numbers that multiply to give it.',
      'Keep splitting until every end of the tree is a prime.',
    ],
    example: '12 splits into 4 × 3, then the 4 splits into 2 × 2. So 12 = 2 × 2 × 3.',
  ),
  'factor_finder': GameRules(
    goal: 'Find every number that divides exactly into the target.',
    steps: [
      'A target number is shown.',
      'Tap each number that divides into it with nothing left over.',
      'Miss none — all of them are needed.',
    ],
    example: 'For 12, the factors are 1, 2, 3, 4, 6 and 12.',
  ),
  'divisibility_dash': GameRules(
    goal: 'Tap every single digit that divides exactly into the number shown.',
    steps: [
      'A number appears, with the digits 2 to 9 below it.',
      'Tap each digit that goes into it exactly.',
      'Leave the others alone.',
    ],
    example: 'For 18, tap 2, 3, 6 and 9. Nothing else divides it exactly.',
  ),
  'common_denominator': GameRules(
    goal: 'Find the highest common factor, or the lowest common multiple.',
    steps: [
      'Two numbers are shown, and the game says which you need.',
      'The highest common factor is the biggest number that divides both.',
      'The lowest common multiple is the smallest number both divide into.',
    ],
    example: 'For 12 and 18: the highest common factor is 6, the lowest common multiple is 36.',
  ),
  'sequence_sleuth': GameRules(
    goal: 'Work out the missing number in the sequence.',
    steps: [
      'A row of numbers is shown with one gap.',
      'Find the rule — each step may add, subtract, or multiply.',
      'Tap the number that fits the gap.',
    ],
    example: '2, 4, 8, ?, 32 — each number doubles, so the answer is 16.',
  ),
  'fibonacci_merge': GameRules(
    goal: 'Build bigger Fibonacci numbers by merging neighbours.',
    steps: [
      'The Fibonacci run is 1, 1, 2, 3, 5, 8, 13, 21 — each is the two before it added.',
      'Swipe to slide the tiles.',
      'When two tiles that sit next to each other in that run touch, they merge into the next one.',
    ],
    example: 'A 3 tile meeting a 5 tile becomes 8, because 3 + 5 = 8.',
  ),
  'collatz': GameRules(
    goal: 'Follow the 3n+1 sequence down to 1.',
    steps: [
      'If the number is even, halve it.',
      'If the number is odd, multiply by 3 and add 1.',
      'Tap the correct next number each time.',
    ],
    example: 'From 5 (odd): 3 × 5 + 1 = 16. From 16 (even): 16 ÷ 2 = 8.',
  ),
  'radical_roots': GameRules(
    goal: 'Find the square root or cube root of the number shown.',
    steps: [
      'The square root asks: what number times itself gives this?',
      'The cube root asks: what number times itself three times gives this?',
      'Round to the nearest whole number if it is not exact.',
    ],
    example: 'The square root of 81 is 9, because 9 × 9 = 81.',
  ),
  'exponent_tower': GameRules(
    goal: 'Put the power expressions in order, smallest first.',
    steps: [
      'Several expressions like 2⁵ or 3³ are shown.',
      'Work out what each one comes to.',
      'Drag them into order, smallest on the left.',
    ],
    example: '2³ = 8 and 3² = 9, so 2³ comes first.',
  ),

  // ------------------------------------------------------------- base & modulo
  'binary_code': GameRules(
    goal: 'Turn a binary number into an ordinary one.',
    steps: [
      'Binary uses only 0 and 1.',
      'Each place is worth double the one to its right: 1, 2, 4, 8, 16…',
      'Add up the places that show a 1.',
    ],
    example: '1011 = 8 + 0 + 2 + 1 = 11.',
  ),
  'base_conversion_run': GameRules(
    goal: 'Convert a number between binary, decimal, hexadecimal and octal.',
    steps: [
      'The game says which base you are starting from and which you need.',
      'Binary counts in twos, octal in eights, hexadecimal in sixteens.',
      'Tap or type the converted value.',
    ],
    example: 'Decimal 255 is FF in hexadecimal, and 11111111 in binary.',
  ),
  'base_shift': GameRules(
    goal: 'Work the sum out and give the answer in decimal.',
    steps: [
      'The numbers may be shown in another base.',
      'Convert them to ordinary decimal numbers first.',
      'Then do the arithmetic and tap the answer.',
    ],
    example: 'Binary 101 is 5, so 101 + 3 = 8.',
  ),
  'binary_scale_balance': GameRules(
    goal: 'Make the scale balance by choosing the right weights.',
    steps: [
      'A target weight is shown on one side.',
      'The weights you can add are 1, 2, 4, 8, 16 and 32 — each double the last.',
      'Tap weights until your side matches the target exactly.',
    ],
    example: 'To reach 22, use 16 + 4 + 2. Each weight may be used once.',
  ),
  'modulo_clock': GameRules(
    goal: 'Do the arithmetic the way a clock does, wrapping round at 12.',
    steps: [
      'Work out the sum normally first.',
      'If the answer is more than 12, keep subtracting 12 until it is not.',
      'Tap the hour you land on.',
    ],
    example: '9 + 5 = 14, and 14 − 12 = 2. So the answer is 2 o\'clock.',
  ),
  'modular_clock_arithmetic': GameRules(
    goal: 'Work out clock arithmetic using modulo 12.',
    steps: [
      'Add or subtract the hours as the question asks.',
      'Wrap round at 12 — after 12 comes 1 again.',
      'Tap the resulting hour.',
    ],
    example: '10 + 4 = 14, which on a clock is 2.',
  ),
  'modulo_path': GameRules(
    goal: 'Walk from the top-left square to the bottom-right one.',
    steps: [
      'The panel shows a divisor and a remainder, for example "divide by 3, remainder 1".',
      'You may only step on a square whose number leaves exactly that remainder.',
      'Move one square at a time, up, down, left or right.',
    ],
    example: 'Divide by 3, remainder 1: you may step on 4, 7, 10 or 13, since each leaves 1. You may not step on 6 or 9.',
  ),
  'roman_arithmetic': GameRules(
    goal: 'Add or subtract numbers written as Roman numerals.',
    steps: [
      'I = 1, V = 5, X = 10, L = 50, C = 100, D = 500, M = 1000.',
      'A smaller letter before a bigger one means subtract: IV = 4.',
      'Convert, do the sum, then give the answer.',
    ],
    example: 'XII + V = 12 + 5 = 17, which is XVII.',
  ),

  // ---------------------------------------------------------------- fractions
  'fraction_match': GameRules(
    goal: 'Match the picture to the fraction it shows.',
    steps: [
      'A shape is shown with part of it shaded.',
      'Count how many equal parts there are, and how many are shaded.',
      'Tap the fraction that matches.',
    ],
    example: 'Three parts shaded out of four is ¾.',
  ),
  'fraction_matcher': GameRules(
    goal: 'Pair up fractions that are worth the same.',
    steps: [
      'Fractions are shown, some written and some as pictures.',
      'Two fractions match if one simplifies to the other.',
      'Tap a pair to link them.',
    ],
    example: '2/4 is the same as 1/2.',
  ),
  'fractional_pizza': GameRules(
    goal: 'Take pizza slices that add up to the fraction asked for.',
    steps: [
      'The target fraction is shown above.',
      'Tap slices to add them up.',
      'Stop when the slices you have taken match the target.',
    ],
    example: 'For ¾, take three slices from a pizza cut into four.',
  ),
  'percentage_peak': GameRules(
    goal: 'Work out the percentage in your head.',
    steps: [
      'To find 10%, divide by 10. To find 50%, halve it.',
      'Build other percentages from those.',
      'Tap the answer.',
    ],
    example: '20% of 150: 10% is 15, so 20% is 30.',
  ),
  'percentage_shopping': GameRules(
    goal: 'Work out the discount and what there is left to pay.',
    steps: [
      'The original price and the discount are shown.',
      'Find the discount amount, then take it off the price.',
      'Tap the final total.',
    ],
    example: '20% off ₹500: the discount is ₹100, so you pay ₹400.',
  ),
  'unit_converter_pro': GameRules(
    goal: 'Convert a measurement from one unit to another.',
    steps: [
      'The value and the unit you need are shown.',
      'Multiply or divide by the right factor.',
      'Tap the converted value.',
    ],
    example: '2.5 kilometres is 2500 metres, because 1 km = 1000 m.',
  ),

  // -------------------------------------------------------------------- grids
  'kenken': GameRules(
    goal: 'Fill the grid so no number repeats in any row or column.',
    steps: [
      'The grid is divided into outlined blocks called cages.',
      'Each cage shows a target and a sign, such as "12×".',
      'The numbers in that cage must give the target using that sign.',
    ],
    example: 'A two-square cage marked "3+" holds 1 and 2, because 1 + 2 = 3.',
  ),
  'magic_squares': GameRules(
    goal: 'Fill the square so every row, column and diagonal adds to the same total.',
    steps: [
      'The target total is shown above the grid.',
      'Find a line with only one empty square.',
      'Work out what is missing, and fill it in.',
    ],
    example: 'If a row needs 15 and already shows 8 and 3, the last square is 4.',
  ),
  'matrix_multiplier': GameRules(
    goal: 'Pick a row and a column whose product hits the target.',
    steps: [
      'A target number is shown.',
      'Choose one row and one column.',
      'Their values multiply together — aim for the target.',
    ],
    example: 'Target 24: pick the row holding 6 and the column holding 4.',
  ),
  'matrix_multiplier_match': GameRules(
    goal: 'Multiply row and column values to match the target.',
    steps: [
      'Multiply each pair, then add the results.',
      'Compare what you get with the target.',
      'Select the row and column that match it.',
    ],
    example: 'Row (2, 3) with column (4, 1) gives 2×4 + 3×1 = 11.',
  ),
  'binary_matrix_rank': GameRules(
    goal: 'Find the rank of a 3×3 grid of 0s and 1s.',
    steps: [
      'The rank is the number of rows that are genuinely independent.',
      'A row that can be made by combining others does not count.',
      'In this arithmetic, 1 + 1 = 0.',
    ],
    example: 'If one row is the other two added together, the rank is 2, not 3.',
  ),
  'graph_coordinate_plot': GameRules(
    goal: 'Plot the points that sit on the line or curve given.',
    steps: [
      'An equation is shown, such as y = 2x + 1.',
      'Work out y for each x.',
      'Tap the grid square at each point.',
    ],
    example: 'For y = 2x + 1, when x = 3 then y = 7, so plot (3, 7).',
  ),
  'area_perimeter_match': GameRules(
    goal: 'Draw a rectangle with both the area and the perimeter asked for.',
    steps: [
      'Area is the two sides multiplied together.',
      'Perimeter is all four sides added up.',
      'Drag on the grid to draw a rectangle, then adjust until both match.',
    ],
    example: 'For area 12 and perimeter 14, draw 3 squares by 4: 3 × 4 = 12, and 3 + 4 + 3 + 4 = 14.',
  ),
  'angle_finder': GameRules(
    goal: 'Work out the angle that is missing.',
    steps: [
      'Angles in a triangle add up to 180°.',
      'Angles on a straight line also add up to 180°.',
      'Subtract what you know from the total.',
    ],
    example: 'A triangle has 60° and 70°, so the third angle is 180 − 130 = 50°.',
  ),
  'pythagorean_triple_builder': GameRules(
    goal: 'Find the missing side of a right-angled triangle.',
    steps: [
      'The two short sides squared and added give the long side squared.',
      'That is a² + b² = c².',
      'Work out the missing value and tap it.',
    ],
    example: 'With sides 3 and 4: 9 + 16 = 25, and the square root of 25 is 5.',
  ),
  'vector_dot_product': GameRules(
    goal: 'Work out the dot product of two vectors.',
    steps: [
      'Multiply the two x values together.',
      'Multiply the two y values together.',
      'Add those two results.',
    ],
    example: '(3, 4) · (2, 5) = 3×2 + 4×5 = 6 + 20 = 26.',
  ),
  'vektor_vector': GameRules(
    goal: 'Scale the vectors so that together they land on the target.',
    steps: [
      'Each vector points in a direction by a certain amount.',
      'Adjust how far each one stretches.',
      'Their combined end point should reach the target.',
    ],
    example: 'Doubling a vector of (1, 2) makes it (2, 4).',
  ),

  // -------------------------------------------------------------------- logic
  'algebraic_balance': GameRules(
    goal: 'Solve the equations so they reach the target total.',
    steps: [
      'Whatever you do to one side, do to the other.',
      'Work out what the unknown letter stands for.',
      'Tap the value you arrive at.',
    ],
    example: 'If x + 7 = 12, take 7 off both sides: x = 5.',
  ),
  'algebraic_inequality_solver': GameRules(
    goal: 'Solve the inequality for the unknown.',
    steps: [
      'Treat it like an equation, keeping both sides balanced.',
      'If you multiply or divide by a negative, flip the sign round.',
      'Tap the answer.',
    ],
    example: '2x + 3 > 11 becomes 2x > 8, so x > 4.',
  ),
  'inequality_dash': GameRules(
    goal: 'Decide whether the inequality is true.',
    steps: [
      'Work out both sides.',
      'Compare them.',
      'Answer whether the statement holds.',
    ],
    example: '3 × 4 > 10 is true, because 12 is more than 10.',
  ),
  'inequality_balance_ops': GameRules(
    goal: 'Put the right comparison sign between the two sides.',
    steps: [
      'Work out the value of each side.',
      'Decide whether the left is bigger, smaller, or equal.',
      'Tap <, > or =.',
    ],
    example: '5 × 3 and 20 − 4: that is 15 and 16, so the sign is <.',
  ),
  'balance_scale': GameRules(
    goal: 'Work out what the last shape weighs.',
    steps: [
      'Each scale shown is balanced: both sides weigh the same.',
      'Use the first scales to find what one shape is worth.',
      'Carry that into the next scale until you can answer the last one.',
    ],
    example: 'If 2 circles balance 1 square, and 1 square weighs 6, then a circle weighs 3.',
  ),
  'binomial_match': GameRules(
    goal: 'Match each quadratic to its factorised form.',
    steps: [
      'Look for two numbers that multiply to the last term.',
      'Those same two must add to the middle term.',
      'Match the expression to that pair of brackets.',
    ],
    example: 'x² + 5x + 6 = (x + 2)(x + 3), because 2 × 3 = 6 and 2 + 3 = 5.',
  ),
  'crypto_arithmetic': GameRules(
    goal: 'Work out which digit each letter stands for.',
    steps: [
      'Each letter is a digit from 0 to 9, and the same letter is always the same digit.',
      'Start with the column that gives you the most to go on.',
      'Fill in digits until the sum works.',
    ],
    example: 'In AB + B = CA, try digits until both columns add up correctly.',
  ),
  'digit_swap_eq': GameRules(
    goal: 'Make both sums correct by swapping one digit between them.',
    steps: [
      'Two sums are shown, and both are wrong as they stand.',
      'Tap a digit in the top sum, then tap a digit in the bottom sum.',
      'The two digits trade places. Both sums should now be right.',
    ],
    example: 'If the sums read 2 + 5 = 9 and 3 + 4 = 7, swapping the 2 and the 3 gives 3 + 5 = 8 — keep trying pairs until both work.',
  ),
  'set_theory_venn': GameRules(
    goal: 'Shade the part of the Venn diagram the formula describes.',
    steps: [
      'The overlap means "in both".',
      '"Union" means "in either one".',
      'Tap every region the formula covers.',
    ],
    example: 'A ∩ B is only the overlap where the two circles cross.',
  ),
  'venn_numbers': GameRules(
    goal: 'Put each number into the right part of the diagram.',
    steps: [
      'Each circle has a rule, such as "even" or "multiple of 3".',
      'A number that fits both rules goes in the overlap.',
      'Drag each number where it belongs.',
    ],
    example: '6 is even and a multiple of 3, so it goes in the overlap.',
  ),
  'mental_abacus': GameRules(
    goal: 'Read the soroban abacus and give the number it shows.',
    steps: [
      'Each column is one digit. The bar runs across the middle.',
      'The single bead ABOVE the bar is worth 5 when pushed down to it.',
      'Each bead BELOW the bar is worth 1 when pushed up to it. Beads away from the bar count as nothing.',
    ],
    example: 'In one column, the top bead pushed down (5) with three lower beads pushed up (3) shows 8.',
  ),
  'mental_calendar': GameRules(
    goal: 'Say which day of the week a date falls on.',
    steps: [
      'You are told one day to anchor from, or you work from the month shown.',
      'Days repeat every 7, so counting on in sevens keeps the same weekday.',
      'Count the remaining days forward and tap the answer.',
    ],
    example: 'If the 3rd is a Tuesday, then the 10th, 17th and 24th are Tuesdays. The 20th is 17 + 3, so it is a Friday.',
  ),
  'game_2048': GameRules(
    goal: 'Merge matching tiles to build up to 2048.',
    steps: [
      'Swipe to slide every tile in that direction.',
      'Two tiles with the same number merge into their total.',
      'A new tile appears after each move.',
    ],
    example: 'Two 4 tiles sliding together make an 8.',
  ),
};
