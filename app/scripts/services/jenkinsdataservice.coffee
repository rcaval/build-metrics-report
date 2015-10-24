'use strict'

app = angular.module('buildMetricsReportApp')

class JenkinsDataService
  @$inject = ['$resource', '$q', 'mttrService']
  appendDateDimensions = (build) ->
    build.date = new Date(build.timestamp)
    build.month = d3.time.format('%Y-%m') build.date
    build.week = d3.time.format('%Y-%U') build.date
    build.day = d3.time.format('%Y-%m-%d') build.date
    build

  constructor: ($resource, $q, mttrService) ->
    deferred = $q.defer();
    jobs = ['1-compile', '2-functional-tests', '3-qa-deploy']

    url = 'data/:job.json'

    promises = _(jobs).map (jobName, jobIndex) ->
      $resource(url, {job: jobName}, {
        query:
          isArray: true
          transformResponse: (body, headers) ->
            responseBody = angular.fromJson(body)
            responseBody.builds
      }
      ).query((builds) ->
        result = _(builds)
        .each (build, index) ->
          build.segment = jobName
          build.order = jobIndex
        .each appendDateDimensions
        .value()

        mttrService.calculateAllTimeMTTR result
        mttrService.calculateAllTimeMTTF result
        mttrService.calculate7DaysMTTR result
        mttrService.calculate7DaysMTTF result
        result
      ).$promise
    .value()

    $q.all(promises).then (resultArray) ->
      deferred.resolve _.flatten(resultArray)

    @data = deferred.promise

app.service 'jenkinsDataService', JenkinsDataService
