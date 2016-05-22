# build-metrics-report

Build metric reports form jenkins.

[![Build Status](https://snap-ci.com/rcaval/build-metrics-report/branch/master/build_image)](https://snap-ci.com/rcaval/build-metrics-report/branch/master)

This project is generated with [yo angular generator](https://github.com/yeoman/generator-angular) version 0.12.1.

## Install

Run `npm install`

It might require you to install [bower](http://bower.io/#install-bower).

## Build & development

Run `npm run build` for building and `npm start` for preview.

It might require you to install the [compass](http://compass-style.org/install/) gem.

## Testing

Running `npm test` will run the unit tests with karma.

## Backlog

Build Metrics

Charts:

- build time trend
- build success/failure trend
- MTTF last 7 days trend
- MTTR last 7 days trend
- Heat map success failure per segment

- Tech debt:

  - Use snap-ci api

Nice to have visualizations

- Variance/std dev of build time per segment
- Relate area of code with break
