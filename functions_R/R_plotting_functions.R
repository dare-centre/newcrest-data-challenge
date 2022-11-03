
###############################################################################
###############################################################################

plot_model_fit <- function(x, y_obs, y_mod, mod_metrics = NULL, title = "") {

  #######
  #file_name <- "plot_age.pdf"
  #pdf(file_name)

  # Generate model fit plot.
  ggplot2::ggplot(data.frame("y_obs" = y_obs, "y_mod" = y_mod),
                  aes(x = y_obs, y = y_mod)) +
    geom_point(shape = 16) +   # medium size, filled round point.

    geom_abline(slope = 1) +
    xlab("Observed") +
    ylab("Modelled") +
    ggplot2::theme(axis.line = ggplot2::element_line(size = 0.4),
                   axis.text = ggplot2::element_text(colour = "black"),
                   axis.ticks = ggplot2::element_line(colour = "black"),
                   legend.position = "none",
                   panel.background = ggplot2::element_rect(fill = "white"),
                   panel.border = ggplot2::element_rect(
                     colour = "black",
                     fill = "transparent"
                   ),
                   panel.grid.major = ggplot2::element_line(
                     size = 0.25,
                     linetype = "dashed",
                     colour = "grey"
                   ),
                   panel.grid.minor = ggplot2::element_line(
                     size = 0.25,
                     linetype = "dashed",
                     colour = "grey"
                   ),
                   text = ggplot2::element_text(family = "CM Roman", size = 10))

  #gridExtra::grid.arrange(grobs = plot_fix_panels(ggplot_HAPO))
  #plot_finalise(file_name)
  ###################


  ## Plot
  #fig, axes = plt.subplots(nrows = 1, ncols = 2, figsize = (14, 5), gridspec_kw = {"width_ratios": [2,3]})
  #ax = axes[0]
  #ax.scatter(y_obs, y_mod, s = 10)

  ## get limits
  #lims = [np.minimum(y_obs.min(), y_mod.min()), np.maximum(y_obs.max(), y_mod.max())]

  ## plot 1:1 line
  #ax.plot(lims, lims, '--', color = "xkcd:bright red", lw = 4)

  ## add text with model performance
  #if (!is.null(mod_metrics)) {
  #  ax.text(
  #    0.95, 0.05,
  #    "R2 = {:.2f}\nRMSE = {:.2f}\nMAE = {:.2f}".format(mod_metrics["r2"], mod_metrics["rmse"], mod_metrics["mae"]),
  #    horizontalalignment = "right", verticalalignment = "bottom",
  #    bbox = dict(edgecolor = "black", facecolor = "white"),
  #    transform = ax.transAxes
  #  )
  #}

  ## set axis limits to be the same
  #ax.set_xlim(lims)
  #ax.set_ylim(lims)

  #ax.set_xlabel("Observed", labelpad = 10)
  #ax.set_ylabel("Modelled", labelpad = 10)
  #ax.set_title(title, pad = 15)

  ## plot the timeseries
  #ax = axes[1]
  #ax.plot(x, y_obs, label = "Observed", color = "xkcd:blue")
  #ax.plot(x, y_mod, label = "Modelled", color = "xkcd:orange")
  #ax.set_xlabel("Date", labelpad = 10)
  #ax.set_ylabel("Value", labelpad = 10)
  ## format the times on the x axis
  #ax.xaxis.set_major_formatter(mdates.DateFormatter("%Y-%m-%d"))
  ## rotate the x axis labels
  #plt.setp(ax.get_xticklabels(), rotation = 45, ha = "right", rotation_mode = "anchor")
  #ax.set_title(paste0("Time series - ", tolower(title)), pad = 15)
  #plt.legend()

  #plt.show()
}

###############################################################################
###############################################################################

