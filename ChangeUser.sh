echo "Change to: $1"

# remove folders
rm -rf .ssh
rm .gitconfig

# copy user settings files
cp ".gitconfig.$1" .gitconfig
cp -R ".ssh.$1" .ssh


# print result
echo "gitconfig:"
cat .gitconfig∂

echo "-----------"
echo "ssh:"
ls .ssh
