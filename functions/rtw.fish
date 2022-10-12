# Defined in - @ line 1
function rtw --wraps='efibootmgr -n 0 && shutdown -r now' --wraps='sudo efibootmgr -n 0 && shutdown -r now' --description 'alias rtw sudo efibootmgr -n 0 && shutdown -r now'
  sudo efibootmgr -n 0 && shutdown -r now $argv;
end
