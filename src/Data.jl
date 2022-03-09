module Data
include("utils.jl")
using .Zip

data_path = joinpath(@__DIR__,"data")

function foldersize(folder)
    total_size = 0 
    function appendwork!(work,folder)
        for (root,dirs,files) in walkdir(folder)
            
            append!(work,map(dirs) do dir
                joinpath(root,dir)    
            end)
            files = map(files) do file
                joinpath(root,file)
            end
            for file in files
                total_size+=filesize(file)
            end
        end    
    end
    work =[folder]
    while length(work)>0
        current_job = pop!(work)
        appendwork!(work,current_job)
    end
    total_size
end


function validate_directory(directories...)
    is_valid,h = false,false
    for directory in directories
        if !isdir(directory)
            if !isfile(directory) 
                mkpath(directory)
                is_valid=false
                h=true
            else
                throw(ErrorException("$directory must not be a file"))
            end
        else
            if !h
                is_valid=true
            end
        end
    end
    is_valid
end


function has_dataset(path::String = data_path)
    birdclef = joinpath(path,"birdclef-2022")
    validate_directory(birdclef) && foldersize(birdclef)>=6600000000
end




function download_dataset(path::String = data_path)
    run(`kaggle competitions download -c birdclef-2022 -p $path`)
    zipped,unzipped = joinpath(path,"birdclef-2022.zip"),joinpath(path,"birdclef-2022")
    unzip_into(zipped,unzipped)
    rm(zipped,force=true)
end


export download_dataset,has_dataset,validate_directory,foldersize

end