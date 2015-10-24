'use strict'

describe 'Service: mttrService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  mttrService = {}
  beforeEach inject (_mttrService_) ->
    mttrService = _mttrService_

  TODAY = new Date().getTime()
  FIRST_BUILD  = { number: 1, timestamp: TODAY, duration: 1500, result: 'SUCCESS' }
  SECOND_BUILD = { number: 2, timestamp: TODAY + 1000, duration: 2500, result: 'FAILURE' }
  THIRD_BUILD  = { number: 3, timestamp: TODAY + 2000, duration: 3500, result: 'FAILURE' }
  FOURTH_BUILD = { number: 4, timestamp: TODAY + 3000, duration: 4500, result: 'SUCCESS' }
  FIFTH_BUILD  = { number: 5, timestamp: TODAY + 4000, duration: 5500, result: 'FAILURE' }
  SIXTH_BUILD  = { number: 6, timestamp: TODAY + 5000, duration: 6500, result: 'SUCCESS' }

  runAndVerifyResult = (builds, expectedTimes) ->
    mttrService.calculateAllTimeMTTR builds
    expect(_.map(builds, 'allTimeMTTR')).toEqual expectedTimes

  it 'should_return_0_second_when_first_success_build', ->
    runAndVerifyResult [FIRST_BUILD], [0]

  it 'should_return_0_second_when_first_failed_build', ->
    runAndVerifyResult [SECOND_BUILD], [0]

  it 'should_return_0_second_when_2_failed_builds', ->
    builds = [SECOND_BUILD, THIRD_BUILD]
    runAndVerifyResult builds, [0, 0]

  it 'should_return_0_seconds_when_2_success_builds', ->
    builds = [FIRST_BUILD, FOURTH_BUILD]
    runAndVerifyResult builds, [0, 0]

  it 'should_return_0_seconds_when_1_success_and_1_failed_builds', ->
    builds = [FIRST_BUILD, THIRD_BUILD]
    runAndVerifyResult builds, [0, 0]

  it 'should_return_failed_info_when_1_failed_and_1_success_builds', ->
    builds = [THIRD_BUILD, FOURTH_BUILD]
    runAndVerifyResult builds, [0, 1000]

  it 'should_return_failed_info_when_2_failed_and_1_success_builds', ->
    builds = [SECOND_BUILD, THIRD_BUILD, FOURTH_BUILD]
    runAndVerifyResult builds, [0, 0, 2000]

  it 'should_return_failed_info_when_have_all_builds', ->
    builds = [FIRST_BUILD, SECOND_BUILD, THIRD_BUILD,
            FOURTH_BUILD, FIFTH_BUILD, SIXTH_BUILD]
    runAndVerifyResult builds, [ 0, 0, 0, 2000, 0, 1500 ]

  it 'should_return_failed_info_when_have_all_builds_regardless_of_order_they_are_added', ->
    builds = [SIXTH_BUILD, FIFTH_BUILD, FOURTH_BUILD, THIRD_BUILD, SECOND_BUILD, FIRST_BUILD]

    mttrService.calculateAllTimeMTTR builds
    mttrFromSortedBuilds = _(builds).sortBy('timestamp').map('allTimeMTTR').value()
    expect(mttrFromSortedBuilds).toEqual [ 0, 0, 0, 2000, 0, 1500 ]
