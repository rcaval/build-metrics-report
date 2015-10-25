'use strict'

describe 'Controller: RefreshCtrl', ->

  # load the controller's module
  beforeEach module 'buildMetricsReportApp'

  RefreshCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, $location) ->
    scope = $rootScope.$new()
    RefreshCtrl = $controller 'RefreshCtrl', {
      # place here mocked dependencies
    }

  xit 'should update the url query params', ->
