##Best Track/Objective Aid/Wind Radii Format##

Common section, fields 1-35, followed by USERDEFINED descriptor and user-data section.  
USERDEFINED sections are not predefined, but examples will be included as they become available.  
Notes on missing and deprecated data at end of sheet.  


BASIN,CY,YYYYMMDDHH,TECHNUM/MIN,TECH,TAU,LatN/S,LonE/W,VMAX,MSLP,TY,RAD,WINDCODE,RAD1,RAD2,RAD3,RAD4,RADP,RRP,MRD,GUSTS,EYE,SUBREGION,MAXSEAS,INITIALS,DIR,SPEED,STORMNAME,DEPTH,SEAS,SEASCODE,SEAS1,SEAS2,SEAS3,SEAS4,USERDEFINED,userdata


BASIN - basin, e.g. WP, IO, SH, CP, EP, AL, SL  
CY - annual cyclone number: 1 through 99  
YYYYMMDDHH - Warning Date-Time-Group: 0000010100 through 9999123123. (note, 4 digit year)  
TECHNUM/MIN - objective technique sorting number, minutes for best track: 00 - 99  
TECH - acronym for each objective technique or CARQ or WRNG, BEST for best track.  
TAU - forecast period: -24 through 240 hours, 0 for best-track, negative taus used for CARQ and WRNG records.  
LatN/S - Latitude (tenths of degrees) for the DTG: 0 through 900, N/S is the hemispheric index.  
LonE/W - Longitude (tenths of degrees) for the DTG: 0 through 1800, E/W is the hemispheric index.   
VMAX - Maximum sustained wind speed in knots: 0 through 300.   
MSLP - Minimum sea level pressure, 1 through 1100 MB.   
TY - Level of tc development:  
- DB - disturbance,   
- TD - tropical depression,   
- TS - tropical storm,  
- TY - typhoon,  
- ST - super typhoon,  
- TC - tropical cyclone,  
- HU - hurricane,  
- SD - subtropical depression,  
- SS - subtropical storm,  
- EX - extratropical systems,  
- IN - inland,  
- DS - dissipating,   
- LO - low,   
- WV - tropical wave,   
- ET - extrapolated,   
- XX - unknown.   

RAD - Wind intensity (kts) for the radii defined in this record: 34, 50, 64.  
WINDCODE - Radius code:  
- AAA - full circle  
- QQQ - quadrant (NNQ, NEQ, EEQ, SEQ, SSQ, SWQ, WWQ, NWQ)  

RAD1 - If full circle, radius of specified wind intensity, If semicircle or quadrant, radius of specified wind  intensity of circle portion specified in radius code. 0 - 1200 nm.  
RAD2 - If full circle this field not used, If semicicle, radius (nm) of specified wind intensity for semicircle not specified in radius code, If quadrant, radius (nm) of specified wind intensity for 2nd quadrant (counting clockwise from quadrant specified in radius code). 0 through 1200 nm.  
RAD3 - If full circle or semicircle this field not used, If quadrant, radius (nm) of specified wind intensity for 3rd quadrant (counting clockwise from quadrant specified in radius code). 0 through 1200 nm.  
RAD4 - If full circle or semicircle this field not used, If quadrant, radius (nm) of specified wind intensity for 4th quadrant (counting clockwise from quadrant specified in radius code). 0 through 1200 nm.  
RADP - pressure in millibars of the last closed isobar, 900 - 1050 mb.  
RRP - radius of the last closed isobar in nm, 0 - 9999 nm.   
MRD - radius of max winds, 0 - 999 nm.  
GUSTS - gusts, 0 through 995 kts.  
EYE - eye diameter, 0 through 999 nm.  
SUBREGION - subregion code: W, A, B, S, P, C, E, L, Q.  
- A - Arabian Sea  
- B - Bay of Bengal  
- C - Central Pacific  
- E - Eastern Pacific  
- L - Atlantic  
- P - South Pacific (135E - 120W)  
- Q - South Atlantic  
- S - South IO (20E - 135E)  
- W - Western Pacific  

MAXSEAS - max seas: 0 through 999 ft.  
INITIALS - Forecaster's initials, used for tau 0 WRNG, up to 3 chars.  
DIR - storm direction in compass coordinates, 0 - 359 degrees.  
SPEED - storm speed, 0 - 999 kts.  
STORMNAME - literal storm name, NONAME or INVEST. TCcyx used pre-1999, where:  
- cy = Annual cyclone number 01 through 99  
- x = Subregion code: W, A, B, S, P, C, E, L, Q.  
- A - Arabian Sea  
- B - Bay of Bengal  
- C - Central Pacific  
- E - Eastern Pacific  
- L - Atlantic  
- P - South Pacific (135E - 120W)  
- Q - South Atlantic  
- S - South IO (20E - 135E)  
- W - Western Pacific 

DEPTH - system depth, D-deep, M-medium, S-shallow, X-unknown  
SEAS - Wave height for radii defined in SEAS1-SEAS4, 0-99 ft.  
SEASCODE - Radius code:  
AAA - full circle  
QQQ - quadrant (NNQ, NEQ, EEQ, SEQ, SSQ, SWQ, WWQ, NWQ)  
SEAS1 - first quadrant seas radius as defined by SEASCODE, 0 through 999 nm.  
SEAS2 - second quadrant seas radius as defined by SEASCODE, 0 through 999 nm.  
SEAS3 - third quadrant seas radius as defined by SEASCODE, 0 through 999 nm.  
SEAS4 - fourth quadrant seas radius as defined by SEASCODE, 0 through 999 nm.  
  
  
USERDEFINED - 20 character description of format to follow.   
user data section as indicated by USERDEFINED parameter.  
  
  
NOTES:  
1) No missing data allowed for first eight common fields. Missing data for other fields are expected to be blank characters between the comma delimeters. Please insure that the proper number of blank characters are included in missing data so that the columns line up. Doing this makes the files much easier to read and troubleshoot.  
2) USERDEFINED section is a section for inclusion of items not already in the common fields. The USERDEFINED parameter is 20 characters, so there should be sufficient space to include some text describing what comes next. Some examples of USERDEFINED and the associated user data will be included as they become available.  
3) Wind records merged in from existing r-decks will be assigned a TECH of CNTR. Wind records created during normal use of the combined abr-deck will be assigned the TECH corresponding to the center name as defined in $ATCFINC/atcfsite.nam.  
4) SEASCODE for other than AAA, NEQ, SEQ, SWQ and NWQ exist in older data, but have been deprecated.  
5) RAD values of 100 exist in old data (earlier than 2005), but have been deprecated.  

