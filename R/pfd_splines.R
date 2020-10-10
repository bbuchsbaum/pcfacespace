

#' @export
plot.face_spline <- function(x, y, ...) {

  if (!missing(y)) {
    vp1 <- viewport(x = unit(.25, "npc"), y=unit(.5, "npc"), width=unit(.5, "npc"), height=unit(.75, "npc"),
                   xscale = c(-2, 4), yscale=c(-4.5,3.66), default.units="native")

    vp2 <- viewport(x = unit(.75, "npc"), y=unit(.5, "npc"), width=unit(.5, "npc"), height=unit(.75, "npc"),
                    xscale = c(-2, 4), yscale=c(-4.5,3.66), default.units="native")

    pushViewport(vp1)
    grid.draw(x$grob)
    upViewport()
    pushViewport(vp2)
    grid.draw(y$grob)

  } else {
    vp <- viewport(width=unit(1, "npc"), height=unit(1, "npc"),
                 xscale = c(-2, 4), yscale=c(-4.5,3.66), default.units="native")

    pushViewport(vp)
    grid.draw(x$grob)
  }

}

#' convert face coordinates to a drawable shape
#'
#' @export
#' @param face an 85 x 2 matrix of face coordinates
#' @param spline_shape 1 for cubic spline, -1 for Catmull-Rom splines, 0 for polygons
#' @retun an instance of class \code{face_spline}
pfd_splines <- function(face, spline_shape=1) {

  points_outline <- face[1:16, ]
  points_r_eyebrow <- face[17:23, ]
  points_l_eyebrow <- face[24:30, ]
  points_r_eye <- face[31:37, ]
  points_l_eye <- face[38:44, ]
  points_r_eyelid <- face[45:47, ]
  points_l_eyelid <- face[48:50, ]
  points_r_undereye <- face[51:53, ]
  points_l_undereye <- face[54:56, ]
  points_nose_bridge <- face[57:62, ]
  points_nose_tip <- face[63:65, ]
  points_nostrils <- face[66:71, ]
  points_mouth <- face[72:85, ]

  npts_outline = 16
  npts_r_eyebrow = 7
  npts_l_eyebrow = 7
  npts_r_eye = 7
  npts_l_eye = 7
  npts_r_eyelid = 3
  npts_l_eyelid = 3
  npts_r_undereye = 3
  npts_l_undereye = 3
  npts_nose_bridge = 6
  npts_nose_tip = 3
  npts_nostrils = 6
  npts_mouth = 14


  color_bkgd = c(.8, .8, .8)
  color_iris = c(.8, .8, .8)
  outline_color = c(0, 0, 0)
  fill_color = c(.4, .4, .4)


  gen_grob <- function(outline, npts, fillcol=NULL, open=FALSE, linecol="black", shape=spline_shape, lwd=2) {
    #t1a = n1:n2

    #z1a = cbind(pout[n1:n2,1], pout[n1:n2,2])
    z1a <- outline
    gg <- if (is.null(fillcol)) {
      if (nrow(z1a) < 3) {
        linesGrob(z1a[,1],-z1a[,2], default.units="native", gp=gpar( col=linecol, lwd=lwd))
      } else {
        xsplineGrob(z1a[,1],-z1a[,2], default.units="native", open=open, shape=shape,
                      gp=gpar( col=linecol, lwd=lwd))
      }
    } else {
      if (nrow(z1a) < 3) {
        linesGrob(z1a[,1],-z1a[,2], default.units="native", gp=gpar(fill=fillcol, col=linecol, lwd=lwd))
      } else {
        xsplineGrob(z1a[,1],-z1a[,2], default.units="native", open=open, shape=shape,
                  gp=gpar(fill=fillcol, col=linecol, lwd=lwd))
      }
    }

    ##grid.draw(gg)
    gg
  }

  grobs <- list()

  grobs[["outline"]] <- gen_grob(points_outline, npts_outline, linecol="black")
  grobs[["reyebrow"]] <- gen_grob(points_r_eyebrow, npts_r_eyebrow, fillcol="grey", linecol="black")
  grobs[["leyebrow"]] <- gen_grob(points_l_eyebrow, npts_l_eyebrow, fillcol="grey", linecol="black")
  grobs[["reyelid"]] <- gen_grob(points_r_eyelid, npts_r_eyelid, linecol="black", open=TRUE)
  grobs[["leyelid"]] <- gen_grob(points_l_eyelid, npts_l_eyelid, linecol="black", open=TRUE)
  grobs[["rundereye"]] <- gen_grob(points_r_undereye, npts_r_undereye, linecol="black", open=TRUE)
  grobs[["lundereye"]] <- gen_grob(points_l_undereye, npts_l_undereye, linecol="black", open=TRUE)


  ## left eye
  grobs[["leye"]] <- gen_grob(points_l_eye[1:4,], 4, linecol="black", open=TRUE)
  grobs[["leye2"]] <- gen_grob(points_l_eye[c(1,6,5,4),], 4, linecol="black", shape=1, open=TRUE)

  #iris = [[points_r_eye([2 6],1); points_r_eye([5 3],1);
  # points_r_eye([2],1)] [points_r_eye([2 6],2); points_r_eye([5 3],2); points_r_eye([2],2)]];



  ## left iris
  l_iris = cbind(c(points_l_eye[c(2, 6),1],
                   points_l_eye[c(5, 3),1],
                   points_l_eye[c(2),1]),
                 c(points_l_eye[c(2, 6),2],
                   points_l_eye[c(5, 3),2],
                   points_l_eye[c(2),2]))


  grobs[["liris"]] <- gen_grob(l_iris[1:4,], 4, fillcol="grey", open=FALSE)

  # plot pupil & glint


  #plot(points_l_eye(7,1), -points_l_eye(7,2),'.','markersize',30,'color',outline_color);    %pupil
  #fill([points_l_eye(7,1) points_l_eye(7,1)+.04 points_l_eye(7,1)+.04 points_l_eye(7,1) points_l_eye(7,1)], ...
  #     [-points_l_eye(7,2) -points_l_eye(7,2) -points_l_eye(7,2)+.04 -points_l_eye(7,2)+.04 -points_l_eye(7,2)],color_iris);    %glint

  #plot([points_l_eye(7,1) points_l_eye(7,1)+.04 points_l_eye(7,1)+.04 points_l_eye(7,1) points_l_eye(7,1)], ...
  #     [-points_l_eye(7,2) -points_l_eye(7,2) -points_l_eye(7,2)+.04 -points_l_eye(7,2)+.04 -points_l_eye(7,2)],'color',color_iris);    %glint




  ## right eye
  grobs[["reye"]] <- gen_grob(points_r_eye[1:4,], 4,  open=TRUE)
  grobs[["reye2"]] <-gen_grob(points_r_eye[c(1,6,5,4),], 4, open=TRUE)


  ## right iris
  r_iris = cbind(c(points_r_eye[c(2, 6),1],
                   points_r_eye[c(5, 3),1],
                   points_r_eye[c(2),1]),
                 c(points_r_eye[c(2, 6),2],
                   points_r_eye[c(5, 3),2],
                   points_r_eye[c(2),2]))

  grobs[["riris"]] <- gen_grob(r_iris[1:4,], 4, fillcol="grey", open=FALSE)

  grobs[["lpupil"]] <- circleGrob(points_l_eye[7,1], -points_l_eye[7,2] - .035,
                                  default.units="native", r=.06, gp=gpar(fill="black"))
  grobs[["rpupil"]] <- circleGrob(points_r_eye[7,1], -points_r_eye[7,2] - .035,
                                  default.units="native", r=.06, gp=gpar(fill="black"))


  ## upper mouth
  points_mouth2 = points_mouth[c(6, 1, 2, 3, 10),]
  grobs[["uppermouth"]] <- gen_grob(points_mouth2, 5, open = TRUE)

  points_mouth2 = points_mouth[c(6, 8, 10),]
  grobs[["mouth2"]] <- gen_grob(points_mouth2, 3, open=TRUE)
  pm2 = points_mouth2


  points_mouth2 = points_mouth[c(6, 7, 4, 9, 10),]
  grobs[["mouth3"]] <-gen_grob(points_mouth2, 5, open=TRUE)

  tmp <- cbind(c(pm2[,1], points_mouth2[nrow(points_mouth2):1,1]),
               c(pm2[,2], points_mouth2[nrow(points_mouth2):1,2]))

  grobs[["mouth4"]] <- gen_grob(tmp[1:7,], 7, fillcol="grey", linecol="black", shape=1, open=FALSE)

  points_mouth2 = points_mouth[c(5,6), ]
  grobs[["mouth5"]] <- gen_grob(points_mouth2, 2, shape=0)
  points_mouth2 = points_mouth[c(10,11), ]
  grobs[["mouth6"]] <- gen_grob(points_mouth2, 2, shape=0)

  points_mouth2 = points_mouth[c(5,14,13,12,11),]
  points_mouth2[1,] = .5*points_mouth[5,] + .5*points_mouth[6,]
  points_mouth2[5,] = .5*points_mouth[10,] + .5*points_mouth[11,]

  grobs[["mouth7"]] <- gen_grob(points_mouth2, 5, open=TRUE)

  ### nose
  grobs[["nose"]] <- gen_grob(points_nose_tip, npts_nose_tip, open =TRUE)
  grobs[["lnostrils"]] <- gen_grob(points_nostrils[1:3,], 3, open =TRUE)
  grobs[["rnostrils"]] <- gen_grob(points_nostrils[4:6,], 3, open =TRUE)


  ## nose bridge
  grobs[["lnosebridge"]] <- gen_grob(points_nose_bridge[1:3,], 3, open=TRUE)
  grobs[["rnosebridge"]] <- gen_grob(points_nose_bridge[4:6,], 3, open=TRUE)

  ret <- list(
    grob=do.call(gList, grobs),
    spline_shape=spline_shape,
    face=face)

  class(ret) <- "face_spline"
  ret

}
