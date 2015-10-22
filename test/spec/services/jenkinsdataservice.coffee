'use strict'

describe 'Service: JenkinsDataService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  JenkinsDataService = {}
  beforeEach inject (_JenkinsDataService_) ->
    JenkinsDataService = _JenkinsDataService_
