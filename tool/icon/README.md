# App icon

`PUZZLES / for / NCJ` over a brain, replacing the upstream `P`.

The four SVGs here are the masters. The PNGs under
`android/app/src/main/res/mipmap-*/` are exported from them:

| master | exported to | sizes (px) |
|---|---|---|
| `background.svg` | `ic_launcher_background.png` | 108, 162, 216, 324, 432 |
| `foreground.svg` | `ic_launcher_foreground.png` | 108, 162, 216, 324, 432 |
| `monochrome.svg` | `ic_launcher_monochrome.png` | 108, 162, 216, 324, 432 |
| `legacy.svg`     | `ic_launcher.png`            | 48, 72, 96, 144, 192 |

in the density order mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi. To change the icon,
edit the SVG and re-export at those sizes; any renderer will do, and the font
paths here are relative so the files open as they are.

Two things to keep if you edit them.

**The safe zone.** An adaptive icon is a 108dp canvas, but every launcher
masks it to its own shape, and only the centre 66dp is guaranteed to survive.
On this 432px canvas that is a circle of radius 132 about (216, 216). All
three lines of lettering sit inside it, the widest corner at 129 of the 132.
Anything that strays outside can be cut off on somebody's phone.

**The lobe paths are open on purpose.** Closing them with `Z` draws a straight
line back up the midline, which lands as a bright bar through the middle of
the word PUZZLES. The hemispheres are stroked rather than filled, so leaving
them open costs nothing and the two halves still read as one brain where they
meet.
