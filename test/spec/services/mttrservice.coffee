'use strict'

describe 'Service: mttrService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  mttrService = {}
  beforeEach inject (_mttrService_) ->
    mttrService = _mttrService_

  TODAY = new Date().getTime();
  FIRST_BUILD  = {number: 1, timestamp: TODAY, duration: 1500, result: 'SUCCESS' }
  SECOND_BUILD = {number: 2, timestamp: TODAY + 1000, duration: 2500, result: 'FAILURE' }
  THIRD_BUILD  = {number: 3, timestamp: TODAY + 2000, duration: 3500, result: 'FAILURE' }
  FOURTH_BUILD = {number: 4, timestamp: TODAY + 3000, duration: 4500, result: 'SUCCESS' }
  FIFTH_BUILD  = {number: 5, timestamp: TODAY + 4000, duration: 5500, result: 'FAILURE' }
  SIXTH_BUILD  = {number: 6, timestamp: TODAY + 5000, duration: 6500, result: 'SUCCESS' }

  runAndVerifyResult = (builds, expectedTimes) ->
    mttrService.calculateMTTR builds
    zipped = _.zip(builds, expectedTimes)
    _.each zipped, (zip) ->
      expect(zip[0].mttr).toBe zip[1]

  it 'should return 0 second when first success build', ->
    runAndVerifyResult [FIRST_BUILD], [0]
