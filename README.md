# build-metrics-report

Build metric reports form jenkins.

This project is generated with [yo angular generator](https://github.com/yeoman/generator-angular)
version 0.12.1.

## Build & development


Run `grunt` for building and `grunt serve` for preview.

It might require you to install the compass gem.

## Testing

Running `grunt test` will run the unit tests with karma.


## Backlog

Build Metrics

Charts:
 - [done] build time trend
 - [done] build success/failure trend
 - [done] MTTF last 7 days trend
 - [done] MTTR last 7 days trend

 Tech debt:
  - [done] Parameterize job names
  - [done] Charts per job to use job names and ngRepeat
  - [done] Hook real jenkins endpoint
  - allBuilds vs last 100 builds
  - Apply other snap api

Nice to have visualizations
 - Variance/std dev of build time per segment
 - Heat map success failure per segment
 - Relate area of code with break
 - Table Summary
  - build time average
  - Success/Failure %
  - MTTF
  - MTTR
