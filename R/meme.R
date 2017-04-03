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
