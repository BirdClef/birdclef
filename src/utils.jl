module Zip


function unzip_into(src::String,dest::String)
    # ZipFile.jl sucks, so this is a workaround
    run(`unzip $src -d $dest -qq`)
end

export unzip_into

end