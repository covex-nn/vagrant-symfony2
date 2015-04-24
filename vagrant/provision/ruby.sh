# @see http://wiki.brightbox.co.uk/docs:ruby-ng
echo -e "\nInstall Ruby packages..."
apt-add-repository ppa:brightbox/ruby-ng
apt-get update
apt-get install ruby rubygems ruby-bundler ruby-switch ruby1.9.3 --assume-yes
ruby-switch --set ruby1.9.1
