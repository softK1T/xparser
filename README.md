Ruby (Curb + Nokogiri) web scraper

# Getting started

## Install curb and nokogiri gems
##### Ubuntu 18.04+ 
- `gem install curb` 
- `sudo apt-get install libcurl4 libcurl3-gnutls libcurl4-openssl-dev`
- `gem install nokogiri`


##### Others
<p>https://github.com/taf2/curb<p>
<p>https://nokogiri.org/tutorials/installing_nokogiri.html#supported-platforms</p>

## Run

`ruby main.rb config.yaml url output.csv`

 * config.yaml - config file, which contains pathes to the main elements 
 * url - link to the online shop category page
 * output.csv - name of the .csv file which you'd like to save information in
