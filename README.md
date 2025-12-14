# Utils

A collection of utility scripts, configurations, and code snippets for server setup, development environment configuration, and common development tasks.

## Table of Contents

- [Quick Setup](#quick-setup)
- [Server Installation Scripts](#server-installation-scripts)
- [Development Environment](#development-environment)
- [Documentation](#documentation)
- [Code Examples](#code-examples)
- [Database & Search](#database--search)

## Quick Setup

### Install ZSH with Oh My Zsh

```bash
sh -c "$(wget https://raw.githubusercontent.com/eugen1j/utils/master/zsh_install.sh -O -)"
```

### Install Ubuntu 20.04 Server

```bash
sh -c "$(wget https://raw.githubusercontent.com/eugen1j/utils/master/ubuntu20.04-install.sh -O -)"
```

## Server Installation Scripts

### Ubuntu 16.04 Installation (`ubuntu16.04install.txt`)

Complete server setup including:
- PostgreSQL 10
- Nginx web server
- PHP 7.2 with FPM and extensions (GD, XML, DOM, ZIP, PostgreSQL, etc.)
- phpPgAdmin for database management
- Redis (compiled from source)
- Nginx configuration for PHP and phpPgAdmin

### Ubuntu 18.04 Installation (`ubuntu18.04-install.sh`)

Development server setup with:
- Build tools (cmake, make, gcc, g++)
- GitLab Runner
- tmux
- PHP 7.2 with extensions
- PostgreSQL 11
- Nginx
- Redis
- Docker & Docker Compose
- Ansible
- Python 3.7
- Certbot for SSL certificates
- Composer
- Golang

Features:
- Automated PostgreSQL password setup
- Server hostname configuration
- SSH key generation (8192-bit RSA)
- Service auto-restart

### Ubuntu 20.04 Installation (`ubuntu20.04-install.sh`)

Minimal setup for CI/CD environments:
- Docker and Docker Compose
- GitLab Runner
- Automated GitLab Runner configuration

## Development Environment

### ZSH Installation (`zsh_install.sh`)

Complete ZSH setup with modern CLI tools:

**Core Components:**
- [Oh My Zsh](https://ohmyz.sh/) - ZSH framework
- [Powerline fonts](https://github.com/powerline/fonts) - Enhanced terminal fonts
- Agnoster theme

**Plugins:**
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Command suggestions
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Syntax highlighting

**Modern CLI Tools:**
- [lsd](https://github.com/Peltoche/lsd) - Modern `ls` replacement
- [bat](https://github.com/sharkdp/bat) - Cat clone with syntax highlighting
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder

**tmux Configuration:**
- Mouse support enabled
- ZSH as default shell

### ZSH Configuration (`.zshrc`)

Pre-configured ZSH settings with:

**Plugins:**
- git
- dotenv
- extract
- docker-compose
- docker-machine
- yii2
- python
- postgres
- pip
- colored-man-pages
- tmux

**Aliases:**
```bash
ls    # lsd with unicode icons
l     # ls -l
la    # ls -a
lla   # ls -la
lt    # ls --tree
```

### GitLab Runner Configuration (`gitlab-ci.sh`)

Setup script for GitLab Runner user:
- Change shell to ZSH
- Add to sudo and www-data groups
- Copy ZSH configuration
- Generate SSH keys (8192-bit)

## Documentation

### uWSGI Setup (`uwsgi.md`)

Comprehensive guide (in Russian) for setting up uWSGI Emperor mode with Django:

**Topics Covered:**
1. Installing uWSGI with Python 3.7
2. Configuring uWSGI Emperor mode
3. Creating systemd service
4. Setting up Django application vassals
5. Nginx configuration for uWSGI

**Key Features:**
- Emperor mode for managing multiple apps
- Systemd integration
- Socket-based communication
- Nginx reverse proxy setup

### Let's Encrypt SSL (`lestencrypt`)

Quick reference for installing SSL certificates with Certbot:
```bash
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python-certbot-nginx
sudo certbot --nginx -d example.com
```

## Code Examples

### Django Model Inheritance (`model_inheritance.py`)

Example of Django model inheritance for a notification system:

**Features:**
- Base `Nt` (Notification) model
- Specialized models: `NtCountry`, `NtCity`, `NtSimple`
- Automatic type field setting via `__init__`
- Dynamic message building with `build_message()`
- Entity retrieval through polymorphic relationships
- Pre-save signal for automatic message generation

**Use Cases:**
- Multi-type notification systems
- Polymorphic model relationships
- Type-safe model inheritance

### Address Autocomplete (`address_autocomplete.js`)

JavaScript function for address autocomplete using the Photon API:

**Features:**
- Async/await syntax
- Uses [Photon geocoding API](https://photon.komoot.de/)
- Returns structured address data with coordinates
- Extracts name, city, state, country
- Includes bounding box extent (lat1, lng1, lat2, lng2)

**Returns:**
```javascript
[{
  name: "City, State, Country",
  lat1: float,
  lng1: float,
  lat2: float,
  lng2: float
}]
```

## Database & Search

### Elasticsearch Examples (`elasticsearch.txt`)

Comprehensive curl command reference for Elasticsearch operations:

**Basic Operations:**
- Index creation and deletion
- Document CRUD operations
- Bulk operations

**Search Queries:**
- Wildcard searches
- Term queries
- Boolean queries with must/should
- Regex searches
- Count queries

**Advanced Configuration:**
- Custom analyzers (Russian language support)
- nGram tokenizer setup (4-12 characters)
- Text field mapping with term vectors
- Index settings (shards, replicas)

**Example Index Configuration:**
- Domain search with nGram tokenization
- Custom analyzer with lowercase filter
- Integer length field
- 5 shards, 1 replica

## File Structure

```
.
├── README.md                    # This file
├── ubuntu16.04install.txt       # Ubuntu 16.04 setup script
├── ubuntu18.04-install.sh       # Ubuntu 18.04 setup script
├── ubuntu20.04-install.sh       # Ubuntu 20.04 setup script
├── zsh_install.sh               # ZSH installation script
├── .zshrc                       # ZSH configuration
├── uwsgi.md                     # uWSGI setup guide (Russian)
├── gitlab-ci.sh                 # GitLab Runner configuration
├── lestencrypt                  # Let's Encrypt commands
├── elasticsearch.txt            # Elasticsearch examples
├── model_inheritance.py         # Django model inheritance example
└── address_autocomplete.js      # Address autocomplete function
```

## Requirements

Different scripts have different requirements:

- **Ubuntu scripts**: Root access, Ubuntu 16.04/18.04/20.04
- **ZSH install**: wget, internet connection
- **uWSGI**: Python 3.7+, Django application
- **GitLab Runner**: Existing GitLab Runner installation
- **Elasticsearch**: Elasticsearch 5.x/6.x

## Notes

- Most installation scripts require root privileges
- Ubuntu installation scripts will restart services
- PostgreSQL password prompts are interactive
- SSH keys are generated without passphrase (configure as needed)
- Some documentation is in Russian (uwsgi.md)

## License

This is a personal utility repository. Use at your own risk.

## Contributing

This is a personal utilities collection. Feel free to fork and adapt for your own use.