'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach module 'buildMetricsReportApp'

  MainCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller 'MainCtrl', {
      # place here mocked dependencies
    }

  xit 'write tests'
