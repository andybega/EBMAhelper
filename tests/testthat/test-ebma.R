
library("EBMAforecast")

test_that("Generator function works", {
  data(presidentialForecast)

  expect_error({
    fitted_ebma <- ebma(y = presidentialForecast[ ,7],
                        x = presidentialForecast[ ,c(1:6)],
                        model_type = "normal")
  }, NA)

})

# test_that("Predictions for normal and logit match correct output", {
#   data(presidentialForecast)
#
#   fitted_ebma <- ebma(y = presidentialForecast[ ,7],
#                       x = presidentialForecast[ ,c(1:6)],
#                       model_type = "normal")
#   preds <- predict(fitted_ebma, newdata = presidentialForecast[ ,c(1:6)])
#   expect_equivalent(preds, fitted_ebma[[1]]@predCalibration[, "EBMA", ])
#
#   data(calibrationSample)
#   fitted_ebma <- ebma(y = calibrationSample[,"Insurgency"],
#                       x = calibrationSample[,c("LMER", "SAE", "GLM")],
#                       model_type = "logit")
#   #preds <- predict(fitted_ebma)
#   #expect_equivalent(preds, fitted_ebma[[1]]@predCalibration[, "EBMA", ])
# })
