library(pcfacespace)
library(grid)

while (TRUE) {
  cf1 <- rnorm(166)
  cf2 <- rnorm(166)
  cf2 <- scale((.4*cf1 + .6*cf2))[,1]
  cr <- cor(cf1,cf2)
  print(cr)
  if (cr > .5) {
    break
  }
}



delta <- cf1 - cf2

face1 <-pcfacespace::gen_face(cf1, 1)
face2 <-pcfacespace::gen_face(cf2, 1)

grid.newpage()
plot(pfd_splines(face1), pfd_splines(face2))

gen_blend <- function(cf1, cf2, wt1=.5, genetic=FALSE, rescale=TRUE) {
  blendcf <- if (genetic) {
    idx <- sort(sample(1:length(cf1), as.integer(length(cf1) * wt1)))
    keep <- logical(length(cf1))
    keep[idx] <- TRUE
    ifelse(keep, cf1, cf2)
  } else {
    (wt1*cf1 + (1-wt1)*cf2)
  }

  gen_face(scale(blendcf)[,1],1)
}

## create probe in middle
grid.newpage()

multiplot(list(pfd_splines(face1,.8), pfd_splines(face2,.8),
          pfd_splines(gen_blend(cf1,cf2, wt1=.5),.8), pfd_splines(gen_blend(cf1,cf2, wt1=.5, genetic=TRUE),.8)),
          nrow=2, ncol=2)

delta_cf <- cf1-cf2
#delta_cf <- ifelse(delta_cf > 0, delta_cf/max(delta_cf), delta_cf/abs(min(delta_cf)))
#delta_cf <- ifelse(delta_cf > 0, delta_cf^2, -(abs(delta_cf)^2))
#delta_cf <- delta_cf/sqrt(abs(delta_cf))

delta_face1 = pcfacespace::gen_face(.5*delta_cf + cf1,1)
delta_face2 = pcfacespace::gen_face(-.5*delta_cf + cf2,1)

grid.newpage()
#plot(pfd_splines(delta_face1), pfd_splines(delta_face2))

multiplot(list(
  pfd_splines(face1),
  pfd_splines(face2),
  pfd_splines(delta_face1),
  pfd_splines(delta_face2)), nrow=2, ncol=2)




grid.newpage()
plot(pfd_splines(face1), pfd_splines(.3*face1 + .7*delta_face1))
grid.newpage()
plot(pfd_splines(face2), pfd_splines(.3*face2 + .7*delta_face2))



# grid.newpage()
# plot(pfd_splines(face1 + .4*delta_face), pfd_splines(face1))
# grid.newpage()
# plot(pfd_splines(face2 - .4*delta_face), pfd_splines(face2))

