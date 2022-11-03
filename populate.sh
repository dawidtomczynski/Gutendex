#!/bin/bash

cd project
pip install -r requirements.txt
python3 manage.py migrate
python3 manage.py updatecatalog
