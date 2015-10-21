'use strict'

describe 'Controller: PivotCtrl', ->

  # load the controller's module
  beforeEach module 'buildMetricsReportApp'

  PivotCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PivotCtrl = $controller 'PivotCtrl', {
      # place here mocked dependencies
    }

  
