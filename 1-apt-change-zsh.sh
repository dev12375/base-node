#!/bin/bash
NEW_PORT=12375
PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDVLeoxRIuU0hQHYS9Kt1Y0sBvQGFCCWd3XHUpkkwisO9gbPfsauXMGJec+edYLEX8W8kNy3jahn80VbDIFutffbf8wx8rtSwnF8G2F1IfucXFqCooUOViSM/pybPKynjC34q3Vz6laIsaVaPrzGfYZe+6Zc2X5q2y/jfs5jNE5XHFf1SX4HsIjNwfNlPtVaEwLi7YKvhPvSGshVrJfSj0axj1frg9JrD9bH1aLi6rO3PcTA4tP4AZIGJI0ArppYaX+tgCZaaiGfPBeDc0jRO/Y1a0P0or0a67vSGdQBWIJWpEGPwIC6HyWWlHCyoIEUKC4DmIKOuA9Y9RroLxY0dgVXgwIlB8oL9d1Tq8p4Vtpxx1WM5bv/XGcKPWPXbaUsXLlpVhQ+SfgZgCFk4NS/W0+Elvi6a7eEcCfm4kjoYUVDeaxD4PSqKqxHmrJn4nKN4n6Chf2vtYZvO12g2CA1LUNOuCFtkrg5lxUooKnO1DrQEWhm0eHlEJ3jEJA6YWW5xk= chan"
install_dep(){
    apt-get update
    apt-get install -y git gcc g++ zsh aria2 make net-tools tmux jq pigz
}


change_zsh(){
    chsh -s /usr/bin/zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}
change_ssh(){
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config_backup

    # 修改 SSH 配置文件中的端口号
    sed -i "s/#Port 22/Port $NEW_PORT/" /etc/ssh/sshd_config

    # 启动 SSH 服务
    systemctl start ssh

    cat $PUB_KEY >> ~/.ssh/authorized_keys

}

install_dep
change_ssh
change_zsh
