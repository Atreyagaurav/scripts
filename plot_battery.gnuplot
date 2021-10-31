filename = './data/battery.log'
stats filename using 1:2

set monochrome

set xdata time
set timefmt "%s"
set format x "%Y-%b"
set xtics rotate by 45 offset -4.75,-2.5
set format y "%.02f%%"

set title "Battery degradation"
set xlabel 'Date' offset 0,-2.5
set ylabel '% of original'

f(x) =  b - (x-1.5e9) * a 
b = 74; a = -1e-7
fit f(x) filename via a,b

# set label sprintf("Correlation coeff=%f \nequation: y = %e x+%f",\
#     STATS_correlation,STATS_slope,STATS_intercept\
  #     ) center at graph 0.5, graph 0.9

newCD = 1602072900
set label "New Charger" at newCD,f(newCD) offset 0,1

set label sprintf("%.2f - (x-1.5e9)*%e",b,a) at STATS_mean_x,f(STATS_mean_x) rotate by 0 offset 0,3 textcolor lt 2
# I'd like to calculate the rotate by automatically but since the display is dynamic I have no way to calcuate the degree; maybe the best choice is to make a fixed sized plot, then I can use the x and y scales to calculate the rotation required by annotation. 

plot filename using 1:2 with linespoints title 'Max Power', \
     f(x) with lines title "linear fit" dt 2 lt 2 lw 2

# dt is for dash type,lt is for linetype, though lt doesn't make color different in cad it does in gnuplot
