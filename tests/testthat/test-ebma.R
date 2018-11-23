
library("EBMAforecast")

test_that("Generator function works", {
  data(presidentialForecast)

  expect_error({
    fitted_ebma <- ebma(y = presidentialForecast[ ,7],
                        x = presidentialForecast[ ,c(1:6)],
                        model_type = "normal")
  }, NA)

})

test_that("predict for normal model works", {
  data(presidentialForecast)
  fitted_ebma <- ebma(y = presidentialForecast[ ,7],
                      x = presidentialForecast[ ,c(1:6)],
                      model_type = "normal")
  preds <- predict(fitted_ebma, newdata = presidentialForecast[ ,c(1:6)])
  expect_equivalent(preds, fitted_ebma[[1]]@predCalibration[, "EBMA", ])
})


test_that("predict for logit model works", {
  data(calibrationSample)
  fitted_ebma <- ebma(y = calibrationSample[,"Insurgency"],
                      x = calibrationSample[,c("LMER", "SAE", "GLM")],
                      model_type = "logit")

  # errors out right now on the EBMAforecast side
  expect_error(preds <- predict(fitted_ebma))
  #expect_equivalent(preds, fitted_ebma[[1]]@predCalibration[, "EBMA", ])
})
