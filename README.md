# Living Lines
Drawing Software Made in processing with interactive animations of the drawn lines.

INTERACTIVE VISUAL SOFTWARE BY SEBASTIAN GONZALEZ DIXON,
COMMISSIONED BY EVA VON SCHWEINITZ
FOR HER WORK "THE SPACE BETWEEN THE LETTERS".
CODE PRODUCED WITH THE HELP OF HARVESTWORKS RESIDENCE.
OPENSOURCE UNDER MIT LICENSE.
NEW YORK, 2018


Key Commands
------------

GLOBAL KEYS


'=' to toggle between Performance mode and Explorer mode

'LEFT ARROW' and 'RIGHT ARROW' to cycle around layers or characters

'[' and ']' (square brackets) to cycle through colors.

'x' is to erase selected line.

'X' to erase all.

'z' to move all the layers away except from the active layer.

'h' to hold and move the active layer.

'b' is to change background color.

'v' is to turn on and of the GUI.

'V' is to show Explorer GUI.


IN EXPLORER MODE KEYS

Number keys: 1, 2, 3, 4, 5, 6, 7, 8, 9 and 0 are user to select lines.

Keys in the right side of the Keyboard are for Behaviors

'q' is to Quiet line. 'Q' Quiet All
'r' is to Restore to its original place the line. 'R' Restore All
'w', 'e', 'a' and 's' are 4 different behaviors. Capital letter apply to All

Keys in the Left side of the Keyboard are for rendering Modes

'l' is for simple Line rendering.
'p' is in Particles rendering.
'o' is for big circles rendering
'k' is for King Worm rendering
'm' is for Mega Lines rendering
'n' is for Typography rendering

Capital letters to apply All the lines the same rendering mode.


IN PERFORMANCE MODE

'a', 's', 'd', 'f', and 'j' to select between 5 different scene banks.
Number keys: 1, 2, 3, 4, 5, 6, 7, 8, 9 and 0 are user to select a charecter of the selected bank.




Character Protocole
-------------------

In Explorer mode you can find in the GUI a 4 values code on the top-left corner. This code is the current character you have created. You can set up you performance Characters using this codes in the charactersScene banks that are availables inside the code.

search for this lines at the code

String[] charactersScene1 = {"1wp2", "1ep5", "1el3", "0ql2", "1qk1", "1wo1", "5qp5", "9ep9", "4ql4", "3ql3"};  ////  a
String[] charactersScene2 = {"3lq3", "7qm7", "8ql8", "7ql7", "6ql6", "2pw2", "3pw3", "4pw4", "2el2", "2pw2"};  ////  s
String[] charactersScene3 = {"1el1", "0ql0", "1ak1", "1eo1", "1wp1", "1ep1", "5qp5", "6am6", "6ql6", "3ql3"};  ////  d
String[] charactersScene4 = {"0ql0", "1ak1", "1eo1", "1wp1", "1ep1", "1el1", "5qp5", "6am6", "6ql6", "4ql4"};  ////  f
String[] charactersScene5 = {"2ql2", "3ql3", "4ql4", "5ql5", "6ql6", "2pw2", "3pw3", "4pw4", "5pw5", "6pw6"};  ////  j

The Character protocole consist in 4 values with as in "1wp2" or "6pw6", that you can change with the following rules:

First value selects the line layer (0 to 9). Each layer has a different size for different visual results.
Second value selects the behavios of the line ('q', 'w', 'e', 'r', 'a', 's')
Third value selects the rendeling mode of the line ('o', 'p', 'k', 'l', 'n', 'm')
Fourth value selects the color (0 to 9). You can see the 10 colors in the GUI at Explorer mode.













