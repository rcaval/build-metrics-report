'use strict'

app = angular.module('buildMetricsReportApp')

class JenkinsDataService
  @$inject = ['$resource', '$q', '$location','mttrService']

  appendDateDimensions = (build) ->
    build.date = new Date(build.timestamp)
    build.month = d3.time.format('%Y-%m') build.date
    build.week = d3.time.format('%Y-%U') build.date
    build.day = d3.time.format('%Y-%m-%d') build.date
    build

  constructor: ($resource, $q, $location, mttrService) ->
    deferred = $q.defer();

    queryParams = $location.search()

    if queryParams.host && queryParams.jobNames
      buildsParams = queryParams.allBuilds || 'builds'
      jobs = _ queryParams.jobNames.split(',')
              .map _.trim
              .value()
      url = "#{queryParams.host}/job/:jobName/api/json"
      method= 'JSONP'
      params=
        jsonp: 'JSON_CALLBACK'
        tree: "#{buildsParams}[number,id,timestamp,result,duration]"
    else
      jobs = ['1-compile', '2-functional-tests', '3-qa-deploy', '4-automated-integration']
      method= 'GET'
      url = 'data/:jobName.json'
      params = {}

    promises = _(jobs).map (jobName, jobIndex) ->
      $resource(url, {jobName: jobName}, {
        query:
          method: method
          params: params
          isArray: true
          transformResponse: (body, headers) ->
            responseBody = angular.fromJson(body)
            responseBody.allBuilds || responseBody.builds
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
    @jobs = jobs

app.service 'jenkinsDataService', JenkinsDataService
