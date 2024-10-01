{ pkgs, lib, config, inputs, ... }:

{
  env.PROJECT_NAME = "example";  # specify your project name
  env.PYTHON_VERSION = "3.12";  # specify your python version

  packages = with pkgs; [
    fzf
    fd
  ];

  scripts.wake.exec = ''
    set -e

    pyenv install -s $PYTHON_VERSION
    pyenv local $PYTHON_VERSION
    pyenv version
    pyenv virtualenv $PROJECT_NAME || true
    echo "$PROJECT_NAME" > .python-version
    source $(pyenv root)/versions/$PROJECT_NAME/bin/activate

    pip install --upgrade pip
    pip install poetry

    if [ -f "pyproject.toml" ]; then
        echo "pyproject.toml found. Running poetry install..."
        poetry install
    else
        echo "pyproject.toml not found. Running poetry init..."
        poetry init
    fi
  '';

  scripts.run-test.exec = ''
    poetry run mypy .
    poetry run pytest . $@
  '';
}
