'use strict'

describe 'Controller: OriginaldataCtrl', ->

  # load the controller's module
  beforeEach module 'buildMetricsReportApp'

  OriginaldataCtrl = {}

  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    OriginaldataCtrl = $controller 'OriginaldataCtrl', {
      # place here mocked dependencies
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(OriginaldataCtrl.awesomeThings.length).toBe 3
