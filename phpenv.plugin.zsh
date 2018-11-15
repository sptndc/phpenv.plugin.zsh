FOUND_PHPENV=0
phpenvdirs=("$HOME/.phpenv" "/usr/local/phpenv" "/opt/phpenv" "/usr/local/opt/phpenv")
if [[ $PHPENV_ROOT = '' ]]; then 
  PHPENV_ROOT="$HOME/.phpenv"
fi

for phpenvdir in "${phpenvdirs[@]}"; do
  if [ -d "$phpenvdir/bin" ] && [ "$FOUND_PHPENV" -eq 0 ]; then
    FOUND_PHPENV=1
    if [[ $PHPENV_ROOT = '' ]]; then
      PHPENV_ROOT=$phpenvdir
    fi
    export PHPENV_ROOT
    export PATH=${phpenvdir}/bin:$PATH
    eval "$(phpenv init --no-rehash - zsh)"

    alias phpies="phpenv versions"

    function current_php() {
      phpenv version-name
    }

    function phpenv_prompt_info() {
      current_php
    }
  fi
done
unset phpenvdir

if [ $FOUND_PHPENV -eq 0 ]; then
  alias phpies='php -v'

  function phpenv_prompt_info() {
    echo "system: $(php -v | cut -f-2 -d ' ')"
  }
fi
