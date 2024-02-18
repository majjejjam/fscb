ARG FEDORA_MAJOR_VERSION=39

FROM quay.io/fedora/fedora-silverblue:${FEDORA_MAJOR_VERSION}

COPY rootfs/ /

RUN rpm-ostree override remove firefox firefox-langpacks gnome-terminal gnome-terminal-nautilus && \
    rpm-ostree install gnome-tweaks && \
    systemctl enable dconf-update.service && \
    rm -rf /usr/share/gnome-shell/extensions/background-logo@fedorahosted.org && \
    systemctl enable flatpak-cleanup.timer && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=check/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    rpm-ostree cleanup -m && \
    ostree container commit
