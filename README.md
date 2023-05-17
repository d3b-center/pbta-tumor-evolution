# Tumor evolution across multiple time points in OpenPBTA patients


## To reproduce the code in this repository:
This repository contains a docker image and code used to conduct analyses for the manuscript noted above.

1. Clone the repository
```
git clone https://github.com/d3b-center/pbta-tumor-evolution.git
```

2. Pull the docker container:
```
docker pull pgc-images.sbgenomics.com/antoniachroni/pbta-tumor-evolution:latest
```

3. Start the docker container, from the `pbta-tumor-evolution` folder, run:
```
docker run --platform=linux/amd64 --name test -d -e PASSWORD=ANYTHING -p 8787:8787 -v $PWD:/home/rstudio/pbta-tumor-evolution pgc-images.sbgenomics.com/antoniachroni/pbta-tumor-evolution:latest
```

4. To execute shell within the docker image, from the `pbta-tumor-evolution` folder, run:
```
docker exec -ti <CONTAINER_NAME> bash
```


### Below is the main directory structure listing the analyses and data files used in this repository

```
.
├── Dockerfile
├── README.md
└── scripts
    ├── install_bioc.r
    └── install_github.r
```


## Code Authors

Jo Lynne Rokita ([@jharenza](https://github.com/jharenza)) and Antonia Chroni ([@AntoniaChroni](https://github.com/AntoniaChroni))

## Contact

For questions, please submit an issue or send an email to Jo Lynne Rokita: rokita@chop.edu
