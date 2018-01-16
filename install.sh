#!/bin/sh

# RRRRRRRRRRRRRRR     EEEEEEEEEEEEEEEEEEEE VVVVVVV             VVVVVVV IIIIIIIIII RRRRRRRRRRRRRRR     YYYYYYY         YYYYYYY
# R::::::::::::::R    E::::::::::::::::::E  V:::::V           V:::::V  I::::::::I R::::::::::::::R     Y::::Y         Y::::Y 
# R:::::RRRRRR:::::R  EE:::::EEEEEEEEE:::E   V:::::V         V:::::V   II::::::II R:::::RRRRRR:::::R    Y::::Y       Y::::Y  
# RR::::R      R::::R   E::::E       EEEEE    V:::::V       V:::::V      I::::I   RR::::R      R::::R    Y::::Y     Y::::Y   
#   R:::R      R::::R   E::::E                 V:::::V     V:::::V       I::::I     R:::R      R::::R     Y::::Y   Y::::Y    
#   R:::RRRRRR:::::R    E:::::EEEEEEEEEE        V:::::V   V:::::V        I::::I     R:::RRRRRR:::::R       Y::::Y Y::::Y     
#   R:::::::::::RR      E::::::::::::::E         V:::::V V:::::V         I::::I     R:::::::::::RR          Y::::Y::::Y      
#   R:::RRRRRR::::R     E:::::EEEEEEEEEE          V:::::V:::: V          I::::I     R:::RRRRRR::::R          Y:::::::Y       
#   R:::R      R::::R   E::::E                     V:::::::::V           I::::I     R:::R      R::::R         Y:::::Y        
#   R:::R      R::::R   E::::E       EEEEE          V:::::::V            I::::I     R:::R      R::::R         Y:::::Y        
#   R:::R      R::::R EE:::::EEEEEEEE::::E           V:::::V           II::::::II   R:::R      R::::R         Y:::::Y        
# RR::::R      R::::R E::::::::::::::::::E            V:::V            I::::::::I RR::::R      R::::R         Y:::::Y        
# RRRRRRR      RRRRRR EEEEEEEEEEEEEEEEEEEE             VVV             IIIIIIIIII RRRRRRR      RRRRRR         YYYYYYY        

ln -sf $PWD/.zshrc ~/.zshrc
ln -sf $PWD/.vimrc ~/.vimrc
ln -sf $PWD/.gvimrc ~/.gvimrc
ln -sf $PWD/.ideavimrc ~/.ideavimrc
ln -sf $PWD/.xvimrc ~/.xvimrc
ln -sf $PWD/.tmux.conf ~/.tmux.conf
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/vim/dein.toml ~/.vim/rc/dein.toml
ln -sf $PWD/vim/deinlazy.toml ~/.vim/rc/deinlazy.toml

sudo ln -sf $PWD/bin/wifi /usr/local/bin/wifi && sudo chmod +x /usr/local/bin/wifi
sudo ln -sf $PWD/bin/battery /usr/local/bin/battery && sudo chmod +x /usr/local/bin/battery
