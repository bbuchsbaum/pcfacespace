library(rmatio)


pfd_all_faces <- rmatio::read.mat("data-raw/pfd_all_faces.mat")[[1]]
#usethis::use_data(pfd_all_faces, overwrite=TRUE)

pfd_avg_face <- rmatio::read.mat("data-raw/pfd_avg_face.mat")[[1]]
#usethis::use_data(pfd_avg_face, overwrite=TRUE)

pfd_pc <- rmatio::read.mat("data-raw/pfd_pc.mat")[[1]]
#usethis::use_data(pfd_pc, overwrite=TRUE)

pfd_score <- rmatio::read.mat("data-raw/pfd_score.mat")[[1]]
#usethis::use_data(pfd_score, overwrite=TRUE)

pfd_std_score <- rmatio::read.mat("data-raw/pfd_std_score.mat")[[1]]
#usethis::use_data(pfd_std_score, overwrite=TRUE)

pfd_demo <- as.data.frame(rmatio::read.mat("data-raw/pfd_demographics.mat")[[1]])
names(pfd_demo) <- c("id", "pop", "sex", "age")

pfd_data <- list(
  all_faces=pfd_all_faces,
  avg_face=pfd_avg_face,
  pc=pfd_pc,
  scores=pfd_score,
  std_scores=pfd_std_score,
  demographics=pfd_demo
)

usethis::use_data(pfd_data, overwrite=TRUE)
