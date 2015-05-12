require 'rails_helper'

describe 'annotate js' do
  let(:expected_content) {
<<EOF
var app = angular.module('myApp', []);

app.config(["$locationProvider", function($locationProvider) {
  $locationProvider.setHtml5Mode(true);
}]);

app.controller('MainController', ["$scope", function($scope) {}]);

app.directive('myDirective', ["$location", function($location) {
  return {
    restrict: 'EA',
    controller: ["$scope", function($scope) {}]
  };
}]);

app.provider('Service', ["$location", function($location) {
  this.$get = ["$window", function($window) {}];
}]);

app.provider('OtherService', {
  $get: ["$window", function($window) {}]
});

app.run(["$window", function($window) {
  $window.alert('test!');
}]);
EOF
  }

  it 'annotate js' do
    get '/assets/angular-app-js.js'
    expect(response.body).to eq expected_content
  end
end
