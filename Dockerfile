FROM julia:latest
RUN mkdir data
RUN mkdir -p ~/.julia/v1.5/dev/BirdClef/src/
RUN apt-get update -y
RUN apt-get install -y python3 python3-pip
RUN pip3 install kaggle
COPY ./Project.toml ~/.julia/v1.5/dev/BirdClef/Project.toml
COPY ./src ~/.julia/v1.5/dev/BirdClef/src
ENV KAGGLE_USERNAME=$KAGGLE_USERNAME
ENV KAGGLE_KEY=$KAGGLE_KEY
RUN julia -e "using Pkg; Pkg.add(url=\"https://github.com/BirdClef/birdclef\");Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile(); "
COPY ./main.jl ./main.jl
CMD ["julia","--project=.","main.jl"] 