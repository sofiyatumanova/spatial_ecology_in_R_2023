---
title: "MarkdownReport"
author: "Sofiya Tumanova"
date: "2024-01-09"
output: html_document
---

# My first markdown document!

Here you can add some text if you want!

In this case we obtain a result
```{r, eval=T}         # are stating what language we are using (R), and if we want to evaluated it or not (eval = True)
2 + 3                  # when we click knit in R, the code will show in a grey box, and the result will be in a white box below
```
In this case we DO NOT obtain a result    # we don't put the hashtag here because we want this sentence to show up in the document
```{r, eval=F}         
2 + 3                 
```
