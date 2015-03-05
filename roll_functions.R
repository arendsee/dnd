apply.and.sum <- function(m, func=c()){
    for(f in func){
        m <- f(m)
    }
    if(is.null(dim(m))){
        return(m)
    } else {
        return(rowSums(m))
    }
}

roll <- function(n=4, d=6, k=10, ...){
    s <- sample(1:d, n*k, replace=TRUE)
    m <- matrix(s, ncol=n)
    return(apply.and.sum(m, ...))
}

drop.highest <- function(m){
    m <- apply(m, 1, function(x) x[-which.max(x)])
    if(is.null(dim(m))){
        return(m)
    } else {
        return(t(m))
    }
}

drop.lowest <- function(m){
    m <- apply(m, 1, function(x) x[-which.min(x)])
    if(is.null(dim(m))){
        return(m)
    } else {
        return(t(m))
    }
}

plot.rolls <- function(n=3, d=6, ...){
    require(ggplot2)
    require(gtools)  
    require(gridExtra)
    if(d^n < 1e6){
        m <- permutations(d, n, repeats.allowed=TRUE)
    } else {
        m <- roll(d, n, k=1e6)
    }
    s <- summary(factor(apply.and.sum(m, ...)))
    dat <- data.frame(
    roll.sum=as.numeric(labels(s)),
    probability=s / sum(s))
    g1 <- ggplot(dat) +
    geom_point(
        aes(
            x=roll.sum,
            y=probability
        )
    ) +
    labs(x="Sum of die", y="Probability") +
    theme_bw()
    dat$cumulative <- Reduce('+', dat$probability, accumulate=TRUE)
    g2 <- ggplot(dat) +
        geom_point(
            aes(
                x=roll.sum,
                y=cumulative
            )
        ) +
        labs(x="Sum of die", y="Cumulative Probability") +
        theme_bw()
    grid.arrange(g1, g2)
}
