#!/bin/bash

# set up
git clone https://github.com/annekroon/dictionaries-vs-sml
cd dictionaries-vs-sml

## If you need python
eval "$(pyenv init -)"
pyenv global $PYTHON_VERSION
pip config set global.index-url https://packagemanager.posit.co/pypi/$SNAPSHOT_DATE/simple
pip install pipreqs jupyterlab notebook nbconvert
## Get python requirements
pip install git+https://github.com/uvacw/inca.git
pipreqs --mode no-pin --force .
pip install -r requirements.txt
## If there are notebooks
pip install pipreqsnb

## !some of the notebooks contain syntax errors and can't be parsed! ##
sed -i 's/    " = \[\]\\n",/    " #= \[\]\\n",/g' analysis/dictionaries_learning_rate.ipynb
sed -i 's/"   def __init__(self, outputpath/"def __init__(self, outputpath/g' analysis/dictionaries_learning_rate.ipynb

# I gave up and removed the file at this point
rm analysis/dictionaries_learning_rate.ipynb
sed -i 's/"pal_colors.append(color_dict/"#pal_colors.append(color_dict/g' analysis/getting-growth-curve-images.ipynb
sed -i 's/eli5.show_weights(clf_pipe top=20)/eli5.show_weights(clf_pipe, top=20)/g' analysis/getting-growth-curve-images.ipynb
## !!! ##

pipreqsnb --force --no-pin .
## there is an issue in pipreqsnb which ignores --no-pin
sed -i 's/==[^ ]*//g' requirements.txt
pip install -r requirements.txt
python --version

## ADD THE BATCH EXECUTION CODE HERE
# 1. get data
python download_datasets.py
cd data
unzip final-data-sets.zip
mv -v final-data-sets/* .

# 2. parse data
cd ../helpers

## note: the downloaded data contains the results, I haven't tried to reproduce the prep function
# python prep_annotated_data.py # prepare the raw file with annotated data (PRA_coding.csv).
# python kamervragen_parser.py # parse the parliamentary questions
# python prep_newspaper_data.py 
# python prep_kamervragen_data.py # this script merges the annotated data with the parsed questions belonging to parliamentary questions.
# python get_dictionary_scores.py
# python preproces.py # adds a cleaned, preprocessed text column.

# 3.0 more prerequesites to get the code to run
cd ../analysis
python3 -c "
import nltk
nltk.download('stopwords')
"

# essentially all paths would need to be changed. Also besides my best efforts, I could not find w2v_300d2000-01-01_2018-12-31
sed -i "s|outputpath='/home/anne/RPA-data/output/frames/'|outputpath='/usr/local/src/output/frames/'|g" F_get_learning_rate_dictionary.py
sed -i "s|/Users/anne/surfdrive/uva/projects/RPA_KeepingScore/data/RPA_data_with_dictionaryscores.pkl|../data/intermediate/RPA_data_with_dictionaryscores.pkl|g" T_get_attention.py


# 3. analysis
for file in $(find . -name "*.py")
do
    echo "Running $file..."
    python "$file"
done

# 4. model training
cd ../model_training
for file in $(find . -name "*.py")
do
    echo "Running $file..."
    python "$file"
done
