'use strict'

describe 'Controller: RefreshCtrl', ->

  # load the controller's module
  beforeEach module 'buildMetricsReportApp'

  RefreshCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    RefreshCtrl = $controller 'RefreshCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(RefreshCtrl.awesomeThings.length).toBe 3
