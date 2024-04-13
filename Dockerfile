##################################################################################################################################################################
# Adapted from following:
# - Rocker RStudio containerusing base r-ver: https://github.com/rocker-org/rocker-versioned2/blob/master/dockerfiles/r-ver_4.2.1.Dockerfile
# - license: GPLV2
##################################################################################################################################################################

FROM rocker/r-ver:4.3.1

ENV S6_VERSION=v2.1.0.2
ENV RSTUDIO_VERSION=2023.12.1+402
ENV DEFAULT_USER=rstudio
ENV PANDOC_VERSION=default
ENV QUARTO_VERSION=default

## INSTALL KEY DEPENDENCIES FOR CERTAIN R PACKAGES
RUN apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends software-properties-common curl wget libssl-dev libxml2-dev libsodium-dev imagemagick libmagick++-dev libgit2-dev libssh2-1-dev zlib1g-dev librsvg2-dev libudunits2-dev libcurl4-openssl-dev pandoc libzip-dev libfreetype6-dev libfontconfig1-dev tk libpq5 libxt6 openssh-client openssh-server libglpk-dev iputils-ping cmake xz-utils \
    && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_quarto.sh

## SPECIFY REPO
RUN echo "options(repos = c(CRAN = 'https://cloud.r-project.org'))" >>"${R_HOME}/etc/Rprofile.site"

## INSTALL R PACKAGES
COPY ./requirements.R /requirements.R
RUN Rscript /requirements.R

## COPY RSTUDIO PREFERENCES
COPY ./rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json

EXPOSE 8787

CMD ["/init"]
