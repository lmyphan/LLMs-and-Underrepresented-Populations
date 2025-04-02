##### South East Asian American Silicon Sample Project ####
#### LINH PHAN ###


# Load libraries
library(httr)
library(jsonlite)
library(readr)

# Set API Key
Sys.setenv(OPENAI_API_KEY = YOUR_KEY_HERE)

# Load data
asea <- read_csv("Desktop/Jobs/ASEA.csv")  

# Function to call OpenAI API and get synthetic responses
call_chatgpt <- function(prompt) {
  response <- POST(
    url = "https://api.openai.com/v1/chat/completions",
    add_headers(Authorization = paste("Bearer", Sys.getenv("OPENAI_API_KEY"))),
    content_type_json(),
    body = toJSON(list(
      model = "gpt-4",
      messages = list(
        list(role = "system", content = "Vote Choice"),
        list(role = "user", content = prompt)
      ),
      max_tokens = 20
    ), auto_unbox = TRUE)
  )
  
  result <- content(response, "parsed")
  
  if (!is.null(result$choices) && length(result$choices) > 0) {
    response_text <- result$choices[[1]]$message$content
    
    if (!is.character(response_text) || is.null(response_text) || response_text == "") {
      print("Error")
      return(NA)
    }
    
    return(response_text)
  } else {
    print("Error")
    print(result) 
    return(NA)
  }
}

# Function to create synthetic samples
create_samples <- function(asea, output_file = "synthetic_responses.tsv") {
  responses_list <- list()
  
  for (i in 1:nrow(asea)) {
    # Extract respondent details
    age <- asea$age_years[i]
    race <- asea$Ethnicity[i]
    gender <- asea$genders3_factor[i]
    educ <- asea$education_factor_7type[i]
    pid <- asea$ideology[i]
    
    # Construct persona description
    persona <- paste0("You are a ", age, "-year-old ", race, " American ", gender, 
                      " with a ", educ, " education. You are ", pid, 
                      " and living in the United States in 2020.")  # Using 2020 to match original survey
    
    # Survey Question (copied from Collborative Muli-Racial Post Election Survey)
    survey_question <- "Who did you support in the presidential election? (Even if you didn’t vote) 
    1. Republican: Donald Trump & Mike Pence 
    2. Democrat: Joe Biden & Kamala Harris"
    
    # Create full prompt
    full_prompt <- paste(persona, "\n\n", survey_question)
    
    # Get response
    response_text <- call_chatgpt(full_prompt)
    
    # Store response
    responses_list[[i]] <- data.frame(Persona = persona, Response = response_text, stringsAsFactors = FALSE)
  }
  
  # Combine responses into a dataframe
  responses_df <- do.call(rbind, responses_list)
  
  # Save responses to a TSV file
  write.table(responses_df, file = output_file, sep = "\t", row.names = FALSE, quote = FALSE)
  
  return(responses_df)
}

### Test run on five samples
sample_test_1 <- asea[1:5,] 
create_samples(sample_test_1)

## Run the function on full sample
#full_results <- create_samples(asea, "full_synthetic_responses.tsv")


    
    
