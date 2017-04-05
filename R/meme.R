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
  inherit = biodevtools::biodev,
  public = list(
    image = "ddiez/meme",

    initialize = function(image = self$image, dir = getwd()) {
      super$initialize(...)
      self$image <- image

      cmd <- paste("docker pull", image)
      system(cmd)
    },

    meme = function(dataset = NULL, args = NULL, outdir = "meme_out", force_clean = TRUE) { #, logfile = "/dev/null") {
      if (force_clean)
        args <- paste("-oc", outdir, args)
      else
        args <- paste("-o", outdir, args)

      cmd <- paste(self$dockerbin, "run", "-v", self$voldir, self$image, "meme", dataset, args)#, "2>", logfile)
      system(cmd)
    },

    fimo = function(motif = NULL, sequence = NULL, args = NULL, outdir = "fimo_out", force_clean = TRUE) { #, logfile = "/dev/null") {
      if (force_clean)
        args <- paste("-oc", outdir, args)
      else
        args <- paste("-o", outdir, args)

      cmd <- paste(self$dockerbin, "run", "-v", self$voldir, self$image, "fimo", args, motif, sequence)#, "2>", logfile)
      system(cmd)
    },

    tomtom = function(query = NULL, target = NULL, args = NULL, outdir = "tomtom_out", force_clean = TRUE) { #, logfile = "/dev/null") {
      if (force_clean)
        args <- paste("-oc", outdir, args)
      else
        args <- paste("-o", outdir, args)

      cmd <- paste(self$dockerbin, "run", "-v", self$voldir, self$image, "tomtom", args, query, target)#, "2>", logfile)
      system(cmd)
    }

  ))
