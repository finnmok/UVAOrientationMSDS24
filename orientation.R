problem_1 <- function() {
  sum <- sum(seq(0, 999, by=3)) + sum(seq(0, 999, by=5)) - sum(seq(0, 999, by=15))
  return(sum)
}

print(problem_1())

problem_2 <- function() {
  a <- 1
  b <- 2
  sum <- 0
  while (b <= 4000000) {
    if (b %% 2 == 0) {
      sum <- sum + b
    }
    temp <- a + b
    a <- b
    b <- temp
  }
  return(sum)
}

print(problem_2())
is_prime <- function(n) {
  if (n <= 1) return(FALSE)
  if (n == 2) return(TRUE)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) return(FALSE)
  }
  return(TRUE)
}

largest_prime_factor <- function(n) {
  factor <- 2
  last_factor <- 1
  while (n > 1) {
    if (n %% factor == 0) {
      last_factor <- factor
      n <- n / factor
      while (n %% factor == 0) {
        n <- n / factor
      }
    }
    factor <- factor + 1
  }
  return(last_factor)
}

print(largest_prime_factor(600851475143))


library(ggplot2)

# Binomial distribution
binom_data <- rbinom(1000, size=100, prob=0.5)
binom_plot <- ggplot(data.frame(x=binom_data), aes(x)) +
  geom_histogram(binwidth=1, color="black", fill="blue") +
  ggtitle("Binomial Distribution")
ggsave("binomial.png", binom_plot)

# Poisson distribution
poisson_data <- rpois(1000, lambda=5)
poisson_plot <- ggplot(data.frame(x=poisson_data), aes(x)) +
  geom_histogram(binwidth=1, color="black", fill="green") +
  ggtitle("Poisson Distribution")
ggsave("poisson.png", poisson_plot)

# Normal distribution
normal_data <- rnorm(1000, mean=0, sd=1)
normal_plot <- ggplot(data.frame(x=normal_data), aes(x)) +
  geom_histogram(binwidth=0.1, color="black", fill="red") +
  ggtitle("Normal Distribution")
ggsave("normal.png", normal_plot)

# Demonstrate convergence of Binomial to Normal
large_binom_data <- rbinom(1000, size=1000, prob=0.5)
large_binom_plot <- ggplot(data.frame(x=large_binom_data), aes(x)) +
  geom_histogram(binwidth=10, color="black", fill="blue") +
  ggtitle("Large Binomial Distribution")
ggsave("large_binomial.png", large_binom_plot)

large_normal_data <- rnorm(1000, mean=500, sd=15.81)
large_normal_plot <- ggplot(data.frame(x=large_normal_data), aes(x)) +
  geom_histogram(binwidth=10, color="black", fill="red") +
  ggtitle("Large Normal Distribution")
ggsave("large_normal.png", large_normal_plot)


library(tidyverse)

# Load data
df <- read_csv('c:/Users/finnr/Downloads/MSDS-Orientation-Computer-Survey(in).csv')

# Binnable data histograms
for (column in names(df)) {
  if (is.numeric(df[[column]])) {
    plot <- ggplot(df, aes_string(x=column)) +
      geom_histogram(binwidth=1, color="black", fill="blue") +
      ggtitle(paste("Histogram of", column))
    ggsave(paste0(column, "_histogram.png"), plot)
  }
}

# Qualitative description for non-binnable features
qualitative_features <- names(df)[sapply(df, is.character)]
qualitative_summary <- df %>%
  select(qualitative_features) %>%
  summarise(across(everything(), ~paste(unique(.), collapse=", ")))
write_csv(qualitative_summary, 'qualitative_summary.csv')

new_colnames <- names(df) %>%
  sapply(function(name) {
    if ("windows" %in% tolower(name)) {
      return("windows")
    } else if ("mac" %in% tolower(name)) {
      return("mac")
    } else {
      return("Other")
    }
  })


library(dplyr)

df <- df %>% mutate(
  `Operating System` = 
    ifelse(
      grepl("windows", tolower(`Operating System`)), "Windows",
      ifelse(
        grepl("macos", tolower(`Operating System`)), "MacOS",
        ifelse(
          grepl("linux", tolower(`Operating System`)), "Linux", 'Other'
        )
      )
    )
)


# Custom label function to show both 2^x and actual numbers
log2_labels <- function(x) {
  sapply(x, function(i) {
    paste0("2^", round(log2(i)), " (", i, ")")
  })
}

# Get unique values of RAM (in GB)
unique_ram_values <- sort(unique(df$`RAM (in GB)`))

# Creating the histogram
p <- ggplot(df, aes(x=`RAM (in GB)`, fill=`Operating System`)) +
  geom_histogram(binwidth=1, position="dodge", color="black", alpha=0.7) +
  labs(title="Histogram of RAM by Operating System", x="RAM (in GB) on log2 scale", y="Count") +
  scale_x_continuous(trans = "log2", breaks = scales::trans_breaks("log2", function(x) 2^x), 
                     labels = log2_labels) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))  # Rotate labels and adjust text size

# Save the plot as an image
ggsave("histogram_ram_by_os.png", plot = p, width = 10, height = 6)