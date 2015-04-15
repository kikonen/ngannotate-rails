app = angular.module 'myApp', []

app.config ($locationProvider) ->
  $locationProvider.setHtml5Mode(true)

app.controller 'MainController', ($scope) ->

app.directive 'myDirective', ($location) ->
  restrict: 'EA'
  controller: ($scope, $element) ->

app.provider 'Service', ($location) ->
  @$get = ($window) ->
  null

app.provider 'OtherService',
  $get: ($window) ->

app.run ($window) ->
  $window.alert 'test!'
