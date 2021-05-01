library(testthat)
library(BOLD.R)

example.df1 = get.public(container="PRT")
example.df2 = get.public(container="ACAGA")
time_accessed = Sys.time()
sample.proID1 = c("KAARG414-07", "KBOL015-08", "KBOL024-08", "KBOL043-08", "KPARG289-08", "KPARG487-08", "LBARG036-10", "LBARG148-10", "LBARG344-10", "LBARG345-10")

test_that("Check correct process IDs have been loaded", {
  expect_equal(example.df1$processid, sample.proID1)
  }
)


test_that("Check record code has been assigned", {
  expect_equal(unique(example.df1$record.code), "PRT")
  }
)


test_that("Check that a public API data set has been accessed", {
  expect_equal(unique(example.df1$API.accessed), "Public")
  }
)


test_that("check that data frame was accessed at the current time",{
  expect_lt(unique(as.numeric(
    difftime(strptime(paste(time_accessed),"%M"),
             strptime(paste(example.df1$time.accessed),"%M")
             ))), 5
    )
  }
)


test_that("Check that the COI-5P marker is present.", {
  expect_equal(T, any("COI-5P_nucraw" %in% names(example.df1)))  
  }
)


test_that("Test the 'all.primers' Function for project with just one primer.", {
  expect_equal(all.primers(example.df1), "COI-5P_nucraw")  
  }
)


test_that("Test the 'all.primers' Function for a project with multiple primers.", {
  expect_equal(sort(all.primers(example.df2)), sort(c("COI-5P_nucraw", "COI-LIKE_nucraw", "CYTB_nucraw")))
  }
)


test_that("Test the 'merge.bold' function works", {
  expect_equal(class(merge.bold(example.df1, example.df2)), "data.frame")
  }
)



test_that("Test the 'nucleotides' Function for project with just one primer.", {
  expect_equal(nucleotides(example.df1), "COI-5P_nucraw")  
  }
)


test_that("Test the 'nucleotides' Function for a project with multiple primers.", {
  expect_equal(sort(nucleotides(example.df2)), sort(c("COI-5P_nucraw", "COI-LIKE_nucraw", "CYTB_nucraw")))
  }
)


test_that("Test the 'summary.bold' Function for a project with multiple primers.", {
  expect_equal(class(summary.bold(example.df1)), "table")
  }
)


test_that("Test that the 'gen.DNAbin' function correctly generates a DNAbin with appropriate labels.", {
  expect_equal( class(gen.DNAbin(example.df1, alignment="COI-5P_nucraw", labels=c("processid","taxon"))), "DNAbin")
  }
)

