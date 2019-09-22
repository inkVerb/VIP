# Jupyter Notebook

## Install the framework
`sudo apt install python3-pip python3-dev`

`sudo -H pip3 install --upgrade pip`

`sudo -H pip3 install virtualenv`

## Prepare your work projects and install Jupyter there
*Note `work_dir` and `work_env` can be anything*

`mkdir ~/work_dir`

`cd ~/work_dir`

`virtualenv work_env`

`source work_env/bin/activate`

`pip install jupyter`

## Run Jupyter Noteboook
*Open a terminal you can allow to be busy*

`jupyter notebook`

*Copy and paste into the browser a one of the links like this: `http://localhost:8888/...`*
