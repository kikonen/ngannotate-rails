require 'rails_helper'

describe 'annotate js' do
  let(:expected_content) {
<<EOF
(function() {
  var app;

  app = angular.module('myApp', []);

  app.config(["$locationProvider", function($locationProvider) {
    return $locationProvider.setHtml5Mode(true);
  }]);

  app.controller('MainController', ["$scope", function($scope) {}]);

  app.directive('myDirective', ["$location", function($location) {
    return {
      restrict: 'EA',
      controller: ["$scope", "$element", function($scope, $element) {}]
    };
  }]);

  app.provider('Service', ["$location", function($location) {
    this.$get = ["$window", function($window) {}];
    return null;
  }]);

  app.provider('OtherService', {
    $get: ["$window", function($window) {}]
  });

  app.run(["$window", function($window) {
    return $window.alert('test!');
  }]);

}).call(this);
EOF
  }

  it 'annotate js' do
    get '/assets/angular-app-coffee.js'

   expect(response.body).to eq expected_content
  end
end
