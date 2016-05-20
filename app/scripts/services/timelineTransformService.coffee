'use strict'

angular.module 'buildMetricsReportApp'
  .service 'timelineTransformService', ->
    transform: (resources) ->
      buildTimes = (builds) ->
        _(builds).map((build) -> {
              starting_time: build.timestamp
              ending_time: build.timestamp + build.stateDuration - 1
              status: build.result
            }).value()
      _(resources)
        .groupBy('segment')
        .map((builds, key) -> {label: key, times: buildTimes(builds)})
        .value()
