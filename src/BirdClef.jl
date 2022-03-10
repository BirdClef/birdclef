module BirdClef

include("allmodules.jl")

using .Data

const dataset = "birdclef-2022"



function main(data_path=joinpath(@__DIR__,"data"))
    @info "Looking for dataset using " data_path dataset
    if !has_dataset(data_path,dataset)
        @warn "You do not have the required kaggle dataset."
        @info "Attemping to download kaggle dataset"
        download_dataset(data_path,dataset)
    else
        @info "Found dataset!"
    end
end

export main,Data

end
