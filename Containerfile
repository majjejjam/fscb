ARG FEDORA_MAJOR_VERSION=39

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION}

COPY etc /etc

RUN rpm-ostree override remove firefox firefox-langpacks gnome-terminal gnome-terminal-nautilus && \
    rpm-ostree install gnome-tweaks && \
    rm -rf /usr/share/gnome-shell/extensions/background-logo@fedorahosted.org && \
    systemctl enable flatpak-cleanup.timer && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=check/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    rpm-ostree cleanup -m && \
    ostree container commit
