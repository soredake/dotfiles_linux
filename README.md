## Usage

* Clone this repo somewhere: `git clone https://$THISURL.git $HOME/somewhere`
* To install run `./dotfiles.sh`
* To update the dotfiles run `git pull && ./dotfiles.sh`
* Alternatively, if you're setting up a fresh gentoo install, use the `scripts/home.sh` script, which will set everything up and run all of the other scripts for you

## Customization

* In order to keep private info from public repos, use the `.init/private` file; it's only copied by the `dotfiles.sh` script if it doesn't already exist
* It's also a place you can add extra private aliases, functions, etc.
* If you're maintaining a fork, run `git update-index --assume-unchanged` on this file in order to ignore the it's changes

## Additional scripts

The following scripts are available in the "scripts" folder:

* `home.sh` __Wrapper around the all of the other scripts; use this to set up a new Gentoo__
* `docker.sh` Install docker images
* `linux.sh` Sets up sensible defaults for gentoo settings and a couple other cool tweaks
* `node.sh` Install global nodejs packages
* `portage.sh` Install command-line tools using Portage
* `stage3.sh` Install at stage3

## Help

* [Zsh Alias cheat sheet](ZSH.md)
* [Git Alias cheat sheet](GIT.md)

## Credits

Most of this was based on work by these awesome people:
* __Alex Weber https://github.com/alexweber/home__
* Mathias Bynens https://github.com/mathiasbynens/dotfiles
* Jan Moesen https://github.com/janmoesen/tilde
* Paul Irish https://github.com/paulirish/dotfiles
* Gianni Chiappetta https://github.com/gf3/dotfiles/tree/v1.0.0
* Cãtãlin Mariş  https://github.com/alrra/dotfiles
* Nicolas Gallagher  https://github.com/necolas/dotfiles
* Kevin Suttle https://github.com/kevinSuttle/dotfiles
* Ben Alman  https://github.com/cowboy/dotfiles
* Matijs Brinkhuis  https://github.com/matijs/dotfiles
