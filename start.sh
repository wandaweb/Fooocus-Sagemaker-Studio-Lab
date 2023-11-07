#!/bin/bash
if [ ! -d "Fooocus" ]
then
  git clone https://github.com/lllyasviel/Fooocus.git
  #git clone --depth 1 --branch V2 https://github.com/lllyasviel/Fooocus.git
fi
cd Fooocus
git pull
if [ ! -L ~/.conda/envs/fooocus ]
then
    ln -s /tmp/fooocus ~/.conda/envs/
fi
eval "$(conda shell.bash hook)"
if [ ! -d /tmp/fooocus ]
then
    mkdir /tmp/fooocus
    conda env create -f environment.yaml
    conda activate fooocus
    pwd
    ls
    pip install -r requirements_versions.txt
    pip install torch torchvision --force-reinstall --index-url https://download.pytorch.org/whl/cu117
    pip install pyngrok
    conda install glib -y
    rm -rf ~/.cache/pip
fi
conda activate fooocus
cd ..
if [ $# -eq 0 ]
then
  python start-ngrok.py 
elif [ $1 = "reset" ]
then
  python start-ngrok.py --reset 
fi
