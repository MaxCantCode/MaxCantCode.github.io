FROM archlinux:base-devel

RUN pacman -Syuq --needed --noprogressbar --noconfirm \
base-devel git

RUN useradd -ms /bin/zsh mechs && \
echo "ALL ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/mechs
USER mechs
RUN git clone https://aur.archlinux.org/paru.git && \
cd paru && makepkg -si --needed --noprogressbar --noconfirm

RUN paru -Syuq --needed --removemake --noprogressbar --noconfirm \
vis zsh zsh-syntax-highlighting julia && \
paru -Sccq --noconfirm

RUN julia -qe 'import Pkg; Pkg.add("IJulia")'

COPY .zshrc entrypoint.sh .
# COPY --chown=mechs .zshrc .

ENV PATH="/home/mechs/.julia/conda/3/bin:$PATH"
RUN julia -qe 'using IJulia; jupyterlab()'

RUN conda install -yqc conda-forge \
    'jupyterlab-lsp' \
    'jupyterlab_code_formatter' \
    'black' \
    'isort' \
    'pandas' \
    'jupytext' && \
    conda update --all --quiet --yes && \
    conda clean --all -f -y

RUN pip install -U git+https://github.com/krassowski/python-language-server.git@main \
		   # 'python-language-server[all]'
		   git+https://github.com/ekaschalk/jedhy.git \
		   git+https://github.com/Calysto/calysto_hy.git && \
		   python3 -m calysto_hy install --user

# run jupyter lab on localhost:8888 by default
CMD jupyter lab --ip 0.0.0.0

