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
  ggplot2 \ 
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
	PoisonAlien/maftools 
  
# Simulate colorblindness in production-ready R figures
RUN ./install_github.r \
	clauswilke/colorblindr

# to calculate CCF and infer driver genes
RUN ./install_github.r  'hanasusak/cDriver' --ref 'aa466ae92095f877a1f68ee7d2e6136cba9b02ea'

# FISHPLOT
RUN ./install_github.r  'chrisamiller/fishplot' --ref '7b7477aa21c4eb62b0defd00c61cf2349dbc1fcf'


# Inferring and visualizing clonal evolution in multi-sample cancer sequencing.
RUN ./install_github.r  'hdng/clonevol' --ref '7aff737aedde157de4e7374cedf9a873e80c8046'

# part of hdng/clonevol installation
RUN ./install_github.r \
	 hdng/trees

# package required for immune deconvolution
RUN R -e "remotes::install_github('omnideconv/immunedeconv', ref = '0c5c61978029c069eb1ab7487aaeb8b721810401', dependencies = TRUE)"


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
