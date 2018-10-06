### originally from oh-my-zsh at https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/archlinux/archlinux.plugin.zsh
## Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
if type pacman &>/dev/null ; then
    alias pacupg='sudo pacman -Syu'
    alias pacin='sudo pacman -S'
    alias pacins='sudo pacman -U'
    alias pacre='sudo pacman -R'
    alias pacrem='sudo pacman -Rns'
    alias pacrep='pacman -Si'
    alias pacreps='pacman -Ss'
    alias pacloc='pacman -Qi'
    alias paclocs='pacman -Qs'
    alias pacinsd='sudo pacman -S --asdeps'
    alias pacmir='sudo pacman -Syy'
    alias paclsorphans='sudo pacman -Qdt'
    function pacrmorphans()
    {
        packages="$(pacman -Qdtq)"
        if [ -z "$packages" ]; then
            echo "No packages to remove."
        else
            sudo pacman -Rnsc $packages
        fi
    }
    alias pacfileupg='sudo pacman -Fy'
    alias pacfiles='pacman tFs'

    function paclistsize()
    {
        expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqe | sort) <(pacman -Qqg base base-devel | sort)) | sort -n
    }

    paclist() {
        # Source: https://bbs.archlinux.org/viewtopic.php?id=93683
        LC_ALL=C pacman -Qei $(pacman -Qu | cut -d " " -f 1) | \
        awk 'BEGIN {FS=":"} /^Name/{printf("\033[1;36m%s\033[1;37m", $2)} /^Description/{print $2}'
    }
fi

## pacaur is unmaintaned, but yay is more or less a drop in replacement, so just alias pacaur to yay
# if pacaur is not installed, but yay is installed
! type pacaur &>/dev/null && type yay &>/dev/null && alias pacaur="yay"

## pacaur aliases, since pacaur is umaintaned, these should get removed at some point, but they're more ingrained in memory
if type pacaur &>/dev/null; then
    alias paupg='pacaur -Syu'
    alias pasu='pacaur -Syu --noconfirm'
    alias pain='pacaur -S'
    alias pains='pacaur -U'
    alias pare='pacaur -R'
    alias parem='pacaur -Rns'
    alias parep='pacaur -Si'
    alias pareps='pacaur -Ss'
    alias paloc='pacaur -Qi'
    alias palocs='pacaur -Qs'
    alias palst='pacaur -Qe'
    alias paorph='pacaur -Qtd'
    alias painsd='pacaur -S --asdeps'
    alias pamir='pacaur -Syy'
fi

## yay aliases
if type yay &>/dev/null; then
    # set up yay to only use the aur and to always show diffs
    alias yay='yay --aur --diffmenu --answerdiff All'

    alias yaupg='yay -Syu'
    alias yasu='yay -Syu --noconfirm'
    alias yain='yay -S'
    alias yains='yay -U'
    alias yare='yay -R'
    alias yarem='yay -Rns'
    alias yarep='yay -Si'
    alias yareps='yay -Ss'
    alias yaloc='yay -Qi'
    alias yalocs='yay -Qs'
    alias yalst='yay -Qe'
    alias yaorph='yay -Qtd'
    alias yainsd='yay -S --asdeps'
    alias yamir='yay -Syy'
fi
