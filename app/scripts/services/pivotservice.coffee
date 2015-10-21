'use strict'
app = angular.module('buildMetricsReportApp')

class PivotService

  @$inject = ['$resource']
  appendDateDimensions = (build) ->
    build.date = new Date(build.timestamp)
    build.month = d3.time.format('%Y-%m') build.date
    build.week = d3.time.format('%Y-%U') build.date
    build

  constructor: ($resource) ->
    url = 'data/1-compile.json'
    resource = $resource url, null, {
      query:
        timeout: 5000
        isArray: true
        transformResponse: (data) ->
          jsonData = angular.fromJson(data)
          _(jsonData.builds).map appendDateDimensions
          .value()

    }

    @pivotData = resource.query(
      (data) ->

      (response) =>
        # do something here on failure if necessary
      )

app.service 'pivotService', PivotService
