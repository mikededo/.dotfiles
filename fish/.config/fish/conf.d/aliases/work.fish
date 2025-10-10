# Fast access to common directories
alias work="cd $HOME/Documents/work"

# dinamically create aliases based on the folders
for folder in (ls -d ~/Documents/work/*/ | xargs -n1 basename)
    if test $folder != test
        alias $folder="work && cd $folder"
    end
end
