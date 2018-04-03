# Install R
sudo apt-get update
wget http://de.archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1_amd64.deb
sudo dpkg -i libpng12-0_1.2.54-1ubuntu1_amd64.deb

sudo apt-get install gdebi libxml2-dev libssl-dev libcurl4-openssl-dev libopenblas-dev r-base r-base-dev

# Install RStudio
cd ~/Downloads
wget https://download1.rstudio.org/rstudio-xenial-1.1.383-amd64.deb
sudo gdebi rstudio-xenial-1.1.383-amd64.deb
printf '\nexport QT_STYLE_OVERRIDE=gtk\n' | sudo tee -a ~/.profile

sudo apt-get install python-pip
sudo pip install markdown rpy2==2.7.8 pelican==3.6.3

# install packages
R --vanilla << EOF
install.packages(c("tidyverse","data.table","dtplyr","devtools","roxygen2","bit64"), repos = "https://cran.rstudio.com/")
library(devtools)
install.packages(c("htmlTable","openxlsx"), repos = "https://cran.rstudio.com/")
install.packages(c("knitr","rmarkdown"), repos='http://cran.us.r-project.org')
install.packages("pdftools", repos = "https://cran.rstudio.com/")
install_github("ropensci/tabulizer")
install.packages("showtext", repos = "https://cran.rstudio.com/")
install.packages("Cairo", repos = "https://cran.rstudio.com/")
q()
EOF
