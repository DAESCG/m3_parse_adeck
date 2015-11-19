# plot_joaquin_track.py
"""
Plots track and intensity forecast data associated with TC Joaquin
"""
#---------------
# Import modules
#---------------
import sys
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

#-----------
# Parameters
#-----------

#----------
# Load data
#----------
f = './storm_data.csv'
storm_data = pd.read_csv(f, index_col=0)

#------------------------------------------------
# Extract needed data (Tau, VMax, LatN/S, LonE/W)
#------------------------------------------------
plot_data = storm_data[['Tau', 'VMax', 'LatN/S', 'LonE/W']]

#------------------------------------------------------
# Indexes to transform lat/lon coordinates for plotting
#------------------------------------------------------
south_index = plot_data['LatN/S'].str[-1].isin(['S'])
west_index  = plot_data['LonE/W'].str[-1].isin(['W'])

#--------------------------------------------------------------------------
# Remove the pesky hemisphere characters (e.g., N/S/E/W) from lats and lons
#--------------------------------------------------------------------------
plot_data['LatN/S'] = plot_data['LatN/S'].str.replace('N|S', '')
plot_data['LonE/W'] = plot_data['LonE/W'].str.replace('E|W', '')

#-------------------------------------------------
# Convert Lats and Lons to floats and divide by 10
#-------------------------------------------------
plot_data['LatN/S'] = plot_data['LatN/S'].astype(float) / 10
plot_data['LonE/W'] = plot_data['LonE/W'].astype(float) / 10

#-----------------------------------
# Transform coordinates for plotting
#-----------------------------------
plot_data['LatN/S'][south_index]    = -plot_data['LatN/S'][south_index]
plot_data['LonE/W'][west_index]     = 360 - plot_data['LonE/W'][west_index]

#---------------------------------------------
# Drop duplicate values along the 'Tau' column
#---------------------------------------------
plot_data = plot_data.drop_duplicates(subset=['Tau'])

#------------------
# Initialize figure
#------------------
fig = plt.figure(figsize=(11.5, 8))

#--------------
# Draw max axis
#--------------
m = Basemap(projection='lcc', llcrnrlon=360-90, llcrnrlat=10, urcrnrlon=30,
    urcrnrlat=50, lat_0=30, lon_0=360-60, resolution='l')

#----------------
# Draw boundaries
#----------------
m.drawcoastlines()
m.fillcontinents(color='0.8', zorder=0)
m.drawcountries()

#--------------------------------------------------------
# Draw meridians and parallels [left, right, top, bottom]
#--------------------------------------------------------
m.drawmeridians(np.arange(0, 361 ,10), color='0.5',
    dashes=(None, None), labels=[False, False, True, True],
    fontsize=8, fontweight='bold', zorder=4)
m.drawparallels(np.arange(-90, 91, 10), color='0.5',
    dashes=(None, None), labels=[True, True, False, False],
    fontsize=8, fontweight='bold', zorder=4)

#----------------------------
# Plot track | Loop over time
#----------------------------
strengths   = [0, 64, 83, 96, 113, 137]
colors      = ['#fed976',
               '#c7e9b4',
               '#7fcdbb',
               '#41b6c4',
               '#2c7fb8',
               '#253494']

for t in xrange(plot_data['Tau'].values.size):

    print "Forecast hour: " + str(plot_data['Tau'].iloc[t])

    #-----------------------------
    # Temp position/wind variables
    #-----------------------------
    v_max = plot_data['VMax'].iloc[t]
    lat_0 = plot_data['LatN/S'].iloc[t]
    lon_0 = plot_data['LonE/W'].iloc[t]

    #-------------------
    # Temp line segments
    #-------------------
    if t < plot_data['Tau'].values.size-1:
        lat_1 = [plot_data['LatN/S'].iloc[t],
                 plot_data['LatN/S'].iloc[t+1]]
        lon_1 = [plot_data['LonE/W'].iloc[t],
                 plot_data['LonE/W'].iloc[t+1]]

    #------------------------------------------
    # Transform position variables for plotting
    #------------------------------------------
    x, y = m(lon_0, lat_0)
    xx, yy = m(lon_1, lat_1)

    #---------
    # Color ID
    #---------
    c = np.digitize([v_max], strengths)-1

    #-----
    # Plot
    #-----
    m.plot(xx, yy, color=colors[c], linewidth=3, zorder=3)
    m.scatter(x, y, s=40, marker='o', facecolor=colors[c],
        edgecolors='k', lw=1, zorder=5)

#------
# Title
#------
plt.title('TC Joaquin 180-hour GFS Op. Forecast | ' + \
    'Init. 0000 UTC, 2 October 2015', fontsize=13, fontweight='bold',
    y=1.05)

#----------------------
# Manually build legend
#----------------------
p1 = plt.scatter([], [], s=40, facecolor='#fed976', edgecolors='k')
p2 = plt.scatter([], [], s=40, facecolor='#c7e9b4', edgecolors='k')
p3 = plt.scatter([], [], s=40, facecolor='#7fcdbb', edgecolors='k')
p4 = plt.scatter([], [], s=40, facecolor='#41b6c4', edgecolors='k')
p5 = plt.scatter([], [], s=40, facecolor='#2c7fb8', edgecolors='k')
p6 = plt.scatter([], [], s=40, facecolor='#253494', edgecolors='k')

labels = ['< 64 kt',
          '64-82 kt [Cat 1]',
          '83-95 kt [Cat 2]',
          '96-112 kt [Cat 3]',
          '113-136 kt [Cat 4]',
          '> 137 kt [Cat 5]']

L = plt.legend([p1, p2, p3, p4, p5, p6], labels, ncol=1, frameon=True,
    fontsize=10, loc=2, scatterpoints=1)

#-----------------------
# Write and close figure
#-----------------------
f = './gfs_op_joaquin_track.png'
plt.savefig(f, bbox_inches='tight')

plt.close()
