
  ;************************************************
  ;     plot_joaquin_track.ncl
  ;
  ;     Author: Philippe Papin
  ;		Date: 11-19-15
  ;		
  ;    
  ;*************************************************
; there is a better way to do this ---> 
;
; php setup
; 
; pass variables into a script::::: curl -s --data "date=2015100200&tech=AVNO&id=aal11"

  ;***********************SCRIPTS*******************

  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
  load "$NCARG_ROOT/lib/ncarg/nclscripts/contrib/cd_string.ncl"
  load "/lb11/ppapin/ncl/ibtracs/ibtracs_track_overlay.ncl"
  load "/nfs/lb13/ppapin/scripts/ncl/misc/shea_util.ncl"
  load "/nfs/lb13/ppapin/scripts/ncl/hrrr/plot_hrrr_ncep_maps.ncl"
  load "/nfs/lb13/ppapin/scripts/ncl/ibtracs/ibtracs_track_name_overlay_ppt.ncl"
  load "/nfs/lb13/ppapin/scripts/ncl/gyre/shear_vort/uv2cvF_Wrap.ncl"
  load "/nfs/lb13/ppapin/scripts/ncl/misc/skewt_edit.ncl"

  ;***********************SCRIPTS******************* 
 
 begin

  err = NhlGetErrorObjectId()
  setvalues err
    "errLevel" : "Fatal"          ; only report Fatal errors
  end setvalues

  opt = True
   
  begTime_tot = get_cpu_time()  

  ;obtain the file
  
  data_in = "/nfs/lb13/ppapin/images/daes_cg/m3_parse_adeck/"
  plotname = "gfs_joaquin"
  imgoutdir = "/nfs/lb13/ppapin/images/daes_cg/m3_parse_adeck/"
  imgcount = 1

  joaquin_tracks = asciiread(data_in+"aal112015.dat",-1,"string")
  delim = ", "
  nfilds = str_fields_count(joaquin_tracks(0), delim)
  
  ;;;; okay lets get the one tcg pathway letter
  
  time = str_get_field(joaquin_tracks, 3, delim)
  lat = str_get_field(joaquin_tracks, 7, delim)
  lon = str_get_field(joaquin_tracks, 8, delim)
  model_type = str_get_field(joaquin_tracks, 5, delim)
  wind = str_get_field(joaquin_tracks,9,delim)
  radii = str_get_field(joaquin_tracks,12,delim)

  ;;;; now that we have done that, lets find a way to discriminate
  ;;;; pick a model, pick a time and pick a radii
  
  gfs_ind = ind(model_type .eq. "AVNO" .and. time .eq. "2015100200" .and. radii .eq. "34") 
  gfs_lat = tofloat(lat(gfs_ind))
  gfs_lon = tofloat(lon(gfs_ind))
  gfs_wind = tofloat(wind(gfs_ind))
  gfs_time = toint(time(gfs_ind))
  gfs_radii = tofloat(radii(gfs_ind))
  
;;;; fix lat and lon to coordinates we can use!!!

  gfs_lat = gfs_lat / 10
  gfs_lon = (gfs_lon / 10) * -1

  print(gfs_lat)
  print(gfs_lon)
  
;;;; plot the data ;;;
;;;;

  wks_type = "png"
  wks_type@wkWidth = 1536
  wks_type@wkHeight = 1536
  wks = gsn_open_wks(wks_type,plotname)
;;;;;;

  eres = True
  eres@gsnDraw   = False
  eres@gsnFrame  = False
  eres@gsnLeftString = ""
  eres@gsnRightString = ""
  mpres = eres
  eres@gsnAddCyclic = False

  mpres@mpDataBaseVersion           = "MediumRes"
  mpres@mpDataSetName               = "Earth..4"
  mpres@mpGeophysicalLineColor      = "black"
  mpres@mpGeophysicalLineThicknessF = 3.0 
  mpres@mpGridAndLimbOn             = True
  mpres@mpGridLatSpacingF           = 20
  mpres@mpGridLonSpacingF           = 20
  mpres@gsnMajorLatSpacing          = mpres@mpGridLatSpacingF
  mpres@gsnMajorLonSpacing          = mpres@mpGridLonSpacingF
  mpres@mpGridLineColor             = "gray20"
  mpres@mpGridLineThicknessF        = 2.0
  mpres@mpGridLineDashPattern       = 10.
  mpres@mpNationalLineColor         = mpres@mpGeophysicalLineColor
  mpres@mpUSStateLineColor          = mpres@mpGeophysicalLineColor
  mpres@mpOutlineSpecifiers = (/"United States", "Mexico", "Canada"/)+" : States"
  mpres@mpNationalLineThicknessF = 3.5
  mpres@mpOutlineBoundarySets       = "National"
  mpres@mpOutlineOn                 = True
  mpres@mpUSStateLineColor          = mpres@mpGeophysicalLineColor
  mpres@tmXBLabelFontHeightF        = .01
  mpres@mpGridAndLimbDrawOrder = "Predraw"

  mpres@mpLabelsOn             = False
  mpres@mpPerimOn              = True
  mpres@mpFillOn               = True
  mpres@mpOutlineOn            = True
  mpres@mpLandFillColor        =  "gray"
  mpres@mpOceanFillColor       =  "paleturquoise"
  mpres@mpInlandWaterFillColor       =  "paleturquoise"
  mpres@mpOutlineDrawOrder     = "PostDraw"
  mpres@mpFillDrawOrder        = "PreDraw"
  mpres@mpLimitMode            = "LatLon"


mpres@mpMinLatF = 10.
mpres@mpMaxLatF = 60.
mpres@mpMinLonF = -80.
mpres@mpMaxLonF = -10.


;  mpres@mpCenterLatF           = centerlat ; Activating this turns the map into a curved projection
  mpres@tiMainOn               = False
  ;mpres@gsnRightString         = (levs_wind(0)/100)+"-"+(levs_wind(dimsizes(levs_wind)-1)/100)+" hPa Mean Wind Speed, PV and Irr. Wind, PW, MSLP"
  ;mpres@gsnRightString         = "925 hPa Heights, Winds, Relative Humidity, Temperature"
  mpres@gsnRightStringFontHeightF    = 0.009
  mpres@gsnLeftStringFontHeightF = 0.009


mpres@tmXBMinorOn = False
mpres@tmYLMinorOn = False
mpres@tmXTOn = False
mpres@tmYROn = False
mpres@tmXBLabelFontHeightF        = .015
mpres@tmYLLabelFontHeightF        = .015
mpres@gsnMajorLatSpacing          = mpres@mpGridLatSpacingF
mpres@gsnMajorLonSpacing          = mpres@mpGridLonSpacingF

;;;; plot map

;;; plot
mpid = gsn_csm_map(wks,mpres)

;;;;  
  
;;;; plot position and track of NHC Forecast

  cent_res = True
  cent_res@gsMarkerSizeF = 0.05
  cent_res@gsMarkerIndex = 1
  cent_res@gsMarkerColor = "black"
  cent_res@gsMarkerThicknessF = 3.0  cent_res@gsLineColor = "black"
  cent_res@gsLineThicknessF = 20.0

  cent_res2 = True
  cent_res2@gsMarkerSizeF = 0.04
  cent_res2@gsMarkerIndex = 1
  cent_res2@gsMarkerColor = "red"
  cent_res2@gsMarkerThicknessF = 3.0  
  cent_res2@gsLineColor = "red"
  cent_res2@gsLineThicknessF = 10.0

  ;;;;; I will read this in as a set of lat/lon points
  ;;; create a line that connects these points

line1 = gsn_add_polyline(wks,mpid,gfs_lon(::2),gfs_lat(::2),cent_res)

line2 = gsn_add_polyline(wks,mpid,gfs_lon(::2),gfs_lat(::2),cent_res2)

;;;; create track markers

print(gfs_lon(::2))

cent1 = gsn_add_polymarker(wks,mpid,gfs_lon(::4),gfs_lat(::4),cent_res)
cent2 = gsn_add_polymarker(wks,mpid,gfs_lon(::4),gfs_lat(::4),cent_res2)

;  maximize_output(wks,True)
draw(mpid)
frame(wks)
 
;  system("convert -trim "+plotname+".png "+plotname+"_"+imgcount+".png")
;  system("mv "+plotname+"_"+imgcount+".png "+imgoutdir)
  
  end