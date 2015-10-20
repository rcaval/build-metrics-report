'use strict'

###*
 # @ngdoc overview
 # @name buildMetricsReportApp
 # @description
 # # buildMetricsReportApp
 #
 # Main module of the application.
###
angular
  .module 'buildMetricsReportApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'nvd3'
  ]
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .otherwise
        redirectTo: '/'
