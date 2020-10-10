#' @export
pfd_xy_to_pc <- function(x) {
  data("pfd_data")

  avg_face2 = pfd_data$avg_face
  avg_face2 <- avg_face2[-c(37,44),]


  x2 = x[c(1:36,38:43,45:85),]

  x3 = x2 - avg_face2
  x4 = c(x3[,1], x3[,2])
  x5 = x4 %*% t(solve(pfd_data$pc))
  x6 = x5/pfd_data$std_score;

  x6
}

