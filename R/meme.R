#' Initialize a MEME docker image
#'
#' Initializes a MEME docker image and calls specific methods
#'
#' @export
meme <- R6::R6Class("meme",
  inherit = biodevtools::biodev,
  public = list(
    image = "ddiez/meme",

    initialize = function(image = self$image, ...) {
      super$initialize(...)
      self$image <- image

      args <- paste("pull", self$image)
      system2(self$dockerbin, args)
    },

    meme = function(dataset = NULL, args = "", outdir = "meme_out", force_clean = TRUE, help = FALSE) {
      if (help || grepl("-h", args)) {
        args <- paste("run", self$image, "meme", "-h")
        system2(self$dockerbin, args)
      } else {
        if (is.null(dataset)) stop("argument 'dataset' is required.")

        if (force_clean)
          args <- paste("-oc", outdir, args)
        else
          args <- paste("-o", outdir, args)

        args <- paste("run", "-v", self$voldir, self$image, "meme", dataset, args)
        system2(self$dockerbin, args)
      }
    },

    fimo = function(motif = NULL, sequence = NULL, args = "", outdir = "fimo_out", force_clean = TRUE, help = FALSE) {
      if (help || grepl("-h", args)) {
        args <- paste("run", self$image, "fimo", "-h")
        system2(self$dockerbin, args)
      } else {
        if (force_clean)
          args <- paste("-oc", outdir, args)
        else
          args <- paste("-o", outdir, args)

        args <- paste("run", "-v", self$voldir, self$image, "fimo", args, motif, sequence)#, "2>", logfile)
        system2(self$dockerbin, args)
      }
    },

    tomtom = function(query = NULL, target = NULL, args = "", outdir = "tomtom_out", force_clean = TRUE, help = FALSE) {
      if (help || grepl("-h", args)) {
        args <- paste("run", self$image, "tomtom", "-h")
        system2(self$dockerbin, args)
      } else {
        if (force_clean)
          args <- paste("-oc", outdir, args)
        else
          args <- paste("-o", outdir, args)

        args <- paste("run", "-v", self$voldir, self$image, "tomtom", args, query, target)
        system2(self$dockerbin, args)
      }
    }

  ))
