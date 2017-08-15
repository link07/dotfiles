1) Enable chromium hardware accel
    * chrome://flags/#ignore-gpu-blacklist -> enable
    * chrome://flags/#enable-gpu-rasterization -> enable (this might break some websites fonts)
    * chrome://flags/#enable-zero-copy -> enable
2) dconf-editor fixes ```pacman -S dconf-editor```
    * model windows ```dconf write /org/gnome/shell/overrides/attach-modal-dialogs false```
    * Change nightlight colors ```dconf write /org/gnome/settings-daemon/plugins/color/night-light-temperature 3500```
        * if nightlight isn't working, use ```redshift```
            * ```systemctl --user enable redshift-gtk```
3) install printers
    * install ```cups gtk3-print-backends cups-pdf```
    * enable / start the service ```systemctl enable org.cups.cupsd.service``` ```systemctl start org.cups.cupsd.service```