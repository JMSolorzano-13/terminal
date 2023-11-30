# This script python generate text from the last clipboard text
# Run with the command line:
# powershell.exe -noprofile Get-Clipboard | python3 create_note_text.py

import sys
from datetime import datetime

# Take the clipboard content from the command line
clipboard_content = sys.stdin.read()

# Create a filename with the current date and time
filename = f"/mnt/c/Users/juans/OneDrive/Desktop/Notes/note-{datetime.now().strftime('%Y-%m-%d_%H-%M-%S')}.txt"

# Write the clipboard content to the file
with open(filename, 'w') as file:
    file.write(clipboard_content)
  
