using BirdClef
data_path= get(ENV,"BIRDCLEF_DATA_DIR",joinpath(@__DIR__,"data"))
main(data_path)