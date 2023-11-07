#!/bin/bash
if ! test -d Fooocus
then
  git clone https://github.com/lllyasviel/Fooocus.git
  #git clone --depth 1 --branch V2 https://github.com/lllyasviel/Fooocus.git
fi
cd Fooocus
git pull
cd ..
if ! test -e ~/.conda/envs/fooocus
then
    ln -s /tmp/fooocus ~/.conda/envs/
fi
eval "$(conda shell.bash hook)"
if ! test -d /tmp/fooocus
then
    mkdir /tmp/fooocus
    conda env create -f environment.yaml
    conda activate fooocus
    pip install -r requirements_versions.txt
    pip install torch torchvision --force-reinstall --index-url https://download.pytorch.org/whl/cu117
    pip install pyngrok
    conda install glib -y
    rm -rf ~/.cache/pip
fi
conda activate fooocus
if [ $# -eq 0 ]
then
  python Fooocus/entry_with_update.py & python start-ngrok.py  
elif [ $1 = "reset" ]
then
  python Fooocus/entry_with_update.py & python start-ngrok.py --reset
fi








