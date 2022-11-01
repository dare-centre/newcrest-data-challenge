import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.dates as mdates

###############################################################################
###############################################################################

def plot_model_fit(x, y_obs, y_mod, mod_metrics=None,**kwargs):
    # Sort values for plotting by x axis
    sns.set(font_scale=1.2)
    sns.set_style('whitegrid')

    # Plot
    fig, axes = plt.subplots(nrows=1, ncols=2, figsize=(14, 5), gridspec_kw={'width_ratios': [2,3]})
    ax = axes[0]
    ax.scatter(y_obs, y_mod, s=10)

    # get limits
    lims = [np.minimum(y_obs.min(),y_mod.min()), np.maximum(y_obs.max(),y_mod.max())]

    # plot 1:1 line
    ax.plot(lims, lims, '--', color='xkcd:bright red', lw=4)

    # add text with model performance
    if not mod_metrics is None:
        ax.text(
            0.95, 0.05, 
            'R2 = {:.2f}\nRMSE = {:.2f}\nMAE = {:.2f}'.format(mod_metrics['r2'], mod_metrics['rmse'], mod_metrics['mae']),
            horizontalalignment='right', verticalalignment='bottom',
            bbox=dict(edgecolor='black', facecolor='white'),
            transform=ax.transAxes
        )

    # set axis limits to be the same 
    ax.set_xlim(lims)
    ax.set_ylim(lims)

    ax.set_xlabel('Observed', labelpad=10)
    ax.set_ylabel('Modelled', labelpad=10)
    ax.set_title(kwargs.get('title','Model fit'), pad=15)

    # plot the timeseries
    ax = axes[1]
    ax.plot(x, y_obs, label='Observed', color='xkcd:blue')
    ax.plot(x, y_mod, label='Modelled', color='xkcd:orange')
    ax.set_xlabel('Date', labelpad=10)
    ax.set_ylabel('Value', labelpad=10)
    # format the times on the x axis
    ax.xaxis.set_major_formatter(mdates.DateFormatter('%Y-%m-%d'))
    # rotate the x axis labels
    plt.setp(ax.get_xticklabels(), rotation=45, ha="right", rotation_mode="anchor")
    ax.set_title('Time series - {}'.format(kwargs.get('title','Model fit').lower()), pad=15)
    plt.legend()

    plt.show() 

###############################################################################
###############################################################################

