
library("EBMAforecast")

test_that("Generator function works", {
  data(presidentialForecast)

  expect_error({
    fitted_ebma <- ebma(y = presidentialForecast[ ,7],
                        x = presidentialForecast[ ,c(1:6)],
                        model_type = "normal")
  }, NA)

})
