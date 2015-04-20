echo "SPROCKETS3 = ${SPROCKETS3}"
if [[ ${SPROCKETS3} == true ]]; then
    cd test/rails_4.2.x
else
    cd test/example
fi
echo $PWD

bundle exec rspec
