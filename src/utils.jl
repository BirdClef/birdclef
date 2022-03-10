module Zip

using ZipFile

function unzip(callback,src)
    r = ZipFile.Reader(src);
    try 
        for f in r.files
            callback(f);
        end
        return true
    catch e
        throw(e)
    finally
        close(r)
    end
end

function newdir(path)
    if isfile(path)
        throw(ErrorException("Failed to create directory; $path is a file."))
    end
    if !isdir(path)
        mkpath(path)
    end
end

entry_exists(path) = isfile(path) || isdir(path)

function extract(src,dst,delete_existing::Bool=true)
    newdir(dst)
    unzip(src) do file
        path = joinpath(dst,file.name)
        if delete_existing && entry_exists(path)
            rm(path,force=true)
        end
        needed_dirs,_ = splitdir(path)
        newdir(needed_dirs)
        write(path,file)
    end
end

export unzip,extract

end