mkdir -p ~/git
git clone https://github.com/gh0st-8221/gentoo-dotfiles.git ~/git/ghostwm-dotfiles
git clone https://github.com/gh0st-8221/ghostwm ~/git/ghostwm
git clone https://github.com/kalole/xdg-desktop-portal-termfilechooser.git ~/git/xdg-desktop-portal-termfilechooser-git
sudo emerge  dev-libs/libdisplay-info dev-libs/libinput sys-auth/seatd media-libs/mesa x11-libs/libxkbcommon

cd ~/git/~/git/xdg-desktop-portal-termfilechooser-git
makepkg -si
cd ~/git/
make
if [ -d ~/git/ghostwm-dotfiles/usr/share/grub/themes/catppuccin-mocha-grub-theme ]; then
    [ -d /usr/share/grub/themes/catppuccin-mocha-grub-theme ] && sudo cp -r /usr/share/grub/themes/catppuccin-mocha-grub-theme /usr/share/grub/themes/catppuccin-mocha-grub-theme.bak
    sudo cp -r ~/git/ghostwm-dotfiles/usr/share/grub/themes/catppuccin-mocha-grub-theme /usr/share/grub/themes/
fi

if [ -f ~/git/ghostwm-dotfiles/etc/default/grub ]; then
    [ -f /etc/default/grub ] && sudo cp /etc/default/grub /etc/default/grub.bak
    sudo cp ~/git/ghostwm-dotfiles/etc/default/grub /etc/default/grub
fi

sudo grub-mkconfig -o /boot/grub/grub.cfg

mkdir -p ~/.config
[ -f ~/.config/xdg-desktop-portal-termfilechooser/config ] && cp ~/.config/xdg-desktop-portal-termfilechooser/config ~/.config/xdg-desktop-portal-termfilechooser/config.bak
[ -f ~/.config/yazi/yazi-wrapper.sh ] && cp ~/.config/yazi/yazi-wrapper.sh ~/.config/yazi/yazi-wrapper.sh.bak
cp -r ~/git/ghostwm-dotfiles/.config/. ~/.config/
chmod +x ~/.config/yazi/yazi-wrapper.sh
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak
cp ~/git/ghostwm-dotfiles/.zshrc ~/.zshrc
[ -f ~/.zprofile ] && cp ~/.zprofile ~/.zprofile.bak
cp ~/git/ghostwm-dotfiles/.zprofile ~/.zprofile
if [ -f ~/git/ghostwm-dotfiles/.xinitrc ]; then
    [ -f ~/.xinitrc ] && cp ~/.xinitrc ~/.xinitrc.bak
    cp ~/git/ghostwm-dotfiles/.xinitrc ~/.xinitrc
fi

chsh -s $(which zsh) $USER
sudo chsh -s $(which zsh) root

if [ -d ~/.zsh/plugins/zsh-autosuggestions ]; then
    cp -r ~/.zsh/plugins/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions.bak
    rm -rf ~/.zsh/plugins/zsh-autosuggestions
fi
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions

if [ -d ~/.zsh/plugins/zsh-syntax-highlighting ]; then
    cp -r ~/.zsh/plugins/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting.bak
    rm -rf ~/.zsh/plugins/zsh-syntax-highlighting
fi
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting

systemctl --user enable --now pipewire.service
systemctl --user enable --now pipewire-pulse.service
systemctl --user enable --now wireplumber.service