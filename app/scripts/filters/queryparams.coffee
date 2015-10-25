'use strict'

angular.module 'buildMetricsReportApp'
  .filter 'queryParams', ->
    (opts) ->
      params = []
      for opt of opts
        `opt = opt`
        if opts.hasOwnProperty(opt)
          if opts[opt] != '' and opts[opt] != undefined
            params.push opt + '=' + opts[opt]
      if params.length then '?' + params.join('&') else ''
