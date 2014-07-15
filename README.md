= docker-breach

Dockerfile for Breach with sshd-X11-forward

= Build

    git clone https://github.com/matsuu/docker-breach.git
    cd docker-breach
    cp your_ssh_key.pub ./authorized_keys
    docker build -t breach .
    docker run -d -p 22 --name breach breach
    docker port breach 22

= Run

    ssh -Y -p (breach_ssh_port) breach@your.docker.example.com

= References

- [Breach - A browser for the HTML5 era](http://breach.cc/)
