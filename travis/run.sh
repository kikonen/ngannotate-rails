if [[ $SPROCKETS3 ]]; then
    cd test/rails_4.2.x
else
    cd test/example
fi
echo $PWD

bundle exec rspec
