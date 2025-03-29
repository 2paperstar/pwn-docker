FROM ubuntu:24.04

LABEL org.opencontainers.image.authors="lee@paperst.ar"

RUN dpkg --add-architecture i386 && \
  apt-get update -qq 

RUN apt-get install -y -qq \
  wget git make zsh curl gcc gdb \
  # pyenv dependencies
  build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

RUN curl -fsSL https://github.com/asdf-vm/asdf/releases/download/v0.16.7/asdf-v0.16.7-linux-amd64.tar.gz | tar -xzv -C /usr/local/bin && \
  mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions" && \
  asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

RUN  asdf plugin add python && \
  asdf install python 3.13.2 && \
  asdf set -u python 3.13.2 && \
  $(asdf which python3) -m pip install pwntools

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions && \
  curl -fsSL https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-linux_amd64.tar.gz | tar -xzv -C /usr/local/bin && \
  apt install -y -qq autojump

RUN git clone https://github.com/hugsy/gef.git /root/gef && \
  git clone https://github.com/scwuaptx/Pwngdb.git /root/Pwngdb

ADD common/.zshrc /root/.zshrc
ADD common/.p10k.zsh /root/.p10k.zsh
ADD common/.gdbinit /root/.gdbinit
RUN /bin/zsh -c "source <(fzf --zsh)"
RUN ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k/gitstatus/install
