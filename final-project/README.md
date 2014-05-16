Final Project
==============================

| **Name**  | Anuj Saxena  |
|----------:|:-------------|
| **Email** | asaxena2@dons.usfca.edu |

## Discussion ##

Hello, welcome to the repository of my final data visualization project. Kindly make sure to install the following packages:

```
library(shiny)
library(ggplot2)
library(maps)
library(stringr)
library(gridExtra)
```

Thank you!

To view my shiny app, run the following code in R.

```
shiny::runGitHub('msan622', 'anujsaxenaa', subdir='final-project')
```

##Overview
The dataset that I used for my final project is of Meteorite Landings provided for free online by the Meteoritical Society. Over the past decade, this field has received major international attention. It has even been said that meteorite landings have become more common in recent years and scientist all over the world are eager to learn what mysteries of the universe in presented on their doorstep. Billions of dollars of fundings is being put into action by space research associations of all major countries such as USA, Russia, France etc. With this in mind, this dataset provides us with interesting insights as to how the history of meteorite landings has happened on earth. 

To add to that, this dataset has been acclaimed to be a terrific prototype for a cool data visualization exercise.  
And being the spatially intelligent dominant person that I am, I was fascinated by the prospects of this dataset. I initially did not have any concrete plan of actions for going about this task, but I was motivated nonetheless. Visualizing.org also hosted a visualization competition on this dataset. Even though competitors used fancy javascript skills, I planned to use the power of R, ggplot2, shiny to the max. For more information, visit the following link :- http://www.visualizing.org/contests/visualizing-meteorites

I found that my data was heavily negatively skewed. i.e. I had more meteorite landings in recent years than in earlier years. Hence I 
## 1. History of Meteorite Landings##

Techniques:

The first thought that came to my mind was pretty obvious. I wanted to visualize how the meteorites landed on earth. This was easier said than done as I faced many issues that made me compromise on my idea. 
For achieving the most, I used the combination of ```time series``` and ```geospatial mapping``` techniques. 
These two techniques were helpful and were the main basis of my visualization. 


Interactivity:
For interactivity, I used the ```sliderInput``` function of ```shinyUI```. I implemented the ```animate``` function that enables me to automatically see the changes in my map over time. I looked at the changes happening on a decade level by setting the ```step``` as 10 years. 

   

## 2. 

## 3. Looking at Each Country

## 4. Country-level statistics 

