context("[Quality Control] MSA Test Retest")

options <- analysisOptions("msaTestRetest")
options$testRetestDataFormat <- "testRetestWideFormat"
options$parts <- "Part"
options$measurements <- c("X1", "X2")
options$EnableRangePSD <- TRUE
options$rangePSD <- 2
options$EnableRangeTolerance <- TRUE
options$rangeTolerance <- 0.5
options$rangeRr <- TRUE
options$rangeScatterPlotOperatorParts <- TRUE
options$rangeScatterPlotOperators <- TRUE
options$rangeScatterPlotFitLine <- TRUE
options$jitter <- TRUE
options$rangeRchart <- TRUE
options$trafficPlot <- TRUE

results <- runAnalysis("msaTestRetest", "msaTestRetest.csv", options)

test_that("Run chart of parts plot matches", {
  plotName <- results[["results"]][["ScatterOperatorParts"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "run-chart-of-parts")
})

test_that("Scatterplot of 1st measurement vs 2nd measurement matches", {
  plotName <- results[["results"]][["ScatterOperators"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "scatterplot-of-1st-measurement-vs-2nd-measurement")
})

test_that("Short gauge study table results match", {
  table <- results[["results"]][["rAndR2"]][["data"]]
  jaspTools::expect_equal_tables(table,
                                 list(0.0434914974122558, 2.17457487061279, 0.52189796894707, 2, 0.0499999999999999,
                                      1.14965, 15, 0.5))
})

test_that("Range chart by part plot matches", {
  plotName <- results[["results"]][["rangeRchart"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "range-chart-by-part")
})

test_that("titleless-plot-4 matches", {
  plotName <- results[["results"]][["trafficPlot"]][["collection"]][["trafficPlot_plot"]][["data"]]
  testPlot <- results[["state"]][["figures"]][[plotName]][["obj"]]
  jaspTools::expect_equal_plots(testPlot, "titleless-plot-4")
})

