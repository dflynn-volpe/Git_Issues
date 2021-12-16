
# Get RDR issues and make a table of them
library(dplyr)
# Assumptions: a personal access token has been created and resides in the users's home directory

library(jsonlite)

homedir <- "~/git/Git_Helpers"

iss_files = c('RDR_issues.json', 'RDR_issues2.json')

compiled = vector()

for(i in 1:length(iss_files)){
  issues <- fromJSON(txt = file.path(homedir, iss_files[i]))
  # optional: make flatten = TRUE 

  # Some elements are lists. For these, turn them into concatenated values for writing to csv
  list_elems = names(issues)[sapply(issues, FUN = class) == 'list']
  
  implemented = c('labels', 'assignees')
  
  for(l in list_elems){
    
    if(!l %in% implemented) {
      stop(paste(l, ' is a list but has not yet been implemented in this script for simplification to a single string'))
    }
    
    if(l == 'assignees'){
      replace_vals = unlist(lapply(issues[[l]], function(x) paste(x[['login']], collapse = ', ')))
    }
    
    
    if(l == 'labels'){
      replace_vals = unlist(lapply(issues[[l]], function(x) paste(x[['name']], collapse = ', ')))
    }
    
    issues[[l]] = replace_vals
    
  }
  
  if(i == 1){ compiled = issues} else { compiled = compiled %>% full_join(issues)}
}



write.csv(compiled, file = file.path(homedir, 'RDR_issues.csv'), row.names = F)
