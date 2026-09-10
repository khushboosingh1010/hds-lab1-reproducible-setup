library(haven)

data <- read_xpt("data/OHXPER_H.xpt")
complete <- data[data$OHDPDSTS == 1, ]

pocket_columns <- grep(
  "^OHX[0-9][0-9]PC[ADLMPS]$",
  names(complete),
  value = TRUE
)

pocket_depths <- complete[pocket_columns]
pocket_depths[pocket_depths == 99] <- NA_real_

valid_depths <- unlist(pocket_depths, use.names = FALSE)
valid_depths <- valid_depths[!is.na(valid_depths)]

participant_max <- apply(
  pocket_depths,
  1,
  function(values) {
    if (all(is.na(values))) {
      NA_real_
    } else {
      max(values, na.rm = TRUE)
    }
  }
)

participants <- nrow(complete)
valid_measurements <- length(valid_depths)
mean_depth <- mean(valid_depths)
deep_pocket_count <- sum(participant_max >= 4, na.rm = TRUE)
deep_pocket_percent <- (
  deep_pocket_count / sum(!is.na(participant_max))
) * 100

cat("NHANES 2013-2014 Periodontal Examination\n")
cat(sprintf(
  "Participants with complete periodontal exam: %d\n",
  participants
))
cat(sprintf("Valid pocket-depth measurements: %d
", valid_measurements))
cat(sprintf("Mean pocket depth (mm): %.2f
", mean_depth))
cat(sprintf("Participants with pocket depth >= 4 mm: %d
", deep_pocket_count))
cat(sprintf("Percentage with pocket depth >= 4 mm: %.2f%%
", deep_pocket_percent))
