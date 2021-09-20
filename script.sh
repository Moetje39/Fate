#head
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install mysql-server
sudo apt-get install rpm
sudo apt-get install fail2ban

#body
echo "make a choise between 'apache '/'swag' or check the 'status' if its already installed "
  read title1
    if [ $title1 = 'apache' ]
   then
     sudo apt-get install apache2
     sudo systemctl status apache2
    elif [ $title1 = 'swag' ]
    then
      sudo apt install apt-transport-https ca-certificates
      curl gnupg-agent software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg
      sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
      sudo apt update
      apt-get install swag php mysql
      sudo apt-get install docker-ce docker-ce-cli containerd.io
      sudo chown christian:christian /opt/webserver_swag
      vim /opt/webserver_swag/docker-compose.yaml
    elif [ $title1 = 'status' ]     
      then
      sudo systemctl status apache2
      sudo systemctl status webserver_swag
    else
      echo "try again"
    fi

# nextcloud
echo "download nextcloud"  "Do you want to configure (Y/N)"
read keuze
  if [ $keuze = 'Y' ]
                          then
            wget -P /var/www/nextcloud https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip
            unzip ja/var/www/nextcloud/nextcloud-21.0.2.zip
elif [ $keuze = 'N' ]
                          then
echo 'no nextcloud installed'
fi





#conf

  echo  "backing up/configration fail2ban(Y/N)"
  read keuze
  if [ $keuze = 'Y' ]
                          then
  echo  'backing up copy for .conf file'
  cd /etc/fail2ban
  sudo cp jail.conf jail.local
  sudo cp fail2ban.conf fail2ban.local
  sed -i "s/^bantime  = 600/bantime  = $1/" /etc/fail2ban/jail.local
  sed -i "s/^destemail = root@localhost/destemail = $2/" /etc/fail2ban/jail.local
  sed -i "s/^action = %(action_)s/action = %(action_mwl)s/" /etc/fail2ban/jail.local


else if [ $keuze = 'N' ]
                        then
echo "no configration"
fi
