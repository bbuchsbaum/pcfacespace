#' face pcs to xy coordinates
#'
#' convert face pc coefficients to xy face coordinates
#'
#' @param x a face represented by an 85 x 2 matrix
#' @export
#' @return an 85 x 2 matrix of face coordinates
pfd_pc_to_xy <- function(x) {
  data("pfd_data")
  avg_face2 <- pfd_data$avg_face[-c(37,44),]

  x2 <- x * pfd_data$std_scores
  fd1 <- x2 %*% t(pfd_data$pc)

  fd2 <- cbind(fd1[,1:(ncol(fd1)/2)],fd1[,(ncol(fd1)/2+1):ncol(fd1)])
  fd3 <- avg_face2 + fd2

  fd4 <- matrix(0, 85,2)
  fd4[1:36,] <- fd3[1:36,]
  fd4[37,] <- c(2,0)
  fd4[38:43,] <- fd3[37:42,]
  fd4[44,] <- c(0,0)
  fd4[45:85,] <- fd3[43:nrow(fd3),]

  fd4
}

#' generate a random face coordinate matrix from the pfd face space
#'
#' @param the number of leading principal components to fix at zero.
#' @return an 85 x 2 matrix of face coordinates
#' @export
#' @importFrom assertthat assert_that
gen_face <- function(coef=NULL, fixed_pcs=0) {
  if (is.null(coef)) {
    coef <- rnorm(166)
  } else {
    assert_that(length(coef) == 166)
  }

  if (fixed_pcs == 0) {
    pfd_pc_to_xy(coef)
  } else {
    rn <- coef
    rn[1:fixed_pcs] <- 0
    pfd_pc_to_xy(rn)
  }
}

#' make a random face from parametric face space
#'
#' generate a random face spline from the pfd face space
#'
#' @param the number of leading principal components to fix at zero.
#' @return an instance of class \code{face_spline}
#' @export
gen_face_spline <- function(coef=NULL, fixed_pcs=0) {
  ff <- gen_face(coef)
  pfd_splines(ff)
}



