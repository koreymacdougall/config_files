'''
Simple Script to remove duplicate entries from .zsh_history.
Shell histories are a form of extended memory; don't want them
cluttered with duplicates.
'''

from pathlib import Path        # for getting homedir
from shutil import copyfile     # for making a backup of hist file

home = str(Path.home())
history_file = home + '/.zsh_history'
history_file_bk = home + '/.zsh_history_bk'

# store processed lines, later write to disk
cleaned_lines = []

# make a backup of the file first
print(f'Backing up {history_file} to {history_file_bk}')
copyfile(history_file, history_file_bk, follow_symlinks=True)

# open history in read mode to parse
with open(history_file, 'r', encoding = "ISO-8859-1") as f:

    lines = f.readlines()
    print( f'Initial line count: {len(lines)}' )

    for line in lines:
        if line not in cleaned_lines:
            cleaned_lines.append(line)

# opening file a second time in 'w' mode
# not optimal, but semantically cleaner?
with open(history_file, 'w', encoding = 'ISO-8859-1') as f2:
    f2.writelines(cleaned_lines)
    print( f'New line count: {len(cleaned_lines)}' )
