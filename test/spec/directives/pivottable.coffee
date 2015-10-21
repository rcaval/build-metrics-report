'use strict'

describe 'Directive: pivotTable', ->

  # load the directive's module
  beforeEach module 'buildMetricsReportApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pivot-table></pivot-table>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pivotTable directive'
