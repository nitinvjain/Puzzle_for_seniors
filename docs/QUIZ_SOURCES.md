# Where the KBC India questions came from

The quiz bank is assembled, not copied. For each source the subject and the
answer are taken; the wording and all four options are written fresh, and
anything that rests on recent learning is left behind. That filter is the
whole point: recent memory is the first faculty vascular dementia takes, so
a question about last season's cricket is one he will always miss, and not
because he does not know.

## Banks and their sources

| File | Questions | Source |
|---|---|---|
| `quiz_bank_*.dart` (the original set) | — | written here, by topic |
| `quiz_bank_quizbook.dart` … `quizbook4.dart` | 189 in the last | Bournvita Quiz Book, sets 1–14 |
| `quiz_bank_kbc_archive.dart` | 39 | gksection.com archive, 4 pages |
| `quiz_bank_kbc_archive2.dart` | 101 | the same archive, 13 pages |
| `quiz_bank_kbc_archive3.dart` | 58 | the same archive, 8 pages |
| `quiz_bank_kbc_archive4.dart` | 102 | seasons 11–12, 13 pages |
| `quiz_bank_kbc_archive5.dart` | 103 | seasons 12–13, 12 pages |
| `quiz_bank_kbc_archive6.dart` | 321 | season 17, episodes 70–95 |
| `quiz_bank_kbc_archive7.dart` | 344 | **season 17, episodes 44–69** (not 46) |
| `quiz_bank_figures.dart` | 145 | written here, each with a drawing |

Banks 1–3 drew on seasons 9 to 11; their exact episode pages were not
recorded at the time, which is why this file exists. From bank 4 onwards
the pages are named, so a later batch can pick up where the last one
stopped instead of guessing and relying on the duplicate check to notice.

## Pages consumed, by season

* **seasons 9–11** — 25 pages, episodes not recorded (banks 1–3)
* **season 11** — 6 pages, and **season 12** — 7 pages (bank 4)
* **season 12** — 3 pages, and **season 13** — 9 pages (bank 5)
* **season 17** — episodes 70 to 95, all 26 pages (bank 6)
* **season 17** — episodes 44 to 69, all but 46, which would not load (bank 7)

Still untouched: most of seasons 9, 10, 12 and 13, all of 14, 15 and 16,
season 17 below episode 44, and season 18. Roughly 495 pages. Episode 46
of season 17 is unread and worth another try.

Note that the season 9 and 10 pages use a different URL shape
(`kbc-9-episode-N-questions-answers-hindi`) from seasons 11 and later
(`kbc-NN-questions-and-answers-episode-N`), and the older shape was not
reachable when bank 6 was built.

## Yield, and what it depends on

Not on how old the season is, as it turned out. Seasons 12 and 13 gave up
barely a third of each page; season 17 gave up two in three. The difference
is how much of a given episode was built on that week's news.

| Batch | Pages | Kept | Roughly |
|---|---|---|---|
| banks 1–3 | 25 | 198 | half |
| banks 4–5 | 25 | 205 | a third |
| bank 6 | 25 | 321 | two thirds |
| bank 7 | 25 | 344 | two thirds |

## Checks every batch passes

* four options, all distinct, and the answer index in range
* difficulty 1 to 3, topic one of the eight the game knows
* answer positions cycling 0, 1, 2, 3 so the right answer is not always in
  the same place
* no duplicate of anything in any other bank, on a normalised form that
  keeps signs and exponents distinct — an earlier normaliser collapsed
  `x^2-6x+5` and `x^2+6x+5` and wrongly flagged thirteen maths questions
* no option that argues with its own question ("it depends on the radius")

## Errors found in the source

The archive is transcribed by hand and gets things wrong. Twenty-odd errors
have been found so far: the largest planet given as Earth, Luna 2 credited
to the United States, a battle asked for as the last and answered with the
earliest, a sage misnamed, a tigress "known as Avni" answered Avni, an inch
given in millilitres. Where the fact is worth having and only the wording
broke, the question is kept and put right. Where the answer is wrong, it is
dropped. Where the fetch itself flagged a doubt, it is dropped rather than
checked and kept: the cost of checking is mine, the cost of being wrong is
his, and he will believe what the screen tells him.
