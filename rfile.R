```{r}
library(Hmisc)
```


```{r}
movies = read.csv("movies.csv", header = TRUE) %>% 
  mutate(title = as.character(title),
         domgross = as.numeric(as.character(domgross)),
         intgross = as.numeric(as.character(intgross)),
         domgross_2013. = as.numeric(as.character(domgross_2013.)),
         intgross_2013. = as.numeric(as.character(intgross_2013.)),
         decade = floor(year/10)*10,
         domprofit_2013 = domgross_2013.*.5,
         intprofit_2013 = intgross_2013.*.4,
         profit_2013 = (domprofit_2013+intprofit_2013)-budget_2013.,
         budget_size_2013 = as.factor(cut(budget_2013.,c(0,1000000,20000000,50000000,100000000,150000000, 500000000),labels=F)),
         ROI = profit_2013/budget_2013.)
```

```{r}
library(dplyr)
summary(movies$profit_2013[which(movies$budget_size_2013==1 & movies$decade==2010)])

movies %>% 
  group_by(budget_size_2013, decade) %>% 
  dplyr::summarize(min_profit = min(profit_2013, na.rm=TRUE),
                   q1_profit = quantile(profit_2013, .25, na.rm=TRUE),
                   med_profit = median(profit_2013, na.rm=TRUE),
                   q3_profit = quantile(profit_2013, .25, na.rm=TRUE),
                   max_profit = max(profit_2013, na.rm=TRUE), 
                   avg_profit = mean(profit_2013, na.rm=TRUE))

movies %>% 
  group_by(budget_size_2013, binary) %>% 
  dplyr::summarize(min_profit = min(profit_2013, na.rm=TRUE),
                   q1_profit = quantile(profit_2013, .25, na.rm=TRUE),
                   med_profit = median(profit_2013, na.rm=TRUE),
                   q3_profit = quantile(profit_2013, .25, na.rm=TRUE),
                   max_profit = max(profit_2013, na.rm=TRUE), 
                   avg_profit = mean(profit_2013, na.rm=TRUE))
```
