ARG FEDORA_MAJOR_VERSION=37

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION}

RUN rpm-ostree install gnome-tweaks gnome-consoleflatpak -h && \
    rpm-ostree override remove firefox firefox-langpacks gnome-terminal && \
    flatpak install -y --user \\
    org.mozilla.firefox \\
    rm -rf /usr/share/gnome-shell/extensions/background-logo@fedorahosted.org && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=check/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    rpm-ostree cleanup -m && \
    ostree container commit
