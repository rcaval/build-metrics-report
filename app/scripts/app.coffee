'use strict'

angular
  .module 'buildMetricsReportApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.grid'
  ]
  .config ($routeProvider,$httpProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
        controllerAs: 'main'
      .when '/pivot',
        templateUrl: 'views/pivot.html'
        controller: 'PivotCtrl'
        controllerAs: 'pivot'
      .when '/originaldata',
        templateUrl: 'views/originaldata.html'
        controller: 'OriginalDataCtrl'
        controllerAs: 'originaldata'
      .otherwise
        redirectTo: '/'

    $httpProvider.defaults.headers.common['Access-Control-Allow-Origin'] = '*';

  .run ($rootScope, $location) ->
    $rootScope.QueryParams = $location.search()
