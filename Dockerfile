FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386 
RUN apt-get update -y
RUN apt-get install -y libc6:i386 libncurses5:i386 libstdc++6:i386 wget bzip2 \
    libgtk-3-0:i386 \
    libasound2:i386 \
    libdbus-glib-1-2:i386 \
    libxt6:i386 \
    libxtst6:i386 \
    libcanberra-gtk-module:i386 \
    libcanberra-gtk3-module:i386 \
    topmenu-gtk3:i386 \
    libpangoxft-1.0-0:i386 \
    libxft2:i386 \
    libpangox-1.0-0:i386 \
    libxmu6:i386 \
    libxv1:i386 \
    libasound2-plugins:i386 \ 
    pulseaudio
RUN wget https://ftp.mozilla.org/pub/firefox/releases/50.0/linux-i686/en-US/firefox-50.0.tar.bz2
RUN mkdir -p /opt/webex/
ADD jre-linux-i586.tar.gz /
RUN mv /jre* /opt/webex/jre
RUN tar -xjvf /firefox*.bz2 -C /opt/webex/
RUN mkdir /opt/webex/firefox/plugins/
RUN ln -s \
    /opt/webex/jre/lib/i386/libawt.so \
    /opt/webex/jre/lib/i386/libjawt.so \
    /opt/webex/jre/lib/i386/libnpjp2.so \
    /opt/webex/firefox/plugins
ADD firefox.sh /opt/webex/firefox.sh
RUN chmod a+x /opt/webex/firefox.sh
RUN apt-get install -y libcurl3:i386
RUN ln -s /opt/webex/firefox.sh /usr/local/bin/firefox-i386
RUN apt-get install -y alsamixergui
RUN useradd -ms /bin/bash webex
USER webex
WORKDIR /home/webex

CMD ["/usr/local/bin/firefox-i386", "https://meetings.webex.com/"]
