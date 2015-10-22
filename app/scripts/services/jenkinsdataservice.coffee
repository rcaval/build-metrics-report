'use strict'

app = angular.module('buildMetricsReportApp')

class JenkinsDataService
  @$inject = ['$resource', '$q']
  appendDateDimensions = (build) ->
    build.date = new Date(build.timestamp)
    build.month = d3.time.format('%Y-%m') build.date
    build.week = d3.time.format('%Y-%U') build.date
    build.day = d3.time.format('%Y-%m-%d') build.date
    build

  constructor: ($resource, $q) ->
    deferred = $q.defer();
    jobs = ['1-compile', '2-functional-tests', '3-qa-deploy', '4-automated-integration']

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
        _(builds)
        .each (build, index) ->
          build.segment = jobName
          build.order = jobIndex
        .each appendDateDimensions
        .value()
      ).$promise
    .value()

    $q.all(promises).then (resultArray) ->
      deferred.resolve _.flatten(resultArray)

    @data = deferred.promise

app.service 'jenkinsDataService', JenkinsDataService
