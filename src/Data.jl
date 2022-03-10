module Data
include("utils.jl")
using .Zip

const _base_kaggle_error = 
"""
You MUST have kaggle installed to download the dataset or manually download and extract it yourself"

To manually downlead it yourself:
Navigate to the place you downleaded this project and create a directory called data.
Download the BirdClef2022 dataset from kaggle.com and extract the birdclef-2022 directory into the 
directory you just created.
This project should now have the file structure:

data/
    birdclef-2022/
        ...
src/
    ...
...

Using Kaggle:
Download and install kaggle using your python's pip.
Once you have done that, go to https://www.kaggle.com/docs/api to get your credentials.
Put the credentials at 
Linux/Mac:  $(get(ENV,"HOME","\$HOME"))/.kaggle/kaggle.json
Windows  : C:\\Users<Windows-username>.kaggle\\kaggle.json
"""


kaggle_error(pythoncmd) = isnothing(pythoncmd) ? _base_kaggle_error : "$_base_kaggle_error\nTo download kaggle, run this in your terminal:\n\t\$ $pythoncmd -m pip install kaggle.\n"

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


function has_dataset(path::String,dataset::String)
    data_path = joinpath(path,dataset)
    validate_directory(data_path) && foldersize(data_path)>=6600000000
end

function find_python_kaggle(python)
    try
    run(`$python -m kaggle --v`)
    return "$python -m kaggle"
    catch e
        throw(ErrorException(kaggle_error(python)))
    end
end
function find_kaggle()
    kaggle = Sys.which("kaggle")
    if !isnothing(kaggle)
        return kaggle    
    end
    python3 = Sys.which("python3")
    if !isnothing(python3)
        return find_python_kaggle(python3)    
    end
    python = Sys.which("python")
    if !isnothing(python)
        return find_python_kaggle(python)
    end
    throw(ErrorException(kaggle_error(nothing)))
end

function download_dataset(path::String,dataset::String)
    @info "Downloading dataset..." path dataset
    @info "Searching for kaggle..."
    kaggle = find_kaggle()
    cmd=`$kaggle competitions download -c $dataset -p $path`
    @info "Starting data installation using" cmd
    run(cmd)
    zipped,unzipped = joinpath(path,"$dataset.zip"),joinpath(path,dataset)
    @info "extracting files...." zipped unzipped
    extract(zipped,unzipped)
    @info "cleaning up..."
    rm(zipped,force=true)
    @info "Done downloading dataset" dataset
end


export download_dataset,has_dataset,validate_directory,foldersize

end