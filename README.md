# BirdClef

Project info here

# Building
You must have julia installed on your system.

## (Option 1) Using Kaggle to get dataset
You must have kaggle installed on your system, and you must have the command 'unzip'.
To install kaggle:
```
$ pip install kaggle
```
OR

```
$ pip3 install kaggle
```

To verify kaggle installation, run
```
$ kaggle --v
```

You must also authenticate with kaggle; Go to www.kaggle.com and retrieve your credentials.
You may either follow the kaggle documentation, and put the credentials as $HOME/.kaggle/kaggle.json
OR set the environment variables $KAGGLE_USERNAME and $KAGGLE_KEY to your credentials.

Navigate to this projects directory to run the following commands.

On the first time running this program, run the following to install all needed packages
```
$ julia --project=. setup.jl
```

Then, to run the project:
```
$ julia --project=. main.jl
```

## (Option 2) Downloading and extracting the dataset

Navigate to the place you downleaded this project and create a directory called data.
Download the BirdClef2022 dataset from kaggle.com and extract the birdclef-2022 directory into the directory you just created.
This project should now have the file structure:

```
data/
    birdclef-2022/
        ...
src/
    ...
...
```

Navigate to this projects directory to run the following commands.

On the first time running this program, run the following to install all needed packages
```
$ julia --project=. setup.jl
```

Then, to run the project:
```
$ julia --project=. main.jl
```

## (Option 3) Dockerfile
You must have docker installed on your system.
You must also authenticate with kaggle; Go to www.kaggle.com and retrieve your credentials.
You must set the environment variables $KAGGLE_USERNAME and $KAGGLE_KEY to your credentials.

Navigate to this projects directory to run the following commands.

if you have 'make' (may require sudo)
```
$ make run
```
OR

```
$ docker build . -t birdclef
$ docker run birdclef
```
