### Classifying ENSO categories and duration
### https://github.com/hydrocodes
# Input monthly data (e.g. see CSV file with ICEN index)
data <- read.csv(".../icen_index.csv", header=T)
# Function to classify months, add category levels (e.g. 8 categories for El Niño and La Niña)
classify_enso <- function(data) {
  data$Category <- cut(
    data$Index,
    breaks = c(-Inf, -1.3, -1.1, -0.7, 0.5, 1.3, 2.1, 3.5, Inf),
    labels = c("Strong La Niña", "Moderate La Niña", "Weak La Niña", "Neutral", "Weak El Niño", "Moderate El Niño", "Strong El Niño", "Extreme El Niño"),
    include.lowest = TRUE
  )
  data$Category[data$Index < 0.5 & data$Index > -0.7] <- "Neutral"
  data$Category[data$Index >= 0.5 & data$Index < 1.3] <- "Weak El Niño"
  data$Category[data$Index >= 1.3 & data$Index < 2.1] <- "Moderate El Niño"
  data$Category[data$Index >= 2.1 & data$Index < 3.5] <- "Strong El Niño"
  data$Category[data$Index >= 3.5] <- "Extreme El Niño"
  data$Category[data$Index <= -0.7 & data$Index > -1.1] <- "Weak La Niña"
  data$Category[data$Index <= -1.1 & data$Index > -1.3] <- "Moderate La Niña"
  data$Category[data$Index <= -1.3] <- "Strong La Niña"
  
# Identify sequences of at least 3 consecutive months with the same label as TRUE
  data$Status <- FALSE
  for (i in 1:(nrow(data) - 2)) {
    if (data$Category[i] == data$Category[i + 1] && data$Category[i] == data$Category[i + 2]) {
      data$Status[i:(i + 2)] <- TRUE
    }
  }
 return(data)
}

# Function to count duration of repeated categories
count_duration <- function(data) {
  # Initialize Status and Duration columns
  data$Status <- FALSE
  data$Duration <- 0
  # Identify sequences of at least 3 consecutive months with the same Category
  n <- nrow(data)
  i <- 1
  while (i <= n) {
    if (i <= n - 2) {
      if (data$Category[i] == data$Category[i + 1] && data$Category[i] == data$Category[i + 2]) {
        # Find the length of the sequence
        j <- i
        while (j <= n && data$Category[j] == data$Category[i]) {
          j <- j + 1
        }
        sequence_length <- j - i
        # Mark Status as TRUE and set COUNT for the sequence
        data$Status[i:(j - 1)] <- TRUE
        data$Duration[i:(j - 1)] <- sequence_length
        # Skip the sequence
        i <- j
      } else {
        i <- i + 1
      }
    } else {
      i <- i + 1
    }
  }
  return(data)
}

# Apply the function
p <- classify_enso(data)
classified_data <- count_duration(p)
write.csv(classified_data,".../icen_index_output.csv")

