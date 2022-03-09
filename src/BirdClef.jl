module BirdClef

include("allmodules.jl")

using .Data





function main(data_path=joinpath(@__DIR__,"data"))
    if !has_dataset(data_path)
        download_dataset(data_path)
    end
end

export main,Data

end
