# Container .bashrc for Zed IDE

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Set a useful prompt showing we're in the container
PS1='\[\033[01;32m\][zed]\[\033[00m\] \w $ '

# Add common paths
export PATH="/root/.local/bin:${PATH}"

# Aliases
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
