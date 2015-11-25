begin

;;;read in file
all_lines = asciiread("/nfs/al11/rsteeves/CG_Meetings/M3/m3_parse_adeck/aal112015.dat",-1,"string")

basin = str_get_cols(all_lines,0,1)
dates = str_get_cols(all_lines,8,17)
model_code = str_get_cols(all_lines,24,27) 
lon = str_get_cols(all_lines,40,44) 
lat = str_get_cols(all_lines,35,37) 

storms = ind((basin.eq."AL").and.(dates.eq."2015100200").and.(model_code.eq."AVNO"))
entries = (all_lines(storms))



lat_storms = stringtodouble(lat(storms))/10
lon_storms = stringtodouble(lon(storms))/(-10)

print(lat_storms)
print(lon_storms)





;*******************************************************

name = "trackmap"

print(" ")
print("Lat/Lons successfully collected from file")

;==============================================
; Create Shaded Map
;==============================================
wks_type = "png"

wks_type@wkWidth = 2500
wks_type@wkHeight = 2500

wks = gsn_open_wks(wks_type,name)
gsn_define_colormap(wks,"alicia")
;**********************************************

res = True

res@gsnFrame = False                                             ;DO NOT PLOT FIRST MAP
res@gsnDraw = False

res@tiMainString = " "    ; Specify Title
res@tiMainJust = "CenterCenter"
res@tiMainPosition = "Center" 
res@tiMainOffsetYF = -0.03
res@tiXAxisFontHeightF = .015
res@gsnLeftString = " "
res@gsnLeftStringOrthogonalPosF = .014
res@gsnRightString =" "
res@gsnRightStringOrthogonalPosF = .011
res@gsnStringFontHeightF = .013

res@mpFillOn = True
res@mpLandFillColor = "gray84"
res@mpInlandWaterFillColor = "white"
res@mpOceanFillColor = "lightskyblue1"
res@mpInlandWaterFillColor = "lightskyblue1"
res@mpDataBaseVersion = "MediumRes"                              ; Country Outlines
res@mpDataSetName = "Earth..4"
res@mpOutlineBoundarySets = "National"
res@mpOutlineSpecifiers = (/"United States"/)+" : States"
res@mpOutlineOn = True
res@mpGeophysicalLineColor = "grey40"
res@mpNationalLineColor = "grey40"
res@mpUSStateLineColor = "grey40"
res@mpGeophysicalLineThicknessF = 5
res@mpNationalLineThicknessF = 5
res@mpUSStateLineThicknessF = 5

res@mpProjection = "CylindricalEquidistant"
res@mpMinLatF = 10
res@mpMaxLatF = 60
res@mpMinLonF = -90
res@mpMaxLonF = -10

res@mpGridAndLimbOn        = True
res@mpGridLineDashPattern  = 5                  ; lat/lon lines dashed
res@mpGridLatSpacingF      = 10
res@mpGridLonSpacingF      = 10
res@mpGridLineColor = "grey25"
res@mpGridLineThicknessF = 3

res@tmXBOn = True
res@tmXBLabelsOn = True
res@tmXBMode = "Explicit" 
res@tmXBValues = ispan(-140,-20,10)
res@tmXBLabels = (/"140~F34~0~F~W","130~F34~0~F~W","120~F34~0~F~W","110~F34~0~F~W","100~F34~0~F~W","90~F34~0~F~W","80~F34~0~F~W","70~F34~0~F~W","60~F34~0~F~W","50~F34~0~F~W","40~F34~0~F~W","30~F34~0~F~W","20~F34~0~F~W"/)
res@tmXBLabelFontHeightF = .011
res@tmXBMajorLengthF = .01
res@tmXBMinorLengthF = .006
res@tmXBMinorValues = (/-115.0,-105.0,-95.0,-85.0,-75.0,-65.0,-55.0,-45.0,-35.0/)

res@tmYLOn = True
res@tmYLLabelsOn = True
res@tmYLMode = "Explicit" 
res@tmYLValues = ispan(10,60,10)
res@tmYLLabels = (/"10~F34~0~F~N","20~F34~0~F~N","30~F34~0~F~N","40~F34~0~F~N","50~F34~0~F~N","60~F34~0~F~N"/)
res@tmYLLabelFontHeightF = .011
;res@tmYLMinorValues = (/32.5,37.5,42.5,47.5,52.5,57.5/)

res@tmYROn = False
res@tmXTOn = False


;********************************************
res@mpFillDrawOrder = "Draw"
res@mpOutlineDrawOrder = "Draw"
res@mpGridAndLimbDrawOrder = "PostDraw"

plot = gsn_csm_map(wks,res)        ; Plot map

;********************************************

print(" ")
print("Drawing track lines")

lres = True
lres@gsLineColor = "black"    ; Filled color
lres@gsLineThicknessF = 12

line = new(dimsizes(lat_storms),graphic)

l_lat = new(dimsizes(lat_storms),double,0)
l_lon = new(dimsizes(lat_storms),double,0)

count = 0

do i=0,dimsizes(lat_storms)-2
		count = count + 1
       	l_lat(i) = lat_storms(i)
       	l_lon(i) = lon_storms(i)
       	l_lat(i+1) = lat_storms(i+1)
       	l_lon(i+1) = lon_storms(i+1) 
       	 
       	l_lat_plot = (/l_lat(i),l_lat(i+1)/)
       	l_lon_plot = (/l_lon(i),l_lon(i+1)/)
       	line(count-1) = gsn_add_polyline(wks,plot,l_lon_plot,l_lat_plot,lres)
end do

;print(line)

;********************************************
print(" ")
print("Drawing positions")

mk1res = True
mk1res@gsMarkerIndex = 16    ; Filled color
mk1res@gsMarkerSizeF = 0.008

dot1 = new(dimsizes(lat_storms),graphic)
out1 = new(dimsizes(lat_storms),graphic)

I_lat1 = new(dimsizes(lat_storms),double,0)
I_lon1 = new(dimsizes(lat_storms),double,0)

count = 0
I_num1 = 0

do i=0,dimsizes(lat_storms)-1
	   	count = count + 1
       	I_lat1(I_num1) = lat_storms(i)
       	I_lon1(I_num1) = lon_storms(i)        
       	mk1res@gsMarkerColor = "black"
       	mk1res@gsMarkerIndex = 16 
       	mk1res@gsMarkerThicknessF = 1
		mk1res@gsMarkerColor = "black"
       dot1(count-1) = gsn_add_polymarker(wks,plot,lon_storms(i),lat_storms(i),mk1res)
       	mk1res@gsMarkerColor = "black"
       	mk1res@gsMarkerIndex = 4
       	mk1res@gsMarkerThicknessF = 6
       out1(count-1) = gsn_add_polymarker(wks,plot,lon_storms(i),lat_storms(i),mk1res)
       	I_num1 = I_num1 + 1
end do

;********************************************

draw(plot)
frame(wks)

;********************************************

system("convert -trim "+name+".png "+name+".png")
;system ("mv "+name+".png "+dir_out+name+".png")

print(" ")
print("**************")
print(" END SCRIPT ")
print("**************")
print(" ")

end