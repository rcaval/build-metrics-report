'use strict'

describe 'Filter: queryParams', ->

  # load the filter's module
  beforeEach module 'buildMetricsReportApp'

  # initialize a new instance of the filter before each test
  queryParams = {}
  beforeEach inject ($filter) ->
    queryParams = $filter 'queryParams'

  it 'should render object as a query string', ->
    queryObj =
      foo1: 'bar'
      foo2: 'zus'

    expect(queryParams queryObj).toBe ('?foo1=bar&foo2=zus')
