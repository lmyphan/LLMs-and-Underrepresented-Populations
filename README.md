# LLMs-and-Underrepresented-Populations

Simulating Survey Responses with LLMs: A Case Study on Underrepresented Groups 

### Abstract 

My study investigates whether large language models (LLMs) can generate human-like responses to survey questions when simulating individuals from small and underrepresented populations in the United States. In this method, the LLM first adopts different personas defined by demographic and political characteristics and then takes the survey as these different personas. The responses that the LLMs give are referred to as silicon samples or synthetic data. One potential setback in this process is that LLMs rely on existing data to train on however if there is not enough data on a particular group then the model struggles to provide accurate and nuanced responses. I test the accuracy of LLMs (specifically ChatGPT) on underrepresented groups by using the Southeast Asian American (SEAA) population. The SEAA population serves as an ideal case for this study due to its relatively small size and the well-documented lack of data available for these groups. In particular, I examine whether ChatGPT can generate accurate responses to political questions that have been previously given to SEAA survey respondents, allowing for a comparison between the model’s outputs and actual survey data. 


The `asean.r` script has the code to connect to ChatGPT and the code to create the function to create the samples. 
* `asea.csv` is the dataset and comes from the Collaborative Multi-Racial Post-Election Survey. It has been filtered to only contain respondents who identify as South East Asian American.






Frasure, Lorrie, Wong, Janelle, Vargas, Edward, and Barreto, Matt. Collaborative Multi-racial Post-election Survey (CMPS), United States, 2020. Inter-university Consortium for Political and Social Research [distributor], 2024-06-11.
