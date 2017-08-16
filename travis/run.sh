echo "VER = ${VER}"
if [[ ${VER} == '4_2' ]]; then
    cd test/rails_4.2.x
else if [[ ${VER} == '5_1' ]]; then
    cd test/rails_5.1.x
else if [[ ${VER} == '3_2' ]]; then
    cd test/example
fi
echo $PWD

bundle exec rspec
