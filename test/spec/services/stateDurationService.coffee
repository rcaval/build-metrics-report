'use strict'

describe 'Service: stateDurationService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  stateDurationService = {}
  beforeEach inject (_stateDurationService_) ->
    stateDurationService = _stateDurationService_

  TODAY = new Date().getTime()
  FIRST_BUILD  = { number: 1, timestamp: TODAY,   result: 'SUCCESS' }
  SECOND_BUILD = { number: 2, timestamp: TODAY + 5000,  result: 'FAILURE' }
  THIRD_BUILD  = { number: 3, timestamp: TODAY + 9000,  result: 'FAILURE' }

  it 'should append state duration for each build', ->
    builds = [FIRST_BUILD, SECOND_BUILD, THIRD_BUILD]

    stateDurationService.appendStateDuration builds
    expect(FIRST_BUILD.stateDuration).toEqual 5000
    expect(SECOND_BUILD.stateDuration).toEqual 4000
