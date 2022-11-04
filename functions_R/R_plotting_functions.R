
library(ggplot2)

###############################################################################
###############################################################################

plot_model_fit <- function(x, y_obs, y_mod, mod_metrics = NULL, title = "") {

  # Generate model fit plot.
  ggplot(data.frame("y_obs" = y_obs, "y_mod" = y_mod),
                  aes(x = y_obs, y = y_mod)) +
    geom_point(shape = 16) +   # medium size, filled round point.
    geom_abline(slope = 1) +
    xlab("Observed") +
    ylab("Modelled") +
    theme_dare()
}

###############################################################################
###############################################################################

theme_dare <- function() {

  # Ensure required fonts are available.
  #stopifnot(validate_ghostscript_paths())
  extrafont::loadfonts(quiet = TRUE)

  theme(axis.line = element_line(size = 0.4),
        axis.text = element_text(colour = "black"),
        axis.ticks = element_line(colour = "black"),
        legend.position = "none",
        panel.background = element_rect(fill = "white"),
        panel.border = element_rect(
           colour = "black",
           fill = "transparent"
        ),
        panel.grid.major = element_line(
           size = 0.25,
           linetype = "dashed",
           colour = "grey"
        ),
        panel.grid.minor = element_line(
           size = 0.25,
           linetype = "dashed",
           colour = "grey"
        ),
        text = element_text(family = "CM Roman", size = 10))
}

###############################################################################
###############################################################################
