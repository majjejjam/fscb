ARG FEDORA_MAJOR_VERSION=38

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION}

COPY etc /etc

RUN rpm-ostree override remove firefox firefox-langpacks gnome-terminal gnome-terminal-nautilus && \
    rpm-ostree install gnome-tweaks gnome-console && \
    flatpak install -y --user \
    org.mozilla.firefox \
    org.gnome.Loupe \
    com.mattjakeman.ExtensionManager \
    com.github.tchx84.Flatseal \
    io.bassi.Amberol \
    app.drey.EarTag \
    de.haeckerfelix.Fragments \
    com.usebottles.bottles \
    org.gnome.Solanum \
    me.dusansimic.DynamicWallpaper \
    io.gitlab.theevilskeleton.Upscaler \
    io.github.realmazharhussain.GdmSettings \
    io.github.lainsce.Colorway \
    io.github.fabrialberio.pinapp \
    dev.geopjr.Tuba \
    dev.geopjr.Collision \
    com.spotify.Client \
    com.github.rafostar.Clapper \
    com.github.huluti.Curtail \
    com.github.hugolabe.Wike \
    com.github.flxzt.rnote \
    com.github.finefindus.eyedropper && \
    rm -rf /usr/share/gnome-shell/extensions/background-logo@fedorahosted.org && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=check/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    rpm-ostree cleanup -m && \
    ostree container commit
