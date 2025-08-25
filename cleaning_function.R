library(tidyverse)
library(MASS)
library(Spectra)
library(dplyr)
library(stats)

cleaning_ref<- function(ms2){
  ms2_tb <- as.data.frame(
    spectraData(sps) 
  ) %>%
    mutate( ms2_raw = mapply(cbind, mz(ms2), intensity(ms2), SIMPLIFY = FALSE)) %>%
    mutate(ms2_raw = map(ms2_raw, function(t){
      colnames(t) <- c("mz", "intensity")
      t %>%
        as.data.frame() %>%
        mutate(mz = as.numeric(mz)) %>%
        mutate(intensity = as.numeric(intensity))
    })) %>%
    mutate(ms2_RLM = map(ms2_raw, function(t){
      t <- t %>%
        filter(intensity>0) %>%
        arrange(intensity) %>%
        mutate(order = seq(nrow(.)))
      p75 <- t %>%
        pull(intensity) %>% 
        quantile(0.75)
      u <- t %>%
        filter(intensity < p75)
      if(nrow(u)>3){
        mdl <- rlm(data = u, log10(intensity) ~ order)
        t_filt<- t %>% 
          mutate(pred = predict(mdl, t)) %>%
          mutate(res = abs(pred - log10(intensity))) %>%
          filter(res > sd(residuals(mdl))*3) %>%
          arrange(mz)
        if (nrow(t_filt) > 0) {
          t<- t_filt
        } else {
          t<- t %>% arrange(mz)
        }
      } else {
        return(t %>% arrange(mz))  # Not enough points to model
      }
    }))
  ms2_cl <- ms2_tb %>%
    mutate(
      mz = map(ms2_RLM, ~ .x$mz),
      intensity = map(ms2_RLM, ~ .x$intensity)
    ) %>%
    filter(map_lgl(mz, ~ length(.x) > 0)) %>%
    as.data.frame() %>%
    Spectra()
  return(ms2_cl)
}