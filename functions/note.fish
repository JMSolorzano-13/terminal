function note
  powershell.exe -noprofile Get-Clipboard | python3 create_note_text.py
end
