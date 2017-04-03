#' Initialize a MEME docker image
#'
#' Initializes a MEME docker image and calls specific methods
#'
#' @usage
#' meme$new()
#'
#' @examples
#' h <- meme$new()
#' h$image
#' h$outdir
#' h$meme("sequences.fa")
#'
#' @export
meme <- R6::R6Class("meme",
  public = list(
    image = "ddiez/meme",
    outdir = ".",
    homedir = NULL,
    voldir = NULL,
    dockerbin = "docker",

    initialize = function(image = self$image, dir = getwd()) {
      cmd <- paste("docker pull", image)
      system(cmd)

      self$image <- image
      self$homedir <- dir
      self$voldir <- paste0(self$homedir, ":", "/home/biodev")
    },

    meme = function(dataset = NULL, args = NULL, outfile = "meme_out", logfile = "/dev/null") {
      cmd <- paste(self$dockerbin, "run", "-v", self$voldir, self$image, "meme", dataset, args, "1>", logfile)
      system(cmd)
    }

  ))
