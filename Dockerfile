FROM rocker/tidyverse:4.2.3
MAINTAINER chronia@chop.edu
WORKDIR /rocker-build/

RUN RSPM="https://packagemanager.rstudio.com/cran/2023-02-10" \
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

   
# cmakeis needed for ggpubr to install
RUN apt-get -y --no-install-recommends install \
    cmake

# install R packages from CRAN
RUN install2.r \
	BiocManager \
  data.table \
  devtools \
  fishplot \
  flextable \
  future \
  ggplot2\ 
  ggpubr \
  ggthemes \
  gridBase \
  gridExtra \
  igraph \
	optparse \
  packcircles \
	pheatmap \
  plyr \
  purrr \
	RColorBrewer \
  R.utils \
  rlist \
  tidytext \
  tidyverse \
  vroom


# install R packages from Bioconductor 
RUN ./install_bioc.r \
  ComplexHeatmap

# install R packages from GitHub

# Maftools
RUN ./install_github.r \
  cDriver \
	PoisonAlien/maftools

# package required for immune deconvolution
RUN R -e "remotes::install_github('omnideconv/immunedeconv', ref = '0c5c61978029c069eb1ab7487aaeb8b721810401', dependencies = TRUE)"

RUN ./install_github.r \
  chrisamiller/fishplot \
	clauswilke/colorblindr \
  hdng/clonevol \
  hdng/trees

# Install pip3 and low-level python installation reqs
RUN apt-get update
RUN apt-get -y --no-install-recommends install \
    python3-pip  python3-dev
RUN ln -s /usr/bin/python3 /usr/bin/python    
RUN pip3 install \
    "SciPy==1.10.1" \
    "NumPy==1.24.3" \
    "Biopython==1.81"


WORKDIR /rocker-build/

ADD Dockerfile .
