term.setTextColor(colors.cyan)
--TELEPORTER STARTUP v1.0

shell.openTab("/teleporter/listener")
shell.openTab("/teleporter/teleporter")

term.clear()
term.setCursorPos(1, 2)
print("    |''||''| '||''''|  '||'      '||''''| \n       ||     ||  .     ||        ||  .   \n       ||     ||''|     ||        ||''|   \n       ||     ||        ||        ||      \n      .||.   .||.....| .||.....| .||.....|\n      \n      '||'''|, .|''''|, '||'''|, |''||''| \n       ||   || ||    ||  ||   ||    ||    \n       ||...|' ||    ||  ||...|'    ||    \n       ||      ||    ||  || \\\\      ||    \n      .||      `|....|' .||  \\\\.   .||.   ")
term.setTextColor(colors.gray)
term.setCursorPos(35, 17)
term.write("version 2.0")
term.setCursorPos(1, 18)