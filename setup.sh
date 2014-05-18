#!/bin/sh
set -e

if [ -e /.installed ]; then
  echo 'Already installed.'

else
  echo ''
  echo 'INSTALLING'
  echo '----------'

  # Add Google public key to apt
  wget -q -O - "https://dl-ssl.google.com/linux/linux_signing_key.pub" | sudo apt-key add -

  # Add Google to the apt-get source list
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list

  # Update app-get
  apt-get update

  # Install Java, Chrome, Firefox, Xvfb, and unzip
  apt-get -y install openjdk-7-jre google-chrome-stable firefox xvfb unzip

  # Download and copy the ChromeDriver to /usr/local/bin
  cd /tmp
  wget "https://chromedriver.googlecode.com/files/chromedriver_linux64_2.2.zip"
  wget "http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar"
  unzip chromedriver_linux64_2.2.zip
  mv chromedriver /usr/local/bin
  mv selenium-server-standalone-2.41.0.jar /usr/local/bin

  # So that running `vagrant provision` doesn't redownload everything
  touch /.installed
fi

# Start Xvfb, Chrome, and Selenium in the background
export DISPLAY=:10
cd /vagrant

echo "Starting Xvfb ..."
Xvfb :10 -screen 0 1366x768x24 -ac &

echo "Starting Google Chrome ..."
google-chrome --remote-debugging-port=9222 &

echo "Starting Selenium ..."
cd /usr/local/bin
nohup java -jar ./selenium-server-standalone-2.41.0.jar -role node -hub http://192.168.184.126:4444/grid/register -browser browserName=chrome,platform=LINUX,maxInstances=10 -browser browserName=firefox,platform=LINUX,maxInstances=10 -maxSession=10 &
