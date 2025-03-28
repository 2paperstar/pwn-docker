FROM ubuntu:24.04

LABEL org.opencontainers.image.authors="lee@paperst.ar"

RUN dpkg --add-architecture i386 && \
  apt-get update -qq 

RUN apt-get install -y -qq \
  wget git make zsh curl gcc gdb \
  python3 python3-pip

# install python dependencies

RUN python3 -m pip config set global.break-system-packages true && \
  python3 -m pip install pwntools

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

RUN git clone https://github.com/hugsy/gef.git /root/gef && \
  git clone https://github.com/scwuaptx/Pwngdb.git /root/Pwngdb

ADD common/.zshrc /root/.zshrc
ADD common/.p10k.zsh /root/.p10k.zsh
ADD common/.gdbinit /root/.gdbinit
RUN ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k/gitstatus/install
