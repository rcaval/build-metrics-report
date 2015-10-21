'use strict'

describe 'Service: pivot', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  pivot = {}
  beforeEach inject (_pivot_) ->
    pivot = _pivot_

  it 'should do something', ->
    expect(!!pivot).toBe true
