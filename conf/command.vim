" ===== Sudo action =====
command! WriteAsRoot :w !sudo tee > /dev/null %
