# @see http://wiki.brightbox.co.uk/docs:ruby-ng
echo -e "\nInstall Ruby packages..."
apt-add-repository ppa:brightbox/ruby-ng
apt-get update
apt-get install ruby1.9.3 --assume-yes
gem install bundler
