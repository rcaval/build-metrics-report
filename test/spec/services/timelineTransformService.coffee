'use strict'

describe 'Service: timelineTransformService', ->

  # load the service's module
  beforeEach module 'buildMetricsReportApp'

  # instantiate service
  timelineTransformService = {}
  beforeEach inject (_timelineTransformService_) ->
    timelineTransformService = _timelineTransformService_

  TODAY = 0
  FIRST_BUILD  = { segment: "component", timestamp: TODAY, stateDuration: 5000 }
  SECOND_BUILD  = { segment: "ISO", timestamp: TODAY, stateDuration: 3000 }
  THIRD_BUILD  = { segment: "component", timestamp: TODAY+5000, stateDuration: 9000 }

  it 'should group by segment into label', ->
    resources = [FIRST_BUILD, SECOND_BUILD, THIRD_BUILD]

    transformed = timelineTransformService.transform resources

    expect(transformed[0].label).toEqual "component"
    expect(transformed[1].label).toEqual "ISO"


  it 'should fill start_timestamep and end_timestamp', ->
    resources = [FIRST_BUILD, SECOND_BUILD, THIRD_BUILD]

    transformed = timelineTransformService.transform resources

    expect(transformed[0].times[0]).toEqual { "starting_time": TODAY, "ending_time": 5000}
    expect(transformed[0].times[1]).toEqual { "starting_time": TODAY + 5000, "ending_time": TODAY+5000+9000}
    expect(transformed[1].times[0]).toEqual { "starting_time": TODAY, "ending_time": TODAY+3000}
