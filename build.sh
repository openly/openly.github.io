rm -rf ../website-build/*
harp compile ./ ../website-build
rm -f ../website-build/build.sh
echo "letsflo.io" > ../website-build/CNAME