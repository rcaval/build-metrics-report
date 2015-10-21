'use strict'

describe 'Service: pivotService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  pivotService = {}
  beforeEach inject (_pivotService_) ->
    pivotService = _pivotService_

  it 'should do something', ->
    expect(!!pivotService).toBe true
