    #!/bin/bash
    sudo apt update
    sudo apt install nginx -y
    sudo apt install git -y
    sudo git clone https://github.com/bhange-saheb/Static-website-test.git
    sudo rm -rf /var/www/html/index.nginx-debian.html
    sudo cp  Static-website-test/index.html /var/www/html/index.html
    #echo "<h1>FrontEnd-Server-${count.index + 1}My AZ-${element(var.Az_Subnet, count.index)}</h1>" >> /var/www/html/index.html
    sudo systemctl start nginx
    sudo systemctl enable nginx
    # Jdjjdjd]
    # dkjdjkdjd
    # dkdfkkd