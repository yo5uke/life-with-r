FROM rocker/verse:4.4.3

# R packages
RUN R -e "install.packages(c('renv', 'pak'))"

# Quarto
ENV QUARTO_MINOR_VERSION=1.7
ENV QUARTO_PATCH_VERSION=15

RUN wget "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_MINOR_VERSION}.${QUARTO_PATCH_VERSION}/quarto-${QUARTO_MINOR_VERSION}.${QUARTO_PATCH_VERSION}-linux-amd64.deb" -O quarto.deb && \
    dpkg -i quarto.deb && \
    rm quarto.deb

# RStudio and VSCode settings
COPY --chown=rstudio:rstudio /.rstudio/rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
COPY --chown=rstudio:rstudio /.rstudio/rsession.conf /etc/rstudio/rsession.conf
COPY --chown=rstudio:rstudio /.vscode/_settings.json /home/rstudio/.vscode-server/data/Machine/settings.json

RUN cd /home/rstudio && mkdir .cache && \
    chown -R rstudio:rstudio .cache