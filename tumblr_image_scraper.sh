#!/bin/bash

# Scraped a list of URLs from a website with grep / regex
url_list='https://md.greysdawn.com/api/page/kxzh'
# change this to page of tumblr user
tumblr_user='prismarine-blocks'
# swap out prismarine-blocks for desired URL
# this specific user had a bunch of rotating minecraft block gifs I wanted
urls=$(curl -s $url_list | grep -o -P -i "https://${tumblr_user}\.tumblr\.com/post/[A-Za-z0-9]+/([a-zA-Z]+(-[a-zA-Z]+)+)")

#loop thru urls and use regex again to identify the external image hosting provider URL
for url in $urls;
do
  echo "Downloading $url...."
  gifs=$(curl -s $url | grep -P -i -o 'https://64\.media\.tumblr\.com/(.*?)\.gifv' | tail -1)
  echo $gifs
  #aria2c ${gifs:0} #getting index :0 just in case there's accidentally multiple 
  wget -r -A .gifv ${gifs:0} #this can be done with wget or anything downloading tool
done

