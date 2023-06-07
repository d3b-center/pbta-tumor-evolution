FROM rocker/tidyverse:4.2
MAINTAINER chronia@chop.edu
WORKDIR /rocker-build/

RUN RSPM="https://packagemanager.rstudio.com/cran/2022-10-07" \
  && echo "options(repos = c(CRAN='$RSPM'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
  
COPY scripts/install_bioc.r .

COPY scripts/install_github.r .

### Install apt-getable packages to start
#########################################
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils dialog

# Add curl, bzip2 and some dev libs
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    curl \
    bzip2 \
    zlib1g \
    libbz2-dev \
    liblzma-dev \
    libreadline-dev

# libmagick++-dev is needed for coloblindr to install
RUN apt-get -y --no-install-recommends install \
    libgdal-dev \
    libudunits2-dev \
    libmagick++-dev

# Required for installing pdftools, which is a dependency of gridGraphics
RUN apt-get -y --no-install-recommends install \
    libpoppler-cpp-dev

# Install java
RUN apt-get update && apt-get -y --no-install-recommends install \
   default-jdk \
   libxt6
   
# cmakeis needed for ggpubr to install
RUN apt-get -y --no-install-recommends install \
    cmake

# install R packages from CRAN
RUN install2.r \
	BiocManager \
  cDriver \
  clonevol \
  data.table \
  devtools \
  fishplot \
  flextable \
  ggpubr \
  ggthemes \
  immunedeconv \
  msigdbr \
	optparse \
	pheatmap \
  plyr \
  purrr \
	RColorBrewer \
  rlist \
	survival \
  survMisc \
  survminer \
  tidytext \
  vroom

# install R packages from Bioconductor 
RUN ./install_bioc.r \
  ComplexHeatmap \
  GSVA 

# install R packages from GitHub

# Maftools
RUN ./install_github.r \
	PoisonAlien/maftools

RUN ./install_github.r \
	clauswilke/colorblindr

# Install pip3 and low-level python installation reqs
RUN apt-get update
RUN apt-get -y --no-install-recommends install \
    python3-pip  python3-dev
RUN ln -s /usr/bin/python3 /usr/bin/python    
RUN pip3 install \
    "SciPy" \
    "NumPy" \
    "Biopython"


WORKDIR /rocker-build/

ADD Dockerfile .
