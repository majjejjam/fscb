ARG FEDORA_MAJOR_VERSION=38

FROM quay.io/fedora-ostree-desktops/silverblue:${FEDORA_MAJOR_VERSION}

COPY etc /etc
COPY usr /usr

RUN rpm-ostree override remove firefox firefox-langpacks gnome-terminal gnome-terminal-nautilus && \
    rpm-ostree install gnome-tweaks gnome-console && \
    rm -rf /usr/share/gnome-shell/extensions/background-logo@fedorahosted.org && \
    sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=check/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    rpm-ostree cleanup -m && \
    ostree container commit
