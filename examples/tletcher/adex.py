import netCDF4
import numpy as np
import scipy
import scipy.stats as stats
import datetime 
import glob
import sys
import matplotlib.pyplot as plt
import pylab as P 
from mpl_toolkits.basemap import Basemap, cm
import matplotlib.dates as dates
import time
import matplotlib.colors as mcolors
import scipy.ndimage
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.patches import Rectangle
from matplotlib.colors import LinearSegmentedColormap

#BASIN,CY,YYYYMMDDHH,TECHNUM/MIN,TECH,TAU,LatN/S,LonE/W,VMAX,MSLP,TY,RAD,WINDCODE, RAD1,RAD2,RAD3,RAD4,
#RADP,RRP,MRD,GUSTS,EYE,SUBREGION,MAXSEAS,INITIALS,DIR,SPEED,
#STORMNAME,DEPTH,SEAS,SEASCODE,SEAS1,SEAS2,SEAS3,SEAS4,USERDEFINED,userdata

#AL, 11, 2015092600, 03, BAMS,  12, 257N,  689W,   0,    0,   ,   0,    ,    0,    0,    0,    0,

lon_dict={'W':-1,'E':1}
lat_dict={'S':-1,'N':1}

def get_adex(apath,tcol=4,mod='AVNO',name='JOAQUIN',init='2015100200'):
    with open(apath) as f:
        content=f.readlines()
    filtered=[]
    for l in content:
        lsplit=l.split(',')
        if lsplit[tcol].strip() != mod:
            continue
        else:
            filtered.append(l)
        
    # Okay, Data is Filtered! ###
    ## Now go back through and get necessary stuff! ###
    lats=[]
    lons=[]
    Vmax=[]
    
    for l in filtered:
            if init in l:
                lsplit=l.split(',')
                lat_raw=lsplit[6].strip()
                lat_fixed=float(lat_raw[0:-1])/10.*lat_dict[lat_raw[-1]]
                lon_raw=lsplit[7].strip()
                lon_fixed=float(lon_raw[0:-1])/10.*lon_dict[lon_raw[-1]]
                VV=float(lsplit[8].strip())
                
                lats.append(lat_fixed);lons.append(lon_fixed);Vmax.append(VV*2.23694)
            else:
                continue
            
    return lats, lons,Vmax

adex_path='/Users/tletcher/Documents/DAES_COMPUTER/m3_parse_adeck/aal112015.dat'

xlat,xlon,vmax=get_adex(adex_path)

lat_lims=[15,57]
lon_lims=[-87,-5]

fig=plt.figure(figsize=(10,10))
m = Basemap(llcrnrlon=lon_lims[0],llcrnrlat=lat_lims[0],urcrnrlon=lon_lims[1],urcrnrlat=lat_lims[1],
            projection='lcc',lat_1=20.,lat_2=40.,lon_0=-60.,
            resolution ='l',area_thresh=1000.)
m.drawstates()
x, y = m(xlon, xlat) # compute map proj coordinates.
m.drawcoastlines()
m.drawcountries()
m.drawmapboundary(fill_color='#99ffff')
m.fillcontinents(color='#cc9966',lake_color='#99ffff')
m.drawparallels(np.arange(10,70,5),labels=[1,0,0,0],rotation=20)
m.drawmeridians(np.arange(-100,0,5),labels=[0,0,0,1],rotation=20)
plt.title('Joaquin Phoenix')
#m.etopo()
m.plot(x,y,color='teal',lw=2.)
im=m.scatter(x,y,c=vmax,cmap='jet',zorder=10.)

fig.subplots_adjust(right=0.88)
cbar_ax = fig.add_axes([0.90, 0.2, 0.02, 0.6])
cbar=fig.colorbar(im, cax=cbar_ax)
cbar.set_label("Max Windspeed [mph]")


plt.show()

sys.exit()
