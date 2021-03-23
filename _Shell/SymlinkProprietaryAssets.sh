#!/bin/sh
#
# Symlink contents of _AssetsProprietary into Assets directory,
# then .gitignore them to prevent proprietery assets from being
# accidentally included in our public syn3h-player repo.

# Symlink everything from the _AssetsProprietary folder into our Assets folder
ln -v -s ../_AssetsProprietary/* ../Assets/

# Add everything from the _AssetsProprietary folder to our root .gitignore as well
# Props:
# - https://stackoverflow.com/questions/8650871/telling-git-to-ignore-symlinks
# - https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
# - https://stackoverflow.com/questions/3557037/appending-a-line-to-a-file-only-if-it-does-not-already-exist/28021305
SAVEIFS=$IFS
IFS=$'\n'
for f in $(find * -maxdepth 1 -type l); do
    gitignore_line="/[Aa]ssets/$f"
    grep -qxF "$gitignore_line" ../.gitignore || (echo "$gitignore_line" >> ../.gitignore && echo "> $gitignore_line added to .gitignore")
done
IFS=$SAVEIFS

echo  "Symlinks created. Gitignore updated. Mission accomplished."