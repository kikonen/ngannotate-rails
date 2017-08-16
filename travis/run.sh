echo "VER = ${VER}"
if [[ ${VER} == '5_1' ]]; then
    cd test/rails_5.1.x
elif [[ ${VER} == '4_2' ]]; then
    cd test/rails_4.2.x
elif [[ ${VER} == '3_2' ]]; then
    cd test/example
fi
echo $PWD

bundle exec rspec
