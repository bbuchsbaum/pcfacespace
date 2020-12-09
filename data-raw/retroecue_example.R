library(pcfacespace)

while (TRUE) {
  cf1 <- rnorm(166)
  cf2 <- rnorm(166)
  cr <- cor(cf1,cf2)
  #print(cr)
  if (cr < -.3) {
    break
  }
}

delta <- cf1 - cf2

face1 <-pcfacespace::gen_face(cf1, 1)
face2 <-pcfacespace::gen_face(cf2, 1)

grid.newpage()
plot(pfd_splines(face1), pfd_splines(face2))

## create probe in middle
grid.newpage()
fblend <- (face1 + face2)/2
plot(pfd_splines(fblend))

#fblend2 <- (cf1 + cf2)/2
#grid.newpage()
#plot(pfd_splines(gen_face(fblend2,1)))

delta_cf <- ifelse(cf1-cf2 > 1, .5,-.5)
#delta_cf <- delta_cf/sd(delta_cf)

delta_face1 = pcfacespace::gen_face(delta_cf+cf1,1)
delta_face2 = pcfacespace::gen_face(-delta_cf+cf2,1)
grid.newpage()
plot(pfd_splines(delta_face1), pfd_splines(delta_face2))



grid.newpage()
plot(pfd_splines(face1), pfd_splines(.3*face1 + .7*delta_face1))
grid.newpage()
plot(pfd_splines(face2), pfd_splines(.3*face2 + .7*delta_face2))



# grid.newpage()
# plot(pfd_splines(face1 + .4*delta_face), pfd_splines(face1))
# grid.newpage()
# plot(pfd_splines(face2 - .4*delta_face), pfd_splines(face2))

